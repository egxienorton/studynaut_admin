import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/core/wizzy/button.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../reg/course_adviser.dart';
import '../../chapter_home_page/course_detail_page/course_explore_page.dart';

class CourseotonWidget extends StatefulWidget {
  final String chapterName;
  // final String moduleName;
  final String courseCode;
  const CourseotonWidget(
      {Key? key,
      required this.chapterName,
      // required this.moduleName,
      required this.courseCode})
      : super(key: key);

  @override
  _CourseotonWidgetState createState() => _CourseotonWidgetState();
}

class _CourseotonWidgetState extends State<CourseotonWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var courseAdviser = Get.find<CourseAdviser>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 210,
                      child: Stack(
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/213/600',
                            width: double.infinity,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY: 7,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    color: const Color(0x48000000),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.network(
                                        'data:image/jpeg;base64,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',
                                      ).image,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 44, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    IconlyBold.arrow_left_2),
                                              ),
                                              Expanded(
                                                child: Text('Tailored for you',
                                                    style:
                                                        AppTypography.header3(
                                                            context)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 0),
                                              child: Text(widget.chapterName,
                                                  style: AppTypography.header2(
                                                      context)),
                                            ),
                                            LinearPercentIndicator(
                                              percent: 0.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              lineHeight: 10,
                                              animation: true,
                                              progressColor:
                                                  const Color(0xFF4B39EF),
                                              backgroundColor:
                                                  const Color(0xFFF1F4F8),
                                              barRadius:
                                                  const Radius.circular(16),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 12, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(4, 0, 0, 0),
                                                child: Text('4 Modules',
                                                    style: AppTypography
                                                            .header2(context)
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight)),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                      child: Text(
                        'Modules are according to your institution',
                        style: AppTypography.header2(context),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          const ModuleCard(
                            mIndex: 1,
                            moduleDescription: 'A brief introduction',
                            moduleName: 'Introduction',
                            chapterName: 'Diffusion',
                            courseCode: 'CHE 222',
                          ),
                          const ModuleCard(
                            mIndex: 2,
                            moduleDescription:
                                'What you may already about fluids',
                            moduleName: 'Fluids',
                            chapterName: 'Diffusion',
                            courseCode: 'CHE 222',
                          ),
                          const ModuleCard(
                            mIndex: 3,
                            moduleDescription: 'Liquids',
                            moduleName: 'Learn some liquid properties ',
                            chapterName: 'Diffusion',
                            courseCode: 'CHE 222',
                          ),
                          const ModuleCard(
                            mIndex: 4,
                            moduleDescription: 'a look at density',
                            moduleName: 'Density',
                            chapterName: 'Diffusion',
                            courseCode: 'CHE 222',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x32000000),
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                courseAdviser.downloadTestMaterials(
                    'CHE 222', 'Diffusion', 'Diffusion');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 5,
                      color: Color(0x411D2429),
                      offset: Offset(0, -2),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 44),
                  child: Text('Download materials over Wifi',
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final String courseCode;
  final String chapterName;
  final String moduleName;
  final String moduleDescription;
  final int mIndex;
  const ModuleCard(
      {Key? key,
      required this.courseCode,
      required this.chapterName,
      required this.moduleName,
      required this.moduleDescription,
      required this.mIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: InkWell(
        onTap: () async {
          // context.pushNamed('course_explore_page');
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
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
                    mIndex.toString(),
                    textAlign: TextAlign.center,
                    style: AppTypography.header3(context),
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
                        GestureDetector(
                          onTap: () {
                            //!Come back here
                            Get.to(() => CourseExplorePageWidget(
                                  courseCode: courseCode,
                                  chapterName: chapterName,
                                  moduleName:
                                      moduleName, //----------------------------------------------------------------------- this line
                                ));
                          },
                          child: Text(
                            moduleName,
                            style: AppTypography.subtitle(context),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: InkWell(
                            onTap: () async {},
                            child: Text(moduleDescription,
                                style: AppTypography.header3(context)),
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
