import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../../core/typography/typo.dart';
import '../../../../../../core/wizzy/button.dart';
import '../../../../../../core/wizzy/xDialogs.dart';
import '../../../reg/course_adviser.dart';
import '../../module_pages/widget.dart/mBase.dart';
import '../../module_pages/widget.dart/timeliner.dart';
import '../../module_pages/widget.dart/vlc.dart';

class CourseExplorePageWidget extends StatefulWidget {
  final String moduleName;
  final String chapterName;
  final String courseCode;
  const CourseExplorePageWidget(
      {Key? key,
      required this.moduleName,
      required this.chapterName,
      required this.courseCode})
      : super(key: key);

  @override
  _CourseExplorePageWidgetState createState() =>
      _CourseExplorePageWidgetState();
}

class _CourseExplorePageWidgetState extends State<CourseExplorePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var courseAdviser = Get.find<CourseAdviser>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                // Image.network(
                //   'https://images.unsplash.com/photo-1630332458162-acc073374da7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80',
                //   width: double.infinity,
                //   height: 100,
                //   fit: BoxFit.fitHeight,
                // ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: Image.network(
                      //     'https://cdn.vectorstock.com/i/1000x1000/83/09/physics-abstract-vector-4308309.webp',
                      //   ).image,
                      // ),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0x0014181B),
                          Theme.of(context).primaryColorDark
                        ],
                        stops: const [0, 0.7],
                        begin: const AlignmentDirectional(0, -1),
                        end: const AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 52, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 32),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // WButton(
                                //   // borderColor: Colors.transparent,
                                //   // borderRadius: 8,
                                //   // borderWidth: 1,
                                //   // buttonSize: 40,
                                //   // fillColor: const Color(0x9A202529),
                                //   label: '',
                                //   icon: Icons.close_rounded,

                                //   onPressed: () async {
                                //     Get.back();
                                //   },
                                // ),
                                Text(widget.moduleName,
                                    style: AppTypography.subtitle(context)),
                                IconButton(
                                  icon: Icon(IconlyBold.shield_fail),
                                  onPressed: () {
                                    Get.to(() => MBase(
                                          chapterName: widget.chapterName,
                                          courseCode: widget.courseCode,
                                          moduleName: widget.moduleName,
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 24,
                            thickness: 2,
                            indent: 130,
                            endIndent: 130,
                            color: Colors.white,
                          ),
                          Text(
                            'Measurement and units',
                            style: AppTypography.subtitle(context),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 24, 0, 0),
                            child: WButton(
                              onPressed: () {
                                Get.bottomSheet(Container(
                                    height:
                                        MediaQuery.of(context).size.height * 4,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 16, 0, 0),
                                            child: Text(
                                              'What you will learn',
                                              style: AppTypography.header4(
                                                  context),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 340,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            child: ListView(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          12, 12, 0, 12),
                                                  child: Container(
                                                    width: 270,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x1F000000),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Container(
                                                      width: 100,
                                                      height: 70,
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child:
                                                                Image.network(
                                                              'https://cdn.dribbble.com/users/8064174/screenshots/17785231/media/d78c4d3b885d6a735c40b72fe936dc6b.png?compress=1&resize=1200x900&vertical=top',
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 1),
                                                            child: ClipRRect(
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 5,
                                                                  sigmaY: 2,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .transparent,
                                                                        Theme.of(context)
                                                                            .primaryColor
                                                                      ],
                                                                      stops: const [
                                                                        0,
                                                                        1
                                                                      ],
                                                                      begin:
                                                                          const AlignmentDirectional(
                                                                              0,
                                                                              -1),
                                                                      end: const AlignmentDirectional(
                                                                          0, 1),
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                        'Learning how to use Figma',
                                                                        style: AppTypography.subtitle(
                                                                            context)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          12, 12, 16, 12),
                                                  child: Container(
                                                    width: 270,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x1F000000),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Container(
                                                      width: 100,
                                                      height: 70,
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0, 0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                'https://cdn.dribbble.com/users/5031392/screenshots/17556719/media/592e46c2d3a56e30eec1b1e400920030.png?compress=1&resize=1200x900&vertical=top',
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1, 1),
                                                            child: ClipRRect(
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 5,
                                                                  sigmaY: 2,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .transparent,
                                                                        Theme.of(context)
                                                                            .primaryColorDark
                                                                      ],
                                                                      stops: const [
                                                                        0,
                                                                        1
                                                                      ],
                                                                      begin:
                                                                          const AlignmentDirectional(
                                                                              0,
                                                                              -1),
                                                                      end: const AlignmentDirectional(
                                                                          0, 1),
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                        'Layout and UX 101',
                                                                        style: AppTypography.subtitle(
                                                                            context)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 8, 0, 8),
                                            child: Text(
                                              'What you will learn',
                                              style: AppTypography.header4(
                                                  context),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 12, 16, 0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x2B202529),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        12, 12, 12, 12),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 12, 0),
                                                          child: Icon(
                                                            Icons
                                                                .school_outlined,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            size: 24,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    0, 8, 0, 8),
                                                            child: Text(
                                                              '16 Lessons',
                                                              style: AppTypography
                                                                  .subtitle(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 12, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    12,
                                                                    0),
                                                            child: Icon(
                                                              Icons
                                                                  .auto_awesome,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      8,
                                                                      0,
                                                                      8),
                                                              child: Text(
                                                                'Exclusive Learning Material',
                                                                style: AppTypography
                                                                    .subtitle(
                                                                        context),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 12, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    12,
                                                                    0),
                                                            child: Icon(
                                                              Icons.stream,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      8,
                                                                      0,
                                                                      8),
                                                              child: Text(
                                                                'Ordered Learning',
                                                                style: AppTypography
                                                                    .subtitle(
                                                                        context),
                                                              ),
                                                            ),
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 12, 16, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x2B202529),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1, 0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 0, 0, 0),
                                                      child: Text(
                                                        'Frequently Asked Questions',
                                                        style: AppTypography
                                                            .subtitle(context),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right_rounded,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 24,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 16, 0, 16),
                                            child: Text(
                                              'Related Content',
                                              style: AppTypography.header4(
                                                  context),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 12),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 1, 1, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                                                          width: 70,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                8, 8, 4, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Title',
                                                              style: AppTypography
                                                                  .header5(
                                                                      context),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        8,
                                                                        0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'A wonderfully delicious 2 patty melt that melts into your...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: AppTypography
                                                                      .header3(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chevron_right_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 12),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 1, 1, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                                                          width: 70,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                8, 8, 4, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Title',
                                                              style: AppTypography
                                                                  .caption(
                                                                      context),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        8,
                                                                        0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'A wonderfully delicious 2 patty melt that melts into your...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: AppTypography
                                                                      .header5(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chevron_right_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 12),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 1, 1, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                                                          width: 70,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                8, 8, 4, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Title',
                                                              style: AppTypography
                                                                  .subtitle(
                                                                      context),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        8,
                                                                        0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'A wonderfully delicious 2 patty melt that melts into your...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: AppTypography
                                                                      .header3(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chevron_right_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 50),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(8, 8, 8, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 1, 1, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                          'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                                          width: 70,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                8, 8, 4, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Title',
                                                              style: AppTypography
                                                                  .caption(
                                                                      context),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        8,
                                                                        0),
                                                                child:
                                                                    AutoSizeText(
                                                                  'A wonderfully delicious 2 patty melt that melts into your...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: AppTypography
                                                                      .header4(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 4, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chevron_right_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorLight,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )));
                              },
                              label: 'View Chapter Outline',
                              // options: FFButtonOptions(
                              //   width: double.infinity,
                              //   height: 44,
                              //   color:
                              //       FlutterFlowTheme.of(context).primaryColor,
                              //   textStyle: FlutterFlowTheme.of(context)
                              //       .subtitle2
                              //       .override(
                              //         fontFamily: 'Poppins',
                              //         color: Colors.white,
                              //       ),
                              //   borderSide: const BorderSide(
                              //     color: Colors.transparent,
                              //     width: 1,
                              //   ),
                              // ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                    child: WButton(
                                      onPressed: () {
                                        Get.to(() => const VLC(
                                              videoPath:
                                                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                                            ));
                                      },
                                      label: 'Flash Cards',
                                      icon: Icons.play_arrow_rounded,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                    child: WButton(
                                      onPressed: () {
                                        // TODO : Disabled
                                        // Get.to(() =>
                                        //     const FakeCourseExplorePageWidget());
                                      },
                                      label: 'My List',
                                      icon: Icons.add_rounded,

                                      // options: FFButtonOptions(
                                      //   width: double.infinity,
                                      //   height: 44,
                                      //   color: const Color(0x004B39EF),
                                      //   textStyle: FlutterFlowTheme.of(context)
                                      //       .subtitle2
                                      //       .override(
                                      //         fontFamily: 'Poppins',
                                      //         color:
                                      //             FlutterFlowTheme.of(context)
                                      //                 .primaryText,
                                      //         fontSize: 14,
                                      //       )
                                      //       .copyWith(color: Colors.white),
                                      //   elevation: 0,
                                      //   borderSide: const BorderSide(
                                      //     color: Colors.transparent,
                                      //     width: 1,
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: TimelineStatusPage(
              chapterName: widget.chapterName,
              moduleName: widget.moduleName,
              courseCode: widget.courseCode,
            )),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: const [
                  BoxShadow(
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
                child: GestureDetector(
                  //TODO: Here too
                  // onTap: () => Get.to(() => QuizPageWidget(
                  //       chapterName: widget.chapterName,
                  //     )),
                  child: Text(
                    'Take Self Test',
                    textAlign: TextAlign.center,
                    style: AppTypography.header2(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class LearnCard extends StatelessWidget {
