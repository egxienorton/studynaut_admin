// allCourses(physics111)--> you are here

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studynautz/BLOC/Bindings%20and%20Imports/firequickie.dart';
import 'package:localstore/localstore.dart';

class CourseItemModel {
  final String
      courseName; // should this be parsed in from another ssl_db_realm??
  final String courseCode;
  final String courseCredit;
  bool initialized;
  // final List chapters;
  final String courseDescription;
  // how about adding a property to differentiate the different semesters
  // bool done;
  final int
      overallProgress; // an average of all the progress made in all chapter over the cumulative

  CourseItemModel(
      {required this.courseName,
      required this.courseCode,
      required this.courseCredit,
      // required this.chapters, // modules gotten from this.length
      required this.courseDescription,
      // required this.done,
      required this.overallProgress,
      required this.initialized});

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'courseCode': courseCode,
      'courseCredit': courseCredit,

      // 'chapters': chapters,
      'courseDescription': courseDescription,
      // 'done': done,
      'overallProgress': overallProgress,
      'initialized': initialized
    };
  }

  factory CourseItemModel.fromMap(Map<String, dynamic> map) {
    return CourseItemModel(
        courseName: map['courseName'],
        courseCode: map['courseCode'],
        courseCredit: map['courseCredit'],
        // chapters: map['chapters'],
        courseDescription: map['courseDescription'],
        // done: map['done'],
        overallProgress: map['overallProgress'],
        initialized: map['initialized']);
  }

  CourseItemModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : courseName = snapshot['courseName'],
        courseCode = snapshot['courseCode'],
        courseCredit = snapshot['courseCredit'],
        // chapters= snapshot['chapters'],
        courseDescription = snapshot['courseDescription'],
        // done= snapshot['done'],
        initialized = false,
        overallProgress = 0;
}

extension ExtCourseItemModel on CourseItemModel {
  Future save() async {
    final _db = Localstore.instance;
    print('adding to courses/${courseCode}');

    //! OMO this is a killer function which help you clean gabbage levels!!
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('courses');

    final QuerySnapshot querySnapshot = await collectionRef.get();

    // Iterate through the documents and delete them
    final List<Future<void>> deleteFutures = [];
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      deleteFutures.add(docSnapshot.reference.delete());
    }

    // Wait for all the delete operations to complete
    await Future.wait(deleteFutures);

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('courses')
        .doc(courseCode)
        .set(toMap());

    return _db.collection('courses').doc(courseCode).set(toMap());
  }

  // God i have to write v9 handlers to make each method work!!!.. Thinktank
  Future updateProgress(String courseName, int progress) async {
    final _db = Localstore.instance;
    print('updating to courses/${courseName}');

    _db.collection('courses').doc(courseName).get().then((value) {
      // now the proposed model needs to expand

      var course = CourseItemModel(
          courseName: value!['courseName'],
          courseCredit: value['courseCredit'],
          courseDescription: value['courseCredit'],
          courseCode: value['courseCode'],
          initialized: value['initialized'],
          overallProgress: progress);
    });

    return _db.collection('courses').doc(courseName).set(toMap());
  }

  // Spinning up the engine for the intialization on registration

  Future initializeCourse(String courseCode) async {
    final _db = Localstore.instance;
    print('initialing to true courses/${courseCode}');

    _db.collection('courses').doc(courseCode).get().then((value) {
      // now the proposed model needs to expand

      var Xcourse = CourseItemModel(
          courseCode: value!['courseCode'],
          courseName: value['courseName'],
          courseCredit: value['courseCredit'],
          courseDescription: value['courseCredit'],
          initialized: true,
          overallProgress: 25);

      print(Xcourse.toMap());
    });

    return _db.collection('courses').doc(courseCode).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('courses').doc(courseName).delete();
  }
}

class CourseChapter {
  String? courseCode; // this ought to be extended -- TOOO!!!
  final String chapterName;
  final String chapterDescription;
  String? chapterOutlinePath;
  int? progress;
  List? modules;

  /// thumbnailpath too
  // bool done;

  CourseChapter({
    required this.chapterName,
    this.courseCode,
    required this.chapterOutlinePath,
    required this.chapterDescription,
    this.progress,
    this.modules,
    // required this.done
  });

  Map<String, dynamic> toMap() {
    return {
      'courseCode': courseCode,
      'chapterName': chapterName,
      'chapterDescription': chapterDescription,
      'chapterOutlinePath': chapterOutlinePath,
      'progress': progress,
      'modules': modules,
      // 'done': done,
    };
  }

  Map<String, dynamic> toMapiano() {
    return {
      'courseCode': courseCode,
      'chapterName': chapterName,
      'chapterDescription': chapterDescription,

      'chapterOutlinePath': chapterOutlinePath,
      'progress': progress,
      'modules': modules,
      // 'done': done,
    };
  }

  CourseChapter.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : courseCode = '',
        modules = [],
        chapterDescription = snapshot['moduleDescription'],
        chapterName = snapshot[
            'moduleName'], // biko this ought to be chapterName not moduleName..pls make adjustment as soon as possible and distribute your build
        progress = 0,
        // chapters= snapshot['chapters'],
        chapterOutlinePath = ''; // make this dynamic later on

  factory CourseChapter.fromMap(Map<String, dynamic> map) {
    return CourseChapter(
        chapterDescription: map['chapterDescription'],
        courseCode: map['courseCode'],
        chapterName: map['chapterName'],
        chapterOutlinePath: map['chapterOutlinePath'],
        modules: map['modules'],
        progress: map['progress']
        // done: map['done'],
        );
  }

  // factory CourseChapter.fromAList(List map) {
  //   return CourseChapter(
  //     courseName: map.,
  //     chapterName: map['chapterName'],
  //     chapterOutlinePath: map['chapterOutlinePath'],
  //     modules: map['modules'],
  //     done: map['done'],
  //   );
  // }
}

extension ExtCourseChapter on CourseChapter {
  Future save() async {
    final _db = Localstore.instance;
    print('adding to courses/${courseCode}/${chapterName}/datacenter');
    return _db
        .collection('courses')
        .doc(courseCode)
        .collection(chapterName)
        .doc('datacenter')
        .set(toMap());
  }

  Future save2(String courseCode) async {
    final _db = Localstore.instance;
    print('storing the stora/${courseCode}/chapters/${chapterName}');
    print('yeah!!!');
    return _db
        .collection('courses')
        .doc(courseCode)
        .collection('chapters')
        .doc(chapterName)
        .set(toMap());
  }
}

class CourseModule {
  final String courseName;
  final String courseCode;
  final String chapterName;
  final String moduleName;
  final String documentPath;
  final String mediaBucket;
  final String questionnaireKey;

  // extra's like flashcard ...
  // caveats -- practical modules --- ELA, PHY 109,

  const CourseModule(
      {required this.courseName,
      required this.courseCode,
      required this.chapterName,
      required this.moduleName,
      required this.documentPath,
      required this.mediaBucket,
      required this.questionnaireKey});

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'courseCode': courseCode,
      'chapterName': chapterName,
      'moduleName': moduleName,
      'documentPath': documentPath,
      'mediaBucket': mediaBucket,
      'questionnaireKey': questionnaireKey,
    };
  }

  factory CourseModule.fromMap(Map<String, dynamic> map) {
    return CourseModule(
      courseName: map['courseName'],
      courseCode: map['courseCode'],
      chapterName: map['chapterName'],
      moduleName: map['moduleName'],
      documentPath: map['documentPath'],
      mediaBucket: map['mediaBucket'],
      questionnaireKey: map['questionnaireKey'],
    );
  }
}

// questionnaire have to be grouped and classified

extension ExtTodo on CourseModule {
  Future save() async {
    final _db = Localstore.instance;
    print(
        'adding to courses/${courseCode}/datacenter/${moduleName}/moduleRaid');

    return _db
        .collection('courses')
        .doc(courseCode)
        .collection(chapterName)
        .doc('datacenter')
        .collection(moduleName)
        .doc('moduleRaid')
        .set(toMap());
  }

  // Future delete() async {
  //   final _db = Localstore.instance;
  //   return _db.collection('todos').doc(id).delete();
  // }

  // should we create updating of the module?? I think you need to look into this big time
}

class Stuff {
  final String materialTitle;
  final String materialType;
  final String materialSubtitle;
  final String fire;
  String? progress;
  String foca;
  String? toca;

  String? loca;
  // final materialSize;
  // final materialSerial;

  Stuff(
      {required this.materialTitle,
      required this.materialType,
      // required this.materialSize,
      required this.fire,
      this.loca, // --------- get this as a well auto parsed argument
      this.progress,
      required this.foca,
      this.toca,
      required this.materialSubtitle});

  factory Stuff.fromMap(Map<String, dynamic> map) {
    return Stuff(
        materialTitle: map['materialTitle'],
        loca: map['loca'],
        progress: map['done'],
        materialType: map['materialType'],
        fire: map['fire'],
        foca: map['foca'],
        toca: map['toca'],
        materialSubtitle: map['materialSubtitle']);
  }

  Map<String, dynamic> toMap() {
    return {
      'materialTitle': materialTitle,
      'materialSubtitle': materialSubtitle,
      'materialType': materialType,
      'progress': progress,
      'loca': loca,
      'toca': toca,
      'foca': foca,
      'fire': fire,
      // 'materialSize':materialSize,
    };
  }

  Stuff.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : materialTitle = snapshot['title'],
        materialType = snapshot['type'],
        progress = 'done',
        foca = snapshot['thumbnail'],
        // materialSize = snapshot[';materialSize'], // this is yet to be established
        fire = snapshot['url'],
        materialSubtitle = snapshot['subtitle'];
}

extension ExtMaterialKeep on Stuff {
  Future storeMaterial(String courseCode, String chapterName, String moduleName,
      String filePath) async {
    final _db = Localstore.instance;
    print(
        'added material to /${courseCode}/chapters/${chapterName}/materials/${materialTitle}/filePath:${filePath}');

    return _db
        .collection('courses')
        .doc(courseCode)
        .collection('chapters')
        .doc(chapterName)
        .collection('materials')
        .doc(materialTitle)
        .set(toMap());
  }

  // Future delete() async {
  //   final _db = Localstore.instance;
  //   return _db.collection('todos').doc(id).delete();
  // }

  // should we create updating of the module?? I think you need to look into this big time
}
