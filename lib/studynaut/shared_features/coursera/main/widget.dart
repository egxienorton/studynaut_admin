import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/settings/preferences.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../reg/course_adviser.dart';

class LegacyCourseWidget extends StatelessWidget {
  final String courseName;
  final String courseDescription;
  final String courseCredits;
  final String courseCode;
  final int progress;
  final Function() onTap;

  LegacyCourseWidget(
      {Key? key,
      required this.courseCode,
      required this.courseCredits,
      required this.courseDescription,
      required this.courseName,
      required this.progress,
      required this.onTap})
      : super(key: key);

  var courseAdviser = Get.put(CourseAdviser());
  // the above is pretty nifty and dangerous as it is just an ordinary widget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x430F1113),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            // context.pushNamed('courseoton');
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onLongPress: () => Get.to(() => PreferencesScreen()),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          courseCode,
                          style: AppTypography.header1(context)
                              .copyWith(letterSpacing: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 1,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        courseName,
                        style: AppTypography.subtitle(context),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: progress < 40
                                  ? Colors.redAccent
                                  : Colors.green,
                              width: 8.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          progress.toString(),
                          style: const TextStyle(fontSize: 14),
                          // courseAdviser.retrieveUserProgress(courseName).toString()

                          // progress.toString() +'%'?? '0%', style: FlutterFlowTheme.of(context)
                          // .bodyText1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            courseDescription,
                            style: AppTypography.header6(context),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: LinearPercentIndicator(
                              percent: progress.toDouble() / 100 ?? 0,
                              width: MediaQuery.of(context).size.width * 0.72,
                              lineHeight: 7,
                              animation: true,
                              progressColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).focusColor,
                              barRadius: const Radius.circular(8),
                              padding: EdgeInsets.zero,
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
      ),
    );
  }
}
