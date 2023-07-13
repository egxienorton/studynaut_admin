import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart';
import 'package:studynautz/nerdscout/social/reels/tiktok_pro/constants.dart';

import '../../reg/course_adviser.dart';
import '../../reg/data_cylinder_models.dart';
import '../module_pages/module_home_page.dart';
import 'course_terms_conditions.dart';

//TODO: Just streams for these pages ...
class ChapterHomePage extends StatefulWidget {
  const ChapterHomePage({Key? key, required this.courseCode}) : super(key: key);

  final String courseCode;

  @override
  _ChapterHomePageState createState() => _ChapterHomePageState();
}

class _ChapterHomePageState extends State<ChapterHomePage> {
  var courseAdviser = Get.find<CourseAdviser>();

  final _db = Localstore.instance;
  var userProgress = <String, dynamic>{};
  var _items = <String, dynamic>{};
  List<CourseChapter> chaps = [];

  cha() {
    // final int report = courseAdviser.retrieveUserProgress(widget.courseName);
    final data = _db.collection('courses').doc(widget.courseCode).get().then(
      (value) {
        // print(value);
        if (value != null) {
          List chapters = value['chapters'] ?? [];
          // Map aint go work for this list
          chapters.forEach((element) {
            var res = CourseChapter.fromMap(element);

            print(res.chapterName);

            setState(() {
              _items.putIfAbsent(res.chapterName, () => res);
            });
          });
        } else {
          Get.snackbar('Data I?O', 'message');
        }
      },
    );
  }

  @override
  void initState() {
    cha();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseCode),
        actions: [
          IconButton(
              onPressed: () {
                // TODO: Potential bug!!
                courseAdviser.downloadFullCourse(widget.courseCode,
                    authController.superUser.value.institution);
              },
              icon: Icon(Icons.railway_alert_outlined))
        ],
      ),
      body: _items.isEmpty
          ? CourseTermsAndConditionsWidget(
              courseCode: widget.courseCode,
            )
          : ListView.builder(
              itemCount: _items.keys.length,
              itemBuilder: (context, index) {
                final key = _items.keys.elementAt(index);
                final item = _items[key]!;
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        value: item.done,
                        title: Text(item.chapterName),
                        onChanged: (value) {
                          // item.done = value!;

                          // CourseChapter.fromMap(item).save();
                          // // item.save();
                        },
                        secondary: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              // item.delete();
                              _items.remove(item.chapterName);
                            });
                          },
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => ModuleHomePage(
                                  chapterName: item.chapterName,
                                  courseName: item.courseName,
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(Icons.book)),
                            ],
                          ))
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Adding entry', 'performing handshake');
          // updateAChapterInTheDb(widget.courseName);
          // courseAdviser.acceptTerms(widget.courseName);
          // courseAdviser.evaluateOverallProgressInACourse([10,20,30,40,50,]);
        },
        tooltip: 'add',
        child: const Icon(
          Icons.archive,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  @override
  void dispose() {
    // if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}
