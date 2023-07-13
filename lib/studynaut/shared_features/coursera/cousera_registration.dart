import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynautz/core/typography/typo.dart';
import 'package:localstore/localstore.dart';
import 'package:lottie/lottie.dart';

import '../baseWidgets/scrollable_widget.dart';
import 'reg/course_adviser.dart';
import 'reg/data_cylinder_models.dart';

class CourseraRegistration extends StatefulWidget {
  const CourseraRegistration({super.key});

  @override
  State<CourseraRegistration> createState() => _CourseraRegistrationState();
}

class _CourseraRegistrationState extends State<CourseraRegistration> {
  final _db = Localstore.instance;
  final _items = <String, CourseItemModel>{};
  int totalCredits = 0;
  List<CourseItemModel> selectedCourses = [];
  StreamSubscription<Map<String, dynamic>>? _subscription;
  CourseAdviser courseAdviser = Get.put<CourseAdviser>(CourseAdviser());

  getCourses() async {
    await courseAdviser.refreshCourses();
    setState(() {});
  }

  @override
  void initState() {
    getCourses();
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
          'Register Course Form',
          style: AppTypography.header4(context),
        ),
      ),
      body: courseAdviser.onlineCourselist.value.isEmpty
          ? Center(
              child: SizedBox(
              height: 100,
              width: 200,
              child: LottieBuilder.network(
                  'https://assets2.lottiefiles.com/private_files/lf30_ployuqvp.json'),
            ))
          : Column(
              children: [
                // const SizedBox(
                //   height: 28,
                // ),
                Expanded(child: ScrollableWidget(child: buildCourseList())),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    '**Note that courses you register here only gives you access to study within the app. It does not register them in your institution.',
                    style: AppTypography.caption(context),
                  ),
                ),
                buildSubmit()
              ],
            ),
    );
  }

  Widget buildCourseList() {
    final columns = ['Course Name', 'Credit Load'];
    return DataTable(
      onSelectAll: (isSelectedAll) {
        Get.snackbar("Exceeds Credit Loads",
            "Total Course Load : 54 - Review your plans for more flexiblity");
      },
      columns: getColumns(columns),
      rows: getRows(courseAdviser.onlineCourselist.value),
    );
  }

  Future registerCourse(CourseItemModel c) async {
    final coursero = CourseItemModel(
      initialized: false,
      courseName: c.courseName,
      courseCode: c.courseCode,
      courseCredit: c.courseCredit,
      courseDescription: c.courseDescription,
      overallProgress: 0,
      // hasMaterials: c.hasMaterials
    );

    c.save();

    print('nice one beast');
  }

  Widget buildSubmit() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      // color: Colors.black,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(40)),
        onPressed: () {
          selectedCourses.forEach((c) {
            registerCourse(c);
          });
        },
        child: Text(
          'Register Courses ($totalCredits)',
          style: AppTypography.header4(context),
        ),
      ));

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((column) => DataColumn(
              label: Text(
            column,
            style: AppTypography.header2(context),
          )))
      .toList();
  List<DataRow> getRows(List<CourseItemModel> courses) => courses
      .map((CourseItemModel course) => DataRow(
              selected: selectedCourses.contains(course),
              onSelectChanged: (isSelected) => setState(() {
                    final isAdding = isSelected != null && isSelected;

                    isAdding
                        ? selectedCourses.add(course)
                        : selectedCourses.remove(course);

                    List creditLoad = [0];
                    final cummulativeCreditLoad =
                        selectedCourses.forEach((course) {
                      creditLoad.add(int.parse(course.courseCredit));
                    });

                    totalCredits = creditLoad.reduce(
                        (previousValue, current) => previousValue + current);

                    setState(() {});
                  }),
              cells: [
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.courseName,
                      style: AppTypography.header6(context),
                    ),
                    Text(
                      course.courseCode,
                      style: AppTypography.header4(context),
                    )
                  ],
                )),
                DataCell(Text(
                  course.courseCredit,
                  style: AppTypography.header2(context)
                      .copyWith(color: Theme.of(context).primaryColor),
                )),
                // DataCell(Text(course.courseCredit)),
              ]))
      .toList();

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}
