import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/core/wizzy/appBars/appBar.dart';
import 'package:studynaut_admin/core/wizzy/button.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/cousera_registration.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/main/widget.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/reg/course_adviser.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/reg/data_cylinder_models.dart';
import 'package:localstore/localstore.dart';
import 'package:lottie/lottie.dart';

import 'chapter_home_page/chapter_home_page.dart';
import 'course_unit/course_unit.dart';

class CourseraHome extends StatefulWidget {
  const CourseraHome({super.key});

  @override
  State<CourseraHome> createState() => _CourseraHomeState();
}

class _CourseraHomeState extends State<CourseraHome> {
  final _db = Localstore.instance;
  final _items = <String, CourseItemModel>{};
  StreamSubscription<Map<String, dynamic>>? _subscription;

  var courseAdviser = Get.put(CourseAdviser());

  void fireUp() {}

  @override
  void initState() {
    _subscription = _db.collection('courses').stream.listen((event) {
      setState(() {
        final item = CourseItemModel.fromMap(event);
        _items.putIfAbsent(item.courseName, () => item);
      });
    });
    if (kIsWeb) _db.collection('courses').stream.asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XAppBar(
        title: 'Study Course',
      ),
      body: _items.isEmpty
          ? NotRegisteredWidget()
          : ListView.builder(
              itemCount: _items.keys.length,
              itemBuilder: (context, index) {
                final key = _items.keys.elementAt(index);
                final item = _items[key]!;
                return LegacyCourseWidget(
                  progress: item.overallProgress,
                  onTap: () {
                    if (item.initialized) {
                      Get.snackbar(
                          item.courseName, item.initialized.toString());
                      Get.to(
                          () => CourseUnitScreen(courseCode: item.courseCode));
                    } else {
                      Get.snackbar(
                          item.courseName, item.initialized.toString());
                      Get.to(() => ChapterHomePage(
                            courseCode: item.courseCode,
                          ));
                    }
                  },
                  courseName: item.courseName,
                  courseCode: item.courseCode,
                  courseCredits: item.courseCredit,
                  courseDescription: item.courseDescription,
                );
              },
            ),
    );
  }
}

class NotRegisteredWidget extends StatelessWidget {
  const NotRegisteredWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //TODO: Bring in offline lottie json
          SizedBox(
              child: LottieBuilder.network(
                  'https://assets5.lottiefiles.com/private_files/lf30_oqpbtola.json')),
          Text(
            'You haven\'t registered any courses yet.',
            style: AppTypography.subtitle(context),
          ),
          WButton(
              onPressed: () {
                Get.to(() => CourseraRegistration());
              },
              label: 'Register Courses')
        ],
      ),
    );
  }
}
