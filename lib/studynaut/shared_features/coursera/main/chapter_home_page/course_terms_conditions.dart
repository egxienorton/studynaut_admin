import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/auth/auth_controller.dart';
import 'package:studynautz/BLOC/auth_controller.dart';
import 'package:studynautz/core/typography/typo.dart';
import 'package:studynautz/core/wizzy/button.dart';
import 'package:localstore/localstore.dart';

import '../../reg/course_adviser.dart';
import '../../reg/data_cylinder_models.dart';

class CourseTermsAndConditionsWidget extends StatefulWidget {
  final String courseCode;
  const CourseTermsAndConditionsWidget({Key? key, required this.courseCode})
      : super(key: key);

  @override
  _CourseTermsAndConditionsWidgetState createState() =>
      _CourseTermsAndConditionsWidgetState();
}

class _CourseTermsAndConditionsWidgetState
    extends State<CourseTermsAndConditionsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var courseAdviser = Get.find<CourseAdviser>();
  AuthController authController = Get.find<AuthController>();

  late CourseItemModel courseModeler;

  final db = Localstore.instance;

  StreamSubscription<Map<String, dynamic>>? _subscription;

  getCourseDetails(String courseCode) async {
    final data = await db.collection('courses').doc(courseCode).get();
    if (data != null) {
      courseModeler = CourseItemModel.fromMap(data);
      print(courseModeler.toMap());
    } else {
      print(data);
    }

    Get.snackbar('Course details acquired', 'Proceed to studies');
  }

  @override
  void initState() {
    // TODO: implement initState
    getCourseDetails(widget.courseCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 450,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                'https://www.shutterstock.com/image-vector/physics-chalkboard-background-hand-drawn-260nw-1988419205.jpg',
                              ).image,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.9, -0.8),
                          child: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).primaryColorLight,
                            size: 24,
                          ),
                        ),
                        Align(
                            alignment: const AlignmentDirectional(-0.9, -0.84),
                            child:
                                WButton(onPressed: () {}, label: 'Replacer')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.courseCode,
                    style: AppTypography.header4(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<CourseAdviser>(
                          init: CourseAdviser(),
                          initState: (_) {},
                          builder: (_) {
                            return Text(
                                courseAdviser
                                    .retrieveUserProgress(widget.courseCode)
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: AppTypography.header2(context));
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Theme.of(context).primaryColor,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6, 2, 6, 2),
                                child: Text(
                                  '137m',
                                  style: AppTypography.header3(context),
                                ),
                              ),
                            ),
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Theme.of(context).primaryColor,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    6, 2, 6, 2),
                                child: Text(
                                  'PG',
                                  style: AppTypography.header3(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: Text(
                          'Ratings',
                          style: AppTypography.header4(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            '12',
                            textAlign: TextAlign.center,
                            style: AppTypography.header2(context),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text('Chapters',
                              style: AppTypography.header4(context)),
                        ),
                        GestureDetector(
                          onTap: () {
                            courseAdviser.updateCourseProgress(
                                courseModeler, 90);
                          },
                          child: const Icon(
                            Icons.badge,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            '52%',
                            textAlign: TextAlign.center,
                            style: AppTypography.header2(context),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text('Experience',
                              textAlign: TextAlign.center,
                              style: AppTypography.header4(context)),
                        ),
                        const Icon(
                          Icons.settings_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            '151',
                            textAlign: TextAlign.center,
                            style: AppTypography.header2(context),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text('Exercises',
                              style: AppTypography.header4(context)),
                        ),
                        const Icon(
                          Icons.settings_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Text(
                            'Genre',
                            style: AppTypography.header4(context),
                          ),
                        ),
                        Text(
                          'Action, Adventure, Fantasy, Sci Fi',
                          style: AppTypography.header3(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WButton(
                      onPressed: () {
                        //TODO: Potential HC bug
                        final course = CourseItemModel(
                            courseName: courseModeler.courseName,
                            courseCode: courseModeler.courseCode,
                            courseCredit: courseModeler.courseCredit,
                            courseDescription: courseModeler.courseDescription,
                            initialized: courseModeler.initialized,
                            overallProgress: 49);

                        // course.updateProgress(widget.courseName, 45);

                        courseAdviser.kickStartCourse(courseModeler);
                        courseAdviser.downloadFullCourse(
                            courseModeler.courseCode,
                            authController.superUser.value.institution);
                      },
                      label: 'Accept and explore')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
