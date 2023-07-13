import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynautz/core/typography/typo.dart';

import '../reg/course_adviser.dart';
import 'controllers/quiz_papers_controller.dart';
import 'index.dart';

class QuizPageWidget extends StatefulWidget {
  final String chapterName;
  const QuizPageWidget({Key? key, required this.chapterName}) : super(key: key);

  // now we have to initialize the schema with localstore to have a fire experience!!

  @override
  _QuizPageWidgetState createState() => _QuizPageWidgetState();
}

class _QuizPageWidgetState extends State<QuizPageWidget> {
  var courseAdviser = Get.find<CourseAdviser>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('${widget.chapterName} Quiz',
            textAlign: TextAlign.center,
            //TODO: New init of Theme modifier
            style: Theme.of(context).textTheme.bodyLarge),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B39EF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => Home1(),
                                        binding: BindingsBuilder(() {
                                      Get.put(QuizPaperController());
                                      // Get.put(MyDrawerController());
                                    }));
                                  },
                                  child: Text(
                                    'Beginner',
                                    style: AppTypography.header3(context),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '25 Questions',
                            style: AppTypography.header3(context),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 4, 0),
                                      child: Text(
                                        'Your last score',
                                        textAlign: TextAlign.end,
                                        style: AppTypography.header4(context),
                                      ),
                                    ),
                                    Text(
                                      '8/25',
                                      textAlign: TextAlign.end,
                                      style: AppTypography.header3(context),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_half_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_border_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF39D26B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {},
                                  child: Text('Intermediate',
                                      style: AppTypography.header2(context)),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          Text('25 Questions',
                              style: AppTypography.header2(context)),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 4, 0),
                                      child: Text('Your last score',
                                          textAlign: TextAlign.end,
                                          style:
                                              AppTypography.header3(context)),
                                    ),
                                    Text('25/36',
                                        textAlign: TextAlign.end,
                                        style: AppTypography.header2(context)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_border_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
                                    ),
                                    Icon(
                                      Icons.star_border_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 24,
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                  child: GestureDetector(
                    onTap: () {
                      courseAdviser.saveFileToStore(
                          'https://cdn-icons-png.flaticon.com/512/8930/8930287.png',
                          'fizo.png');
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12, 12, 12, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Beast',
                                      style: AppTypography.header2(context)),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            Text('125 Questions',
                                style: AppTypography.header2(context)),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 4, 0),
                                        child: Text('Your last score',
                                            textAlign: TextAlign.end,
                                            style:
                                                AppTypography.header2(context)),
                                      ),
                                      Text('25/125',
                                          textAlign: TextAlign.end,
                                          style:
                                              AppTypography.header2(context)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: 24,
                                      ),
                                      Icon(
                                        Icons.star_half_rounded,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: 24,
                                      ),
                                      Icon(
                                        Icons.star_border_rounded,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: 24,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
