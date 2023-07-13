import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studynautz/core/data/storageRaid0.dart';

import 'calendar_event.dart';

class ScheduleController extends GetxController {
  Rx<List<CalendarEvent>> selectedEvent = Rx<List<CalendarEvent>>([]);
  Rx<List<CalendarEvent>> masterList = Rx<List<CalendarEvent>>([]);
  Rx<List<CalendarEvent>> calendarEvents = Rx<List<CalendarEvent>>([]);

  late DateTime selectedDate;

  // bool noClasses= masterList.value.length == 0 ? true : false;

  @override
  void onReady() {
    injector();
    super.onReady();
  }

  injector() async {
    print('spinning up the server');
    List<Map<String, dynamic>> userSchedulesMap = [
      {
        'title': 'MTH 110',
        'description': 'Algebra and Trigonometry',
        'venue': 'Old 1000LT',
        'lecturer': 'Paul Ekoko',
        'duration': '2 hrs',
        'classId': 'MTH110ENG100',
        'dateTime': '2022-06-12 08:30:00'

        // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
        // 'color': SchoolToolkitColors.blue,
      },
      {
        'title': 'MTH 112',
        'description': 'Calculus',
        'venue': 'Old 1000LT',
        'lecturer': 'Paul Ekoko',
        'duration': '2 hrs',
        'classId': 'MTH110ENG100',
        'dateTime': '2022-06-13 09:30:00'

        // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
        // 'color': SchoolToolkitColors.blue,
      },
      {
        'title': 'PHY 111',
        'description': 'Algebra and Trigonometry',
        'venue': 'Old 1000LT',
        'lecturer': 'Paul Ekoko',
        'duration': '2 hrs',
        'classId': 'MTH110ENG100',
        'dateTime': '2022-06-14 08:30:00'

        // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
        // 'color': SchoolToolkitColors.blue,
      },
      {
        'title': 'PHY 113',
        'description': 'Algebra and Trigonometry',
        'venue': 'Old 1000LT',
        'lecturer': 'Paul Ekoko',
        'duration': '2 hrs',
        'classId': 'MTH110ENG100',
        'dateTime': '2022-06-15 18:30:00'

        // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
        // 'color': SchoolToolkitColors.blue,
      },
    ];

    studentCredentials.write('userSchedules', userSchedulesMap);

    calendarEvents.value = [
      // CalendarEvent.fromDateTime(
      //   dateTime: DateTime.now(),
      //   color: SchoolToolkitColors.blue,
      // ),
      // CalendarEvent.fromDateTime(
      //   dateTime: DateTime(2022, 2, 24),
      //   color: SchoolToolkitColors.red,
      // ),
    ];

    List<Map<String, dynamic>> schedules = await studentCredentials
        .read('userSchedules') as List<Map<String, dynamic>>;
    List result = schedules.map((element) {
      var item = CalendarEvent.fromJson(element);

      calendarEvents.value.add(item);
    }).toList();
    print(calendarEvents);
  }

  updateSchedules() async {
    List<dynamic>? getter;
    Map<String, dynamic>? main;
    // String institution = userCredential.read('institution');
    // QuerySnapshot courseData = await firestore
    //     .collection('colleges')
    //     .doc('UNIBEN')
    //     .collection('Faculties')
    //     .doc('level').collection('100')
    //     ..snapshots();
  }
}
