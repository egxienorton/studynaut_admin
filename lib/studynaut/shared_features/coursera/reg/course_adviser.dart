import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:localstore/localstore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studynautz/BLOC/auth_controller.dart';

import 'data_cylinder_models.dart';

class CourseAdviser extends GetxController {
  Rx<List<CourseItemModel>> onlineCourselist = Rx<List<CourseItemModel>>([]);
  Rx<List<CourseChapter>> chapList = Rx<List<CourseChapter>>([]);
  Rx<List<CourseItemModel>> selectedCourses = Rx<List<CourseItemModel>>([]);
  Rx<String> keygenLinks = ''.obs;

  AuthController authController = Get.find<AuthController>();

  var totalCredits = 0.obs;

  final firestore = FirebaseFirestore.instance;
  // final userFR = fi.collection('colleges');

  // Rx<List<Course>> onlineCourses = Rx<List<Course>>([]);

  List<CourseItemModel> get listOfOnlineCourses => onlineCourselist.value;
  var isLoading = true.obs;

  var db = Localstore.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // refreshCourses();
  }

  Future<String> returnAUrl(String urlParam, String fileName) async {
    Completer<File> completer = Completer();
    File file;
    // print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = urlParam;
      // final filename = url.substring(url.lastIndexOf("/") + 1);
      final filename = fileName;
      Get.defaultDialog(
          radius: 5.0,
          title: "Downloading ${fileName}",
          titlePadding: const EdgeInsets.all(18),
          titleStyle: const TextStyle(fontFamily: 'Product Sans'),
          barrierDismissible: false,
          content: LoadingAnimationWidget.halfTriangleDot(
            color: Colors.deepPurpleAccent,
            size: 50,
          ),
          contentPadding: const EdgeInsets.all(20));
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // look very carefully here abeg for the crypto stuff
      print("Download files");
      print("${dir.path}/$filename");

      keygenLinks.value = "${dir.path}/$filename";

      // var linker = "${dir.path}/$filename";
      file = File("${dir.path}/$filename");

      Get.snackbar('You just downloaded this file.. ', keygenLinks.value);

      print('file url: $keygenLinks');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      Get.back();

      completer.future; // this stuff was being returned before now
    } catch (e) {
      // you may wanna use a downloader to clean up incomplete downloads
      Get.snackbar(
          'A download couldn\'t happen', 'Check your connection and try again');
      throw Exception('Error parsing asset file!');
    }

    // return completer.future;
    return "${file.path}";
  }

  Future<File> saveFileToStore(String urlParam, String fileName) async {
    Completer<File> completer = Completer();
    // print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = urlParam;
      // final filename = url.substring(url.lastIndexOf("/") + 1);
      final filename = fileName;
      Get.defaultDialog(
          radius: 5.0,
          title: "Downloading ${fileName}",
          titlePadding: const EdgeInsets.all(18),
          titleStyle: const TextStyle(fontFamily: 'Product Sans'),
          barrierDismissible: false,
          content: LoadingAnimationWidget.halfTriangleDot(
            color: Colors.deepPurpleAccent,
            size: 50,
          ),
          contentPadding: const EdgeInsets.all(20));
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // look very carefully here abeg for the crypto stuff
      print("Download files");
      print("${dir.path}/$filename");

      keygenLinks.value = "${dir.path}/$filename";

      // var linker = "${dir.path}/$filename";
      File file = File("${dir.path}/$filename");

      Get.snackbar('You just downloaded this file.. ', keygenLinks.value);

      print('file url: $keygenLinks');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      Get.back();
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> createFileOfPdfUrl(String urlParam, String fileName) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = urlParam;
      // final filename = url.substring(url.lastIndexOf("/") + 1);
      final filename = fileName;
      Get.defaultDialog(
          radius: 5.0,
          title: "Downloading ${fileName}",
          titlePadding: const EdgeInsets.all(18),
          titleStyle: const TextStyle(fontFamily: 'Product Sans'),
          barrierDismissible: false,
          content: LoadingAnimationWidget.halfTriangleDot(
            color: Colors.deepPurpleAccent,
            size: 50,
          ),
          contentPadding: const EdgeInsets.all(20));
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      // look very carefully here abeg for the crypto stuff
      print("Download files");
      print("${dir.path}/$filename");

      keygenLinks.value = "${dir.path}/$filename";

      // var linker = "${dir.path}/$filename";
      File file = File("${dir.path}/$filename");

      Get.snackbar('You just downloaded this file.. ', keygenLinks.value);

      print('keygen: $keygenLinks');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  updateCourseProgress(CourseItemModel courseItem, int newProgress) async {
    final newCourse = CourseItemModel(
        courseName: courseItem.courseName,
        courseCode: courseItem.courseName,
        courseCredit: courseItem.courseName,
        courseDescription: courseItem.courseName,
        overallProgress: newProgress,
        initialized: courseItem.initialized);

    newCourse.updateProgress(newCourse.courseName, newProgress);
  }

  kickStartCourse(CourseItemModel courseItem) async {
    final newCourse = CourseItemModel(
        courseName: courseItem.courseName,
        courseCode: courseItem.courseCode,
        courseCredit: courseItem.courseName,
        courseDescription: courseItem.courseName,
        overallProgress: courseItem.overallProgress,
        initialized: true);
    Get.snackbar('kick starting', 'message');
    newCourse.initializeCourse(newCourse.courseCode);
  }

  // acceptTerms(String courseName) {
  //   db
  //       .collection('courses')
  //       .doc(courseName)
  //       .collection('metadata')
  //       .doc('progress')
  //       .set({'initialized': true, 'tracker': 70});

  //   print('updating ${courseName}');

  //   print("'done'");
  // }

  int retrieveUserProgress(String courseCode) {
    late var snapshot = {};
    var data = db
        .collection('courses')
        .doc(courseCode)
        .collection('metadata')
        .doc('progress')
        .get()
        .then((value) {
      if (value != null) {
        int howFar = value['tracker'];
        // print(value);

        print('${howFar} was gotten from ${courseCode}');

        snapshot = {...value};

        print(snapshot);
      } else {}
    });

    if (data != null) {
      // int howFar = snapshot['tracker'];
      // print(snapshot);

      return snapshot['tracker'] ?? 65;
    } else {
      return 20;
    }
  }

  Future acceptCourse(String courseName) async {
    chapList.bindStream(
        chapterStream(authController.superUser.value.institution, courseName));
  }

  Future refreshCourses() async {
    onlineCourselist
        .bindStream(courseStream(authController.superUser.value.institution));

    // print(onlineCourselist);
  }

  @override
  void dispose() {
    // CourseraDB.instance.close();
    super.dispose();
  }

  Stream<List<CourseItemModel>> courseStream(String uid) {
    return firestore
        .collection('colleges')
        .doc(uid)
        .collection('curriculum')
        .where('level', isEqualTo: '200')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<CourseItemModel> retVal = [];
      print('hold up while we retrieve your courses from kofa');
      query.docs.forEach((element) {
        retVal.add(CourseItemModel.fromDocumentSnapshot(element));
        print(element);
      });

      onlineCourselist.value.addAll(retVal);

      return retVal;
    });
  }

  evaluateOverallProgressInACourse(List<int> percentageFromAllUnits) {
    int overallProgressInPercentage = 0;
    percentageFromAllUnits.forEach((element) {
      overallProgressInPercentage += element;
      print(element);
      print(overallProgressInPercentage / percentageFromAllUnits.length);
    });

    return overallProgressInPercentage;
  }

  Stream<List<CourseChapter>> chapterStream(String uid, String courseName) {
    return firestore
        .collection('colleges')
        .doc(uid)
        .collection('curriculum')
        .doc(courseName)
        .collection(
            'modules') // better to use chapters in place of modules and ['modules in place of materials from the backend.. Make this adjustment']
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      // List<CourseChapter> returnVal = [];

      List<CourseChapter> newChapList = [];
      print(
          'Checking license status is making a handshake to quizzle inc\'s organizational servers ');
      query.docs.forEach((element) {
        newChapList.add(CourseChapter.fromDocumentSnapshot(element));
        print(element);
      });

      chapList.value.addAll(newChapList);

      return newChapList;
    });
  }

  //tidy up -- decentralized uid, courseCode

  Future<void> downloadTestMaterials(
      String courseCode, String chapterName, String moduleName) async {
    print('${courseCode} is about to be downloaded');
    QuerySnapshot<Map<String, dynamic>> data = await firestore
        .collection('colleges')
        .doc(authController.superUser.value.institution)
        .collection('curriculum')
        .doc('CHE 222')
        .collection(
            'modules') // this ought to be chapter not module @ the back end
        .doc(chapterName)
        .collection('materials')
        .doc('files')
        .collection(moduleName)
        .get();

    // this nested collections can be reduced

    List<Stuff> materials =
        data.docs.map((e) => Stuff.fromDocumentSnapshot(e)).toList();

    for (Stuff stuff in materials) {
      // Future<File> genericFile = saveFileToStore(stuff.fire, stuff.materialTitle);

      String filePath = await returnAUrl(stuff.fire, stuff.materialTitle);
      stuff.loca = filePath;

      String thumbPath =
          await returnAUrl(stuff.foca, '${stuff.materialTitle}thumb');

      stuff.toca = thumbPath;

      stuff.storeMaterial(courseCode, chapterName, moduleName, filePath);
    }
  }

  saveAMaterial(
    String fileUrl,
  ) {}

  downloadFullCourse(String courseCode, String uid) async {
    int progress = 10;

    try {
      // Get.defaultDialog(
      //     radius: 5.0,
      //     title: "$progress + done",
      //     titlePadding: const EdgeInsets.all(20),
      //     titleStyle: const TextStyle(fontFamily: 'Product Sans'),
      //     barrierDismissible: false,
      //     content: LoadingAnimationWidget.hexagonDots(
      //       color: Colors.deepPurpleAccent,
      //       size: 50,
      //     ));
      QuerySnapshot<Map<String, dynamic>> data = await firestore
          .collection('colleges')
          .doc(uid)
          .collection('curriculum')
          .doc(courseCode)
          .collection('modules')
          .get();
      // print('you got it');
      // print(data.docs.toString());

      // var newData =
      //     data.docs.map((e) => CourseChapter.fromDocumentSnapshot(e)).toList();

      // print(newData[0].chapterName);

      List<CourseChapter> fetchedChapters = data.docs
          .map((chapter) => CourseChapter.fromDocumentSnapshot(chapter))
          .toList();
      print(fetchedChapters);

      // fetchedChapters.forEach((element) {
      //   print(element);
      // });

      progress = 15;
      int counter = 0;
      for (CourseChapter chapter in fetchedChapters) {
        print('abstracting from firebase to localstore');
        counter++;
        print(counter++);
        progress += (fetchedChapters.length.toInt() / counter).ceil().toInt();

        chapter.save2(courseCode);
        print('done $counter');

        Get.back();
      }
    } catch (e) {
      print(e);

      // roll back all actions...; Create a Plan B for the redistribution of large Media files ** videos
    }
  }

  // transformModuleToChapters(String courseCode, String institution, String studentsLevel) {
  //   Stream<List<CourseItemModel>> moduloStream() {
  //     return firestore
  //         .collection('colleges')
  //         .doc(institution)
  //         .collection('curriculum')
  //         .doc(courseCode)
  //         .collection('modules')
  //         .where('level', isEqualTo: studentsLevel)
  //         .where('status', isEqualTo: 'released')
  //         .snapshots()
  //         .map((QuerySnapshot<Map<String, dynamic>> query) {
  //       List<CourseItemModel> retVal = [];
  //       print('hold up while we retrieve your courses from kofa');
  //       query.docs.forEach((element) {
  //         retVal.add(CourseItemModel.fromDocumentSnapshot(element));
  //         print(element);
  //       });

  //       return retVal;
  //     });
  //   }
  // }
}
