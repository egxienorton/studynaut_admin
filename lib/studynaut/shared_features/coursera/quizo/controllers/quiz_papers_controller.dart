import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';
import 'package:localstore/localstore.dart';

import '../../../BLOC/auth_controller.dart';
import '../enums/loading_status.dart';
import '../models/quiz_paper_model.dart';
import '../screens/quiz_screen.dart';
import '../utils/logger.dart';
import '../utils/references.dart';

// import 'package:sqflite/sqflite.dart';
// import 'package:studymaze/BLOC/AUTH/authController.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/models/quiz_paper_model.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/quiz_paper/micro_controllers/quiz_controller.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/quiz_paper/quiz_screen.dart';
// import 'package:studymaze/UTILITIES/references.dart';
// import 'package:studymaze/UTILITIES/enums/loading_status.dart';
// import 'package:studymaze/UTILITIES/logger.dart';

class LocalQuizPaperController extends GetxController {
  final jsonStore = JsonStore(dbName: 'formidable-academy');
  var _db = Localstore.instance;
  StreamSubscription<Map<String, dynamic>>? _subscription;
  @override
  void onReady() {
    print('controller deployed');
    getAllPapers(
      'EWO 111',
      'Fluids',
      'moduleUnit',
      'beginner',
    );
    FlutterWindowManager.FLAG_SECURE;
    // loadFromStorage();
    super.onReady();
  }

  // Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  //   print('--- Parse json from: $assetsPath');
  //   return rootBundle
  //       .loadString(assetsPath)
  //       .then((jsonStr) => jsonDecode(jsonStr));
  // }

  saveQuestionsToAirBase({
    required String courseName,
    required String chapterName,
    required String moduleUnit,
    required String difficultyLevel,
    // required QuizPaperModel paper,
  }) async {
    // paper.saveQuiz(courseName, chapterName, difficultyLevel, moduleUnit);
//...its a penalty
// save all questions...

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //seperate quiz json files
    final papersInAsset = manifestMap.keys
        .where(
            (path) => path.startsWith('assets/md5/') && path.contains('.json'))
        .toList();

    // var adata = parseJsonFromAssets('assets/md5/physics.json');

    // print(adata);

    print('Discovered one file');

    final List<QuizPaperModel> quizPapers = [];

    for (var paper in papersInAsset) {
      //read content of papers(json files)
      String stringPaperContent = await rootBundle.loadString(paper);
      print(stringPaperContent);
      //add data to model
      quizPapers.add(QuizPaperModel.fromString(stringPaperContent));
      print('paper added');
    }

    print('pls wait while your transation is processing');
    for (var paper in quizPapers) {
      _db
          .collection('courses')
          .doc(courseName)
          .collection(chapterName)
          .doc('module units')
          .collection(moduleUnit)
          .doc('exercises')
          .collection(difficultyLevel)
          .doc('data')
          // .collection('questions')
          // .doc(paper.title)
          .set(
        {
          "title": paper.title,
          "idea": paper.id,
          "courseName": courseName,
          "moduleUnit": moduleUnit,
          "chapterName": chapterName,
          "difficultyLevel": difficultyLevel,
          "image_url": paper.imageUrl,
          "Description": paper.description,
          "time_seconds": paper.timeSeconds,
          "questions_count":
              paper.questions == null ? 0 : paper.questions!.length
        },
      );

      print(paper.title);
      for (var questions in paper.questions!) {
        // final questionPath =
        //     questionsFR(paperId: paper.id, questionsId: questions.id);

        _db
            .collection('courses')
            .doc(courseName)
            .collection(chapterName)
            .doc('module units')
            .collection(moduleUnit)
            .doc('exercises')
            .collection(difficultyLevel)
            .doc('data')
            .collection('questions')
            .doc(questions.id)
            // .collection(paper.title)
            // .doc('data')
            .set({
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        print('stage 2');

        for (var answer in questions.answers) {
          _db
              .collection('courses')
              .doc(courseName)
              .collection(chapterName)
              .doc('module units')
              .collection(moduleUnit)
              .doc('exercises')
              .collection(difficultyLevel)
              .doc('data')
              .collection('questions')
              .doc(questions.id)
              .collection('answers')
              .doc(answer.identifier)
              .set({"identifier": answer.identifier, "answer": answer.answer});
        }
      }

      print('stage 3');

      for (var questions in paper.questions!) {
        _db
            .collection('courses')
            .doc(courseName)
            .collection(chapterName)
            .doc('module units')
            .collection(moduleUnit)
            .doc('exercises')
            .collection(difficultyLevel)
            .doc('data')
            .collection('questions')
            .doc(questions.id)
            .set(questions.toJson());

        print('stage 4');

        for (var answer in questions.answers) {
          _db
              .collection('courses')
              .doc(courseName)
              .collection(chapterName)
              .doc('module units')
              .collection(moduleUnit)
              .doc('exercises')
              .collection(difficultyLevel)
              .doc('data')
              .collection('questions')
              .doc(questions.id)
              .collection('answers')
              .doc(answer.identifier)
              .set(answer.toJson());

          print('done deed');
        }
      }
    }

    // now the answers

    //also the assets bitch!! download them

    //finally create a decent method to automate all of this with try catch progress and auto continue
    // aggressive download from firestorage on course/chapter/modules/questions or wait a second how about all the assets in one directory, will it affect the download and indexing

    // allPapers.value.forEach((element) {});
  }

  installToLDB() {
    saveQuestionsToAirBase(
      courseName: 'EWO 111',
      chapterName: 'Fluids',
      difficultyLevel: 'beginner',
      moduleUnit: 'moduleUnit',
      // paper: paper
    );
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  loadFromStorage() async {
    print('loading');
    List<Map<String, dynamic>>? json = await JsonStore().getListLike('Paper-%');

    List<QuizPaperModel> result = json != null
        ? json.map((paperJson) => QuizPaperModel.fromJson(paperJson)).toList()
        : [];
    allPapers.addAll(result);
    print(result);
    print('done');
  }

  saveQuestionsToAirBase1() async {
    allPapers.value.forEach((element) {});
  }

  // List<Question> getQuestions(String courseName, String chapterName,
  //     String moduleUnit, String difficultyLevel) {
  //   List<Question> allQuestions = [Question(id: 'ew', question: 'WHat day is hood ', answers: answers)];
  //   try {
  //     final data = _db
  //         .collection('courses')
  //         .doc(courseName)
  //         .collection(chapterName)
  //         .doc('module units')
  //         .collection(moduleUnit)
  //         .doc('exercises')
  //         .collection(difficultyLevel)
  //         .doc('data')
  //         .collection('question')
  //         .get();

  //     return allQuestions;
  //   } catch (e) {}
  // }

  getAllPapers(String courseCode, String chapterName, String moduleUnit,
      String difficultyLevel) async {
    try {
      print('checking local database');
      var paperList;

      final data = _db
          .collection('courses')
          .doc(courseCode)
          .collection(chapterName)
          .doc('module units')
          .collection(moduleUnit)
          .doc('exercises')
          .collection(difficultyLevel)
          .doc('data')
          .get()
          .then(
        (value) {
          print(value);

          if (value != null) {
            allPapers.add(QuizPaperModel.fromJson(value));
          } else {
            Get.snackbar('No Questions were found for this level', 'message');
          }

          // Map aint go work for this list
          // chapters.forEach((element) {
          //   // var res = CourseChapter.fromMap(element);

          //   // print(res.chapterName);
          // }

          // );
        },
      );
      // _subscription = _db
      //       .collection('courses')
      //       .doc(courseName)
      //       .collection(chapterName)
      //       .doc('module units')
      //       .collection(moduleUnit)
      //       .doc('exercises')
      //       .collection(difficultyLevel)
      //       .doc('data')

      //      .stream.listen((event) {
      //     final item = QuizPaperModel.fromJson(event);
      //     _items.putIfAbsent(item.courseName, () => item);

      // });
      // var items = data;

      // Map<String,String> myMap = Map.from( data );

      // paperList = QuizPaperModel.fromJson(items);
      //     .then((value) {
      //   if (value != null) {
      //     print(value);
      //     // value.map((key, value) => null);
      //     // paperList = QuizPaperModel.fromJson(value);
      //     // allPapers.add(paperList);
      //   } else {
      //     print(value);
      //   }
      // });

      // print(data);

      // await data.map((paper) => QuizPaperModel.fromJson(paper)).toList();

      // allPapers.assignAll(paperList);

      // this is the bomber for json_store

      // saveToStorageWithBatch();

      // for (var paper in paperList) {
      //   final imageUrl =
      //       await Get.find<FireBaseStorageService>().getImage(paper.title);
      //   paper.imageUrl = imageUrl;
      // }
      // allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  // Future<void> getAllPapers() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> data = await quizePaperFR.get();
  //     final paperList =
  //         data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
  //     // allPapers.assignAll(paperList);

  //     // this is the bomber for json_store
  //     saveToStorageWithBatch();

  //     // for (var paper in paperList) {
  //     //   final imageUrl =
  //     //       await Get.find<FireBaseStorageService>().getImage(paper.title);
  //     //   paper.imageUrl = imageUrl;
  //     // }
  //     allPapers.assignAll(paperList);
  //   } catch (e) {
  //     AppLogger.e(e);
  //   }
  // }

  // this method above will be patched

  void navigatoQuestions(
      {required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    Get.toNamed(
      QuizeScreen.routeName,
      arguments: paper,
    );

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();

        Get.offNamed(QuizeScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: paper);
      }
    } else {
      // _authController.showLoginAlertDialog();
      Get.snackbar('show login alert dialog ', 'from auth service');
    }
  }

  saveToStorageWithBatch() async {
    var start = DateTime.now().millisecondsSinceEpoch;
    // It's always better to use the Batch in this case as its way more performant

    allPapers.value.forEach((paper) async {
      await JsonStore().setItem(
        'Paper-${paper.id}',
        paper.toJson(),
        encrypt: true,
      );
    });

    var end = DateTime.now().millisecondsSinceEpoch;
    print(
        'G-Sync stored ${allPapers.value.length} question papers in a Batch: ${end - start}ms');
  }
  // re
}

class QuizPaperController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final jsonStore = JsonStore(dbName: 'sampleapp2');
  var _db = Localstore.instance;
  @override
  void onReady() {
    getAllPapers();

    // loadFromStorage();
    super.onReady();
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  loadFromStorage() async {
    print('loading');
    List<Map<String, dynamic>>? json = await JsonStore().getListLike('Paper-%');

    List<QuizPaperModel> result = json != null
        ? json.map((paperJson) => QuizPaperModel.fromJson(paperJson)).toList()
        : [];
    allPapers.addAll(result);
    print(result);
    print('done');
  }

  Future<void> getAllPapers() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      QuerySnapshot<Map<String, dynamic>> data = await quizePaperFR.get();
      final paperList =
          data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
      // allPapers.assignAll(paperList);

      // this is the bomber for json_store
      saveToStorageWithBatch();

      // for (var paper in paperList) {
      //   final imageUrl =
      //       await Get.find<FireBaseStorageService>().getImage(paper.title);
      //   paper.imageUrl = imageUrl;
      // }
      allPapers.assignAll(paperList);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      AppLogger.e(e);
    }
  }

  // this method above will be patched

  void navigatoQuestions(
      {required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(QuizeScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: paper);
      }
    } else {
      // _authController.showLoginAlertDialog();
      Get.snackbar('login alert dialog', 'implement');
    }
  }

  saveToStorageWithBatch() async {
    var start = DateTime.now().millisecondsSinceEpoch;
    // It's always better to use the Batch in this case as its way more performant

    allPapers.value.forEach((paper) async {
      await JsonStore().setItem(
        'Paper-${paper.id}',
        paper.toJson(),
        encrypt: true,
      );

      // paper.saveQuiz('ECO 111', 'Boolean Arithmetic', 'beginner', 'moduleUnit');
    });

    var end = DateTime.now().millisecondsSinceEpoch;
    print(
        'Formidable bot stored ${allPapers.value.length} question papers in a Batch: ${end - start}ms');
  }

  saveOneWithBatch(int index) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    // It's always better to use the Batch in this case as its way more performant
    final paper = allPapers[index];
    // final cacheBuild = allPapers[index].toJson();
    await JsonStore().setItem(
      'Paper-${paper.id}',
      paper.toJson(),
      encrypt: true,
    );
    Get.snackbar('let\'s see how this plays out', 'hmm');
    // paper.saveQuiz('ECO 111', 'Boolean Arithmetic', 'beginner', 'moduleUnit');

    // saveQuestionsToAirBase(
    //   courseName: 'ECO 111',
    //   chapterName: 'Fluids',
    //   difficultyLevel: 'beginner',
    //   moduleUnit: 'moduleUnit',
    //   // paper: paper
    // );
    var end = DateTime.now().millisecondsSinceEpoch;
    print(
        'G-Sync stored ${paper.id} question papers in a Batch: ${end - start}ms');
  }
}
