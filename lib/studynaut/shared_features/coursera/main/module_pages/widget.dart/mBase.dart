import 'package:flutter/material.dart';

import 'timeliner.dart';

// import 'package:timelines/timelines.dart';

class MBase extends StatelessWidget {
  final String courseCode;
  final String chapterName;
  final String moduleName;
  const MBase(
      {required this.courseCode,
      required this.chapterName,
      required this.moduleName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TimelineStatusPage(
      moduleName: moduleName,
      courseCode: courseCode,
      chapterName: chapterName,
    ));
  }
}
