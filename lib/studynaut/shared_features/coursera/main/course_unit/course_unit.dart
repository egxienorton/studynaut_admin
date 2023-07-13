import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
// import 'package:studynautz/BLOC/auth_controller.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/reg/data_cylinder_models.dart';
import 'package:localstore/localstore.dart';

import '../../reg/course_adviser.dart';
import '../module_pages/module_screen.dart';

class CourseUnitScreen extends StatefulWidget {
  final String courseCode;

  const CourseUnitScreen({required this.courseCode, super.key});

  @override
  State<CourseUnitScreen> createState() => _CourseUnitScreenState();
}

class _CourseUnitScreenState extends State<CourseUnitScreen> {
  AuthController authController = Get.find<AuthController>();
  final _db = Localstore.instance;
  final _items = <String, CourseChapter>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;
  late bool isMounted;

  var courseAdviser = Get.put(CourseAdviser());

  getChapters() {
    _subscription = _db
        .collection('courses')
        .doc(widget.courseCode)
        // .doc('CHE 222')
        .collection('chapters')
        .stream
        .listen((event) {
      print('an update happened $event');
      final item = CourseChapter.fromMap(event);

      print(item);
      _items.putIfAbsent(item.chapterName, () => item);
    });

    if (kIsWeb) _db.collection('courses').stream.asBroadcastStream();

    Get.snackbar('chapters fetched', 'yes!');
    print(_items.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getChapters();

    super.initState();
  }

  @override
  // TODO: implement mounted

  bool get mounted => super.mounted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(IconlyBold.arrow_left_2)),
        title: Text(
          'Study here',
          style: AppTypography.header3(context),
        ),
        actions: [
          IconButton(
              onPressed: () {
                courseAdviser.downloadFullCourse(widget.courseCode,
                    authController.superUser.value.institution);
              },
              icon: const Icon(IconlyBold.download))
        ],
      ),
      body: _items.isNotEmpty
          ? Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _items.keys.length,
                      itemBuilder: (context, index) {
                        final key = _items.keys.elementAt(index);
                        final item = _items[key]!;

                        return ChapterCard(
                            courseCode: item.courseCode!,
                            indie: index + 1,
                            chapterName: item.chapterName,
                            description: item.chapterOutlinePath!);
                      },
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          demoChapter(

              // parse course name in a decent way
              CourseChapter(
                  chapterName: "Statics of Fluids",
                  chapterOutlinePath: 'chapterOutlinePath',
                  chapterDescription: 'What now ?',
                  progress: 4,
                  courseCode: widget.courseCode,
                  modules: []));
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  demoChapter(CourseChapter chapter) async {
    // print('extracting course ${chapter.chapterName}');

    // chapter.chapterName;
    // chapter.save2(chapter.courseName!);
    chapter.save2(chapter.courseCode!);
    print('cheers for ${chapter.courseCode}');

    // await extractAllChapters(course); --------------------------dangerous functions..
  }
}

class ChapterCard extends StatelessWidget {
  final String chapterName;
  final String courseCode;
  final int indie;

  final String description;

  const ChapterCard(
      {Key? key,
      required this.chapterName,
      required this.courseCode,
      required this.indie,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: InkWell(
        onTap: () async {
          Get.to(() => ModuleScreen(
                courseCode: courseCode,
                chapterName: chapterName,
              ));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).highlightColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: const AlignmentDirectional(0, 0),
                  child: Text(
                    indie.toString(),
                    textAlign: TextAlign.center,
                    style: AppTypography.header4(context),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterName,
                          style: AppTypography.subtitle(context),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: InkWell(
                            onTap: () async {},
                            child: Text(
                                'Master S.I scaling and units once and for all!',
                                style: AppTypography.header5(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Color(0xFF39D26B),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: Icon(
                      Icons.done_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
