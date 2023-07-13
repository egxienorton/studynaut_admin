import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';
import 'package:studynautz/BLOC/auth_controller.dart';
import 'package:localstore/localstore.dart';
// import 'package:quizzle/controllers/auth_controller.dart';
// import 'package:quizzle/firebase/firebase_configs.dart';
// import 'package:quizzle/models/models.dart';
// import 'package:quizzle/screens/screens.dart';
// import 'package:quizzle/utils/logger.dart';
// import 'package:quizzle/widgets/dialogs/dialogs.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:studymaze/BLOC/AUTH/authController.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/models/quiz_paper_model.dart';
// import 'package:studymaze/UTILITIES/references.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/quiz_paper/result_screen.dart';
// import 'package:studymaze/UTILITIES/dialogs/vDialogs.dart';
// import 'package:studymaze/UTILITIES/enums/loading_status.dart';
// import 'package:studymaze/UTILITIES/logger.dart';

import '../enums/loading_status.dart';
import '../models/quiz_paper_model.dart';
import '../screens/result_screen.dart';
import '../utils/logger.dart';
import '../utils/references.dart';
import '../utils/vDialogs.dart';
import 'quiz_papers_controller.dart';

class QuizController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestions = <Question>[];
  late QuizPaperModel quizPaperModel;
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;
  final jsonStore = JsonStore(dbName: 'sampleapp2');
  var _db = Localstore.instance;

  @override
  void onReady() {
    final _quizePaprer = Get.arguments as QuizPaperModel;
    Get.snackbar(_quizePaprer.toJson().toString(), 'Whatdou');
    print('Here it is sir');
    final questionsQBank = _db
        .collection('courses')
        .doc(_quizePaprer.courseName)
        .collection(_quizePaprer.chapterName!)
        .doc('module units')
        .collection(_quizePaprer.moduleUnit!)
        .doc('exercises')
        .collection(_quizePaprer.difficultyLevel!)
        .doc('data')
        .collection('questions')
        .get()
        .then((value) {
      // print(value);

      if (value != null) {
        print(value);
        // quizPaper.questions!.add(Question.fromJson(value));
      }
    });
    loadData(_quizePaprer); // are you sure you wanna freeze this guy
    // saveToStorageWithBatch(_quizePaprer);
    // loadFromStorage(_quizePaprer);
    super.onReady();
    // FlutterWindowManager.FLAG_SECURE;
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<bool> onExitOfQuiz() async {
    return Dialogs.quizEndDialog();
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          timer.cancel();
        } else {
          int minutes = remainSeconds ~/ 60;
          int seconds = (remainSeconds % 60);
          time.value = minutes.toString().padLeft(2, "0") +
              ":" +
              seconds.toString().padLeft(2, "0");
          remainSeconds--;
        }
      },
    );
  }

//   loadFromStorage(_quizePaprer) async {
//     loadingStatus.value = LoadingStatus.loading;
//     print('loading');

//     List<Map<String, dynamic>>? json =
//         await JsonStore().getListLike('${_quizePaprer.id}-Question-%');

//     List<Question> result = json != null
//         ? json.map((questionJson) => Question.fromJson(questionJson)).toList()
//         : [];
//     allQuestions.addAll(result);
//     // result.forEach((element) {
//     //   print(element.question);
//     //   print(element.correctAnswer);
//     //   print(element.answers);
//     // });
//     print(result);
//     print(allQuestions);
//     print('done');

//     allQuestions.assignAll(result);
//     print(allQuestions);
//     quizPaperModel = _quizePaprer;
//     // currentQuestion.value = allQuestions[0]; //this line is not working yet
//     _startTimer(_quizePaprer.timeSeconds);
//     // loadingStatus.value = LoadingStatus.completed;

// ///////////////////////// the following line was invocked
  // if (_quizePaprer.questions != null && _quizePaprer.questions!.isNotEmpty) {
  //   allQuestions.assignAll(_quizePaprer.questions!);
  //   currentQuestion.value = _quizePaprer.questions![0];
  //   _startTimer(_quizePaprer.timeSeconds);
  //   loadingStatus.value = LoadingStatus.completed;
  // } else {
  //   loadingStatus.value = LoadingStatus.noReult;
  // }
  // loadingStatus.value = LoadingStatus.completed;
  // _quizePaprer.questions.addAll(allQuestions);
  // print('fetching');
  // print(_quizePaprer.questions);

//     /////////////////////////////////////////////
//   }

  void loadData(QuizPaperModel quizPaper) async {
    quizPaperModel = quizPaper;

    loadingStatus.value = LoadingStatus.loading;
    // this is where the handshake happens.. watch out the model methodology
    try {
      // this is the line where the main thing
      // final QuerySnapshot<Map<String, dynamic>> questionsQuery =
      //     await quizePaperFR.doc(quizPaper.id).collection('questions').get();

      final questionsQBank = _db
          .collection('courses')
          .doc(quizPaper.courseName)
          .collection(quizPaper.chapterName!)
          .doc('module units')
          .collection(quizPaper.moduleUnit!)
          .doc('exercises')
          .collection(quizPaper.difficultyLevel!)
          .doc('data')
          .collection('questions')
          .get()
          .then((value) {
        // print(value);

        if (value != null) {
          List<Question> fetchedQuetsions = [];
          // value.map((key, value) => fetchedQuetsions.add({key: value}));
          value.forEach((k, v) => fetchedQuetsions
              .add(Question.fromJson(v))); // you nailed it here !!!!!!!!!!!!
          print(fetchedQuetsions);

          // fetchedQuetsions.add(value);

          fetchedQuetsions
              .map((e) => quizPaper.questions!.add(Question.fromJson(value)));
          // quizPaper.questions!.add(Question.fromJson(value));

          quizPaper.questions!.addAll(fetchedQuetsions);
        }
      });

      // final questions = questionsQBank
      //     .map((question) => Question.fromJson(question))
      //     .toList();
      // quizPaper.questions = questions;

      for (Question _question in quizPaper.questions!) {
        // final QuerySnapshot<Map<String, dynamic>> answersQuery =
        //     await quizePaperFR
        //         .doc(quizPaper.id)
        //         .collection('questions')
        //         .doc(_question.id)
        //         .collection('answers')
        //         .get();

        final answerINeed = _db
            .collection('courses')
            .doc(quizPaper.courseName)
            .collection(quizPaper.chapterName!)
            .doc('module units')
            .collection(quizPaper.moduleUnit!)
            .doc('exercises')
            .collection(quizPaper.difficultyLevel!)
            .doc('data')
            .collection('questions')
            .doc(_question.id)
            .collection('answers')
            .get()
            .then((value) {
          if (value != null) {
            print(value);
            _question.answers.add(Answer.fromJson(value));
          } else {}
        });

        // final answers = answersQuery.docs
        //     .map((answer) => Answer.fromSnapshot(answer))
        //     .toList();
        // _question.answers = answers;
      }
      // saveToStorageWithBatch(quizPaper);
    } on Exception catch (e) {
      RegExp exp = RegExp(
        r'permission-denied',
        caseSensitive: false,
      );
      if (e.toString().contains(exp)) {
        AuthController _authController = Get.find();
        Get.back();
        Get.dialog(
          Dialogs.quizStartDialog(onTap: () {
            Get.back();
            // navigateToLogin();
          }),
          barrierDismissible: false,
        );
      }
      AppLogger.e(e);
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }

    if (quizPaper.questions != null && quizPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(quizPaper.questions!);
      currentQuestion.value = quizPaper.questions![0];
      _startTimer(quizPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.noReult;
    }
  }

  Rxn<Question> currentQuestion = Rxn<Question>();
  final questionIndex = 0.obs; //_curruntQuestionIndex

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get islastQuestion => questionIndex.value >= allQuestions.length - 1;

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) {
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void selectAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  String get completedQuiz {
    final answeredQuestionCount = allQuestions
        .where((question) => question.selectedAnswer != null)
        .toList()
        .length;
    return '$answeredQuestionCount out of ${allQuestions.length} answered';
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<LocalQuizPaperController>()
        .navigatoQuestions(paper: quizPaperModel, isTryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.snackbar('should navigate', 'home');
    // Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }

  saveToStorageWithBatch(_quizePaprer) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    // It's always better to use the Batch in this case as its way more performant
    Batch batch = await JsonStore().startBatch();

    allQuestions.forEach((question) async {
      await JsonStore().setItem(
        '${_quizePaprer.id}-Question-${question.id}',
        question.toJson(),
        batch: batch,
        encrypt: true,
      );

      print('It is finished!!! ');
    });

    List<Map<String, dynamic>>? json =
        await JsonStore().getListLike('${_quizePaprer.id}-Question-%');

    List<Question> result = json != null
        ? json.map((questionJson) => Question.fromJson(questionJson)).toList()
        : [];
    allQuestions.addAll(result);

    print(result);
    result.forEach((element) {
      print(element.question);
      print(element.correctAnswer);
      print(element.answers);
    });
    print('done');

    await JsonStore().commitBatch(batch);
    var end = DateTime.now().millisecondsSinceEpoch;
    print(
        'RBX SSD got ${allQuestions.length} question papers in a Batch: ${end - start}ms');
  }
}

class QuizMicroController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final allQuestions = <Question>[];
  late QuizPaperModel quizPaperModel;
  // late QuizPaperModel xquizPaperModel;
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;
  final jsonStore = JsonStore(dbName: 'sampleapp2');

  // @override
  // void onReady() {
  //   // final _quizePaprer = Get.arguments as QuizPaperModel;
  //   // final _quizePaprer = quizPaperModel as QuizPaperModel;

  //   // loadData(_quizePaprer);
  //   saveToStorageWithBatch(_quizePaprer);
  //   // loadFromStorage(_quizePaprer);
  //   super.onReady();
  // }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<bool> onExitOfQuiz() async {
    return Dialogs.quizEndDialog();
  }

  // void _startTimer(int seconds) {
  //   const duration = Duration(seconds: 1);
  //   remainSeconds = seconds;
  //   _timer = Timer.periodic(
  //     duration,
  //     (Timer timer) {
  //       if (remainSeconds == 0) {
  //         timer.cancel();
  //       } else {
  //         int minutes = remainSeconds ~/ 60;
  //         int seconds = (remainSeconds % 60);
  //         time.value = minutes.toString().padLeft(2, "0") +
  //             ":" +
  //             seconds.toString().padLeft(2, "0");
  //         remainSeconds--;
  //       }
  //     },
  //   );
  // }

  // loadFromStorage(_quizePaprer) async {
  //   loadingStatus.value = LoadingStatus.loading;
  //   print('loading');
  //   List<Map<String, dynamic>>? json =
  //       await JsonStore().getListLike('${_quizePaprer.id}-Question-%');

  //   List<Question> result = json != null
  //       ? json.map((questionJson) => Question.fromJson(questionJson)).toList()
  //       : [];
  //   allQuestions.addAll(result);
  //   // result.forEach((element) {
  //   //   print(element.question);
  //   //   print(element.correctAnswer);
  //   //   print(element.answers);
  //   // });
  //   print(result);
  //   print(allQuestions);
  //   print('done');
  //   if (_quizePaprer.questions != null && _quizePaprer.questions!.isNotEmpty) {
  //     allQuestions.assignAll(_quizePaprer.questions!);
  //     currentQuestion.value = _quizePaprer.questions![0];
  //     _startTimer(_quizePaprer.timeSeconds);
  //     loadingStatus.value = LoadingStatus.completed;
  //   } else {
  //     loadingStatus.value = LoadingStatus.noReult;
  //   }
  //   // loadingStatus.value = LoadingStatus.completed;
  //   _quizePaprer.questions.addAll(allQuestions);
  //   print('fetching');
  //   print(_quizePaprer.questions);
  // }

  void loadData(QuizPaperModel quizPaper) async {
    quizPaperModel = quizPaper;
    // loadingStatus.value = LoadingStatus.loading;
    // this is where the handshake happens.. watch out the model methodology
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await quizePaperFR.doc(quizPaper.id).collection('questions').get();
      final questions = questionsQuery.docs
          .map((question) => Question.fromSnapshot(question))
          .toList();
      quizPaper.questions = questions;

      for (Question _question in quizPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await quizePaperFR
                .doc(quizPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answer.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
      // saveToStorageWithBatch(quizPaper); the other way round
    }
    // on Exception catch (e) {
    //   RegExp exp = RegExp(
    //     r'permission-denied',
    //     caseSensitive: false,
    //   );
    //   if (e.toString().contains(exp)) {
    //     AuthController _authController = Get.find();
    //     Get.back();
    //     _authController.showLoginAlertDialog();
    //   }
    //   AppLogger.e(e);
    //   loadingStatus.value = LoadingStatus.error;
    // }
    catch (e) {
      // loadingStatus.value = LoadingStatus.error;
      Get.snackbar('an error occured', 'We will resolved this asap');
      AppLogger.e(e);
    }

    if (quizPaper.questions != null && quizPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(quizPaper.questions!);
      // currentQuestion.value = quizPaper.questions![0];
      // _startTimer(quizPaper.timeSeconds);
      // loadingStatus.value = LoadingStatus.completed;
    } else {
      // loadingStatus.value = LoadingStatus.noReult;
    }
  }

  Rxn<Question> currentQuestion = Rxn<Question>();
  final questionIndex = 0.obs; //_curruntQuestionIndex

  saveToStorageWithBatch(QuizPaperModel _quizePaprer) async {
    loadData(_quizePaprer);
    print('Please wait while your transaction is processing');
    var start = DateTime.now().millisecondsSinceEpoch;
    // It's always better to use the Batch in this case as its way more performant
    Batch batch = await JsonStore().startBatch();
    print(allQuestions.map((e) => e.question));
    allQuestions.forEach((question) async {
      await JsonStore().setItem(
        '${_quizePaprer.id}-Question-${question.id}',
        question.toJson(),
        // jsonDecode(quests),
        batch: batch,
        encrypt: true,
      );

      print('It is finished!!! ');
    });

    List<Map<String, dynamic>>? json =
        await JsonStore().getListLike('${_quizePaprer.id}-Question-%');

    List<Question> result = json != null
        ? json.map((questionJson) => Question.fromJson(questionJson)).toList()
        : [];
    allQuestions.addAll(result);

    print(result);
    result.forEach((element) {
      print(element.question);
      print(element.correctAnswer);
      print(element.answers);
    });
    print('done');

    await JsonStore().commitBatch(batch);
    var end = DateTime.now().millisecondsSinceEpoch;
    print(
        'RBX SSD got ${allQuestions.length} question papers in a Batch: ${end - start}ms');
  }
}
