import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class CalendarEvent {
  final String title;
  final String duration;
  final String lecturer;
  final String venue;
  final String description;
  final DateTime dateTime;
  final int weekDay;
  final Color color;
  final bool holiday;

  CalendarEvent(
      {required this.title,
      required this.color,
      required this.weekDay,
      required this.holiday,
      required this.description,
      required this.venue,
      required this.lecturer,
      required this.dateTime,
      required this.duration});

  factory CalendarEvent.fromJson(Map<String, dynamic> jsonData) {
    return CalendarEvent(
      // title: jsonData['id'],
      title: jsonData['title'],
      weekDay: jsonData['weekDay'] ?? 3,
      description: jsonData['description'],
      venue: jsonData['venue'],
      duration: jsonData['duration'],
      lecturer: jsonData['lecturer'],
      dateTime: DateTime.parse(jsonData['dateTime']),
      color: jsonData['color'] ?? SchoolToolkitColors.blue,
      // tryna do some nullable stuff
      holiday: jsonData['holiday'] ?? false,
    );
  }

  // what the hell do i need an holiday for..

  // CalendarEvent.fromDateTime({
  //   required this.dateTime,
  //   this.color = SchoolToolkitColors.blue,
  //   this.holiday = false,
  // });

  //  factory CalendarEvent.fromJson(Map<String, dynamic> jsonData) {
  //   return CalendarEvent(
  //    { required this.title,
  //   required this.description,
  //   required this.duration,
  //   required this.lecturer,
  //   required this.dateTime,
  //   this.color = SchoolToolkitColors.blue,
  //   this.holiday = false,}
  //   );
  // }

  // CalendarEvent.fromTimeTable({
  //   required this.title,
  //   required this.description,
  //   required this.duration,
  //   required this.lecturer,
  //   required this.dateTime,
  //   this.color = SchoolToolkitColors.blue,
  //   this.holiday = false,
  // });

  // CalendarEvent.fromWeekDay({
  //   required this.weekDay,
  //   this.color = SchoolToolkitColors.blue,
  //   this.holiday = false,
  // });
}

class SchoolToolkitColors {
  static const Color blueGrey = Color(0xfff0f0f8);
  static const Color lightGrey = Color(0xffCDD1D5);
  static const Color lighterGrey = Color(0xffF1F3F8);
  static const Color grey = Color(0xff7D85A3);
  static const Color darkGrey = Color(0xff656B7D);
  static const Color mediumGrey = Color(0xffA2A7BC);
  static const Color greyShadow = Color(0x172E631C);

  static const Color black = Color(0xff4D4E51);
  static const Color darkBlack = Color(0xff1A1D23);
  static const Color lightBlack = Color(0xff818181);

  static const Color blue = Color(0xff3362CC);
  static const Color lightBlue = Color(0xff3D72DE);
  static const Color lighterBlue = Color(0xffEAEFFA);

  static const Color yellow = Color(0xffFBD46D);
  static const Color darkYellow = Color(0xffFFC758);

  static const Color blackShadow = Color(0x0500000D);

  static const Color brown = Color(0xff965519);
  static const Color lightBrown = Color(0xffFDECDC);

  static const Color green = Color(0xff248484);
  static const Color tealGreen = Color(0xff27B893);
  static const Color lightGreen = Color(0xffD8F9F5);

  static const Color red = Color(0xffFF3131);
}
