import 'package:flutter/material.dart';

import 'widget.dart/courseoton.dart';

class ModuleScreen extends StatelessWidget {
  final String chapterName;
  final String courseCode;
  // final String moduleName;
  const ModuleScreen(
      {required this.chapterName,
      required this.courseCode,
      // required this.moduleName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CourseotonWidget(
      chapterName: chapterName,
      courseCode: courseCode,
      // moduleName: moduleName,
    );
  }
}
