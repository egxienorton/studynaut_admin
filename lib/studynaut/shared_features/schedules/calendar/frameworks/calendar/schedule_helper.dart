import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../calendar/calendar.dart'; // out of the folder and then back in again, no be juju be that
import '../calendar/calendar_date_element.dart';
import '../calendar/calendar_event.dart';
import 'schedule_controller.dart';

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     'My Schedule',
          //     style: TextStyle(color: Colors.black87),
          //   ),
          //   actions: [
          //     IconButton(
          //       onPressed: () {
          //         // _showAddDialog();
          //         print('implement add');
          //       },
          //       icon: Icon(Icons.add),
          //       color: Colors.black,
          //     )
          //   ],
          //   elevation: 0,
          //   centerTitle: true,
          //   backgroundColor: Colors.transparent,
          // ),
          body: child,
        );
      },
      child: TimetableStuff(),
    );

    // return ScreenUtilInit(
    //     designSize: Size(360, 690),
    //     minTextAdapt: true,
    //     splitScreenMode: true,
    //     builder: () => MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           title: 'Flutter_ScreenUtil',
    //           theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //             textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
    //           ),
    //           builder: (context, widget) {
    //             ScreenUtil.setContext(context);
    //             return MaterialApp(
    //               //Setting font does not c
    //               //hange with system font size
    //               debugShowCheckedModeBanner: false,
    //               home: const TimetableStuff(),
    //             );
    //           },
    //         ));
  }
}

class TimetableStuff extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());
  // const TimetableStuff({Key? key}) : super(key: key);

//   @override
//   _TimetableStuffState createState() => _TimetableStuffState();
// }

// class _TimetableStuffState extends State<TimetableStuff> {
//   // late DateTime onDateSelected;
//   late DateTime _selectedDate;
//   // late List<CalendarEvent> _calendarEvents;
//   late List<CalendarEvent> _selectedEvent;
//   late List<CalendarEvent> _masterList;
//   List<CalendarEvent> _calendarEvents = [];
//   late bool noClasses;
//   // late SharedPreferences prefs;

//   TextEditingController _eventController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   List<Map<String, dynamic>> userSchedulesMap = [
  //     {
  //       'title': 'MTH 110',
  //       'description': 'Algebra and Trigonometry',
  //       'venue': 'Old 1000LT',
  //       'lecturer': 'Paul Ekoko',
  //       'duration': '2 hrs',
  //       'classId': 'MTH110ENG100',
  //       'dateTime': '2022-06-12 08:30:00'

  //       // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
  //       // 'color': SchoolToolkitColors.blue,
  //     },
  //     {
  //       'title': 'MTH 112',
  //       'description': 'Calculus',
  //       'venue': 'Old 1000LT',
  //       'lecturer': 'Paul Ekoko',
  //       'duration': '2 hrs',
  //       'classId': 'MTH110ENG100',
  //       'dateTime': '2022-06-13 09:30:00'

  //       // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
  //       // 'color': SchoolToolkitColors.blue,
  //     },
  //     {
  //       'title': 'PHY 111',
  //       'description': 'Algebra and Trigonometry',
  //       'venue': 'Old 1000LT',
  //       'lecturer': 'Paul Ekoko',
  //       'duration': '2 hrs',
  //       'classId': 'MTH110ENG100',
  //       'dateTime': '2022-06-14 08:30:00'

  //       // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
  //       // 'color': SchoolToolkitColors.blue,
  //     },
  //     {
  //       'title': 'PHY 113',
  //       'description': 'Algebra and Trigonometry',
  //       'venue': 'Old 1000LT',
  //       'lecturer': 'Paul Ekoko',
  //       'duration': '2 hrs',
  //       'classId': 'MTH110ENG100',
  //       'dateTime': '2022-06-15 18:30:00'

  //       // TRYING HANDS-ON ON THE REAL TIME INTERVAL SITUATIONS
  //       // 'color': SchoolToolkitColors.blue,
  //     },
  //   ];
  //   // var superSchedule = jsonEncode(userSchedulesMap);
  //   userCredential.write('userSchedule5', userSchedulesMap);
  //   getSchedules();

  //   super.initState();

  //   // void fetchEventsFromGetx() {
  //   //   // var eventGotten = CalendarEvent.fromJson(schedules);

  //   //   print(eventGotten);
  //   // }

  //   // userCredential.remove('userSchedule');

  //   // userSchedulesMap[0].keys.elementAt(1);
  //   // doing some fetching stuffs...

  //   _calendarEvents = [
  //     CalendarEvent.fromDateTime(
  //       dateTime: DateTime.now(),
  //       color: SchoolToolkitColors.blue,
  //     ),
  //     CalendarEvent.fromDateTime(
  //       dateTime: DateTime(2022, 2, 24),
  //       color: SchoolToolkitColors.red,
  //     ),
  //   ];
  //   _selectedEvent = [];
  //   _masterList = [];
  //   bool noClasses = _masterList.length == 0 ? true : false;
  // }

  // getSchedules() async {
  //   print('spinnin');
  //   List<CalendarEvent> demoList = [];
  //   List<Map<String, dynamic>> schedules = await userCredential
  //       .read('userSchedule5') as List<Map<String, dynamic>>;
  //   // print(schedules);
  //   List result = schedules.map((element) {
  //     var item = CalendarEvent.fromJson(element);

  //     demoList.add(item);
  //   }).toList();

  //   _calendarEvents.addAll(demoList);
  //   setState(() {});

  //   // print(schedules);

  //   List lister = [];
  //   _calendarEvents.map((e) {
  //     var r = e.dateTime;
  //     print(r);

  //     lister.add(r);
  //   }).toList();
  //   print(lister);
  // }

  // // initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _selectedEvent =List<CalendarEvent>.from(
  //         decodeMap(json.decode(prefs.getString("events") ?? "{}")));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your schedules'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(child: Text('Refresh')),
                const PopupMenuItem<String>(child: Text('Settings')),
                const PopupMenuItem<String>(child: Text('Change Semester')),
              ];
            },
            onSelected: (value) {
              print(value);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Calendar(
                startExpanded:
                    false, // set this to false if you need the calendar to be built shrinked (show only active week)
                onDateSelected: (date) {
                  scheduleController.selectedDate = date;

                  // scheduleController.calendarEvents =
                  //     scheduleController.selectedEvent;

                  // scheduleController.masterList.value = scheduleController
                  //     .selectedEvent.value
                  //     .where((i) =>
                  //         i.dateTime.day == scheduleController.selectedDate.day)
                  //     //the above constructor did not have the .day methods on both sides.. debug this later on
                  //     .toList();

                  // the weed from the chaff
                  // scheduleController.calendarEvents.value =
                  //     scheduleController.selectedEvent.value;

                  scheduleController.masterList.value = scheduleController
                      .calendarEvents.value
                      .where((i) =>
                          i.dateTime.day == scheduleController.selectedDate.day)
                      //the above constructor did not have the .day methods on both sides.. debug this later on
                      .toList();

                  // print('Selected data: ${scheduleController.selectedDate}');
                  print(
                      'selectedEvent.value: ${scheduleController.calendarEvents.value}');

                  print('masterList: ${scheduleController.masterList.value}');
                  // handle date selection
                },
                onNextMonth: (date) {
                  print('Next month: $date');
                  // handle on next month.
                },
                onPreviousMonth: (date) {
                  print('Previous month: $date');
                  // handle previous month
                },
                calendarEvents: scheduleController.calendarEvents.value,
                // [
                //   CalendarEvent.fromDateTime(
                //     dateTime: DateTime.now(),
                //     color: SchoolToolkitColors.blue,
                //   ),
                //   CalendarEvent.fromDateTime(
                //     dateTime: DateTime(2022, 2, 24),
                //     color: SchoolToolkitColors.red,
                //   ),
                // ],
                recurringEventsByDay: [
                  // CalendarEvent.fromDateTime(
                  //   dateTime: DateTime(2020, 6, 2),
                  //   color: SchoolToolkitColors.blue,
                  // ),
                  // CalendarEvent.fromDateTime(
                  //   dateTime: DateTime(2020, 7, 3),
                  //   color: SchoolToolkitColors.red,
                  // ),
                ],
                recurringEventsByWeekday: [
                  // CalendarEvent.fromWeekDay(
                  //   weekDay: DateTime.monday,
                  //   color: SchoolToolkitColors.red,
                  //   holiday: true,
                  // ),
                ],
              ),
            ),

            //some functionality here

            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Syncing '),
            //       IconButton(
            //           onPressed: () {
            //             // _showAddDialog();
            //           },
            //           icon: Icon(Icons.calendar_today))
            //     ],
            //   ),
            // ),

            Container(
              height: 200,
              child: Obx(() => ListView.builder(
                  itemCount: scheduleController.masterList.value.length,
                  itemBuilder: (context, index) {
                    var info = scheduleController.masterList.value[index];
                    return EventCard(
                      event: info.title,
                      description: info.description,
                      venue: info.venue,
                      lecturer: info.lecturer,
                      time: info.duration,
                      secondaryColor: SchoolToolkitColors.lighterGrey,
                      primaryColor: SchoolToolkitColors.grey,
                      height: ScreenUtil().setHeight(80),
                      width: ScreenUtil().setWidth(374),
                    );
                  })),
            )

            // ...scheduleController.masterList.value.map(
            //   (CalendarEvent) => EventCard(
            //     event: CalendarEvent.title,
            //     description: CalendarEvent.description,
            //     venue: CalendarEvent.venue,
            //     lecturer: CalendarEvent.lecturer,
            //     time: CalendarEvent.duration,
            //     secondaryColor: SchoolToolkitColors.lighterGrey,
            //     primaryColor: SchoolToolkitColors.grey,
            //     height: ScreenUtil().setHeight(80),
            //     width: ScreenUtil().setWidth(374),
            //   ),
            // ),

            // ..._calendarEvents.map(
            //   (CalendarEvent) => EventCard(
            //     event: CalendarEvent.title,
            //     time: CalendarEvent.duration,
            //     secondaryColor: SchoolToolkitColors.lighterGrey,
            //     primaryColor: SchoolToolkitColors.grey,
            //     height: ScreenUtil().setHeight(80),
            //     width: ScreenUtil().setWidth(374),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // void _selectDate(DateTime date) {
  //   _selectedDate = date;
  //   setState(() {
  //     _initCalendar();
  //   });
  // }

  // _showAddDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: TextField(
  //               controller: _eventController,
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text("Save"),
  //                 onPressed: () {
  //                   if (_eventController.text.isEmpty) return;

  //                   setState(() {
  //                     if (_selectedDate != null) {
  //                       _selectedEvent.add(
  //                         CalendarEvent.fromTimeTable(
  //                           title: _eventController.text,
  //                           description: 'Algebra and Trigonometry',
  //                           lecturer: 'Engr. Linus',
  //                           duration: '2 hrs',
  //                           dateTime: _selectedDate,
  //                           color: SchoolToolkitColors.blue,
  //                         ),
  //                       );
  //                       print(_masterList.toList());
  //                       Navigator.pop(context);
  //                     }
  //                     _masterList = _selectedEvent
  //                         .where((i) => i.dateTime == _selectedDate)
  //                         .toList();
  //                   });
  //                 },
  //               )
  //             ],
  //           ));
  //   // setState(() {
  //   //   _selectedEvents = _events[_controller.selectedDay];
  //   // });
  // }
}

class EventCard extends StatelessWidget {
  final double width;
  final double height;
  final String time;
  final String event;
  final String description;
  final String venue;
  final String lecturer;
  final Color primaryColor;
  final Color secondaryColor;

  const EventCard({
    Key? key,
    required this.width,
    required this.height,
    required this.time,
    required this.event,
    required this.description,
    required this.venue,
    required this.lecturer,
    this.primaryColor = SchoolToolkitColors.brown,
    this.secondaryColor = SchoolToolkitColors.lightBrown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      // deviceSize: Size(ScreenSize.width, ScreenSize.height),
      designSize: const Size(360, 690),
      // orientation: Orientation.portrait
    );

    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
            title: '$event',
            content: Column(
              children: [
                Text(time),
                Text(description),
                Text(venue),
                Text(lecturer),
                // Text('$time'),
              ],
            ));
      },
      child: SchoolToolkitCard(
        margin: const EdgeInsets.all(1),
        width: ScreenUtil().setWidth(374),
        height: ScreenUtil().setHeight(80),
        backgroundColor: secondaryColor,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$time',
              style: TextStyle(
                color: SchoolToolkitColors.darkBlack,
                fontWeight: FontSize.semiBold,
                fontSize: FontSize.fontSize14,
              ),
            ),
            Text(
              '$event',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontSize.semiBold,
                fontSize: FontSize.fontSize16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SchoolToolkitCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color activeColor;
  final bool active;
  final Duration animationDuration;
  final Alignment alignment;
  final double width;
  final double height;
  final bool showShadow;
  final EdgeInsets margin;

  const SchoolToolkitCard({
    Key? key,
    required this.child,
    this.backgroundColor = SchoolToolkitColors.blueGrey,
    this.activeColor = SchoolToolkitColors.blue,
    this.active = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.alignment = Alignment.center,
    required this.width,
    required this.height,
    this.showShadow = false,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      // deviceSize: Size(ScreenSize.width, ScreenSize.height),
      designSize: const Size(360, 690),
      // orientation: Orientation.portrait,
    );
    return AnimatedContainer(
      duration: animationDuration,
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(15),
      ),
      margin: margin,
      curve: Curves.ease,
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: active ? activeColor : backgroundColor,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setWidth(10),
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: ScreenUtil().setHeight(15),
                  color: SchoolToolkitColors.blackShadow,
                  offset: Offset(
                    0,
                    ScreenUtil().setHeight(15),
                  ),
                  spreadRadius: ScreenUtil().setHeight(13),
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
