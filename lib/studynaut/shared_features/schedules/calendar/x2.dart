// import 'package:calendar_timeline/calendar_timeline.dart';// 
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CalendarHomePage extends StatefulWidget {
//   const CalendarHomePage({Key? key}) : super(key: key);

//   @override
//   State<CalendarHomePage> createState() => _CalendarHomePageState();
// }

// class _CalendarHomePageState extends State<CalendarHomePage> {
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _resetSelectedDate();
//   }

//   void _resetSelectedDate() {
//     _selectedDate = DateTime.now().add(const Duration(days: 0));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 240, 240),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'Your Schedules',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline6!
//                     .copyWith(color: const Color.fromARGB(255, 0, 173, 89)),
//               ),
//             ),
//             CalendarTimeline(
//               showYears: false,
//               initialDate: _selectedDate,
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
//               onDateSelected: (date) => setState(() => _selectedDate = date!),
//               leftMargin: 20,
//               monthColor: const Color.fromARGB(179, 26, 25, 25),
//               dayColor: Colors.teal[200],
//               dayNameColor: const Color(0xFF333A47),
//               activeDayColor: Colors.white,
//               activeBackgroundDayColor: const Color.fromARGB(255, 23, 205, 47),
//               dotsColor: const Color(0xFF333A47),
//               selectableDayPredicate: (date) => date.day != 23,
//               locale: 'en',
//             ),
//             const SizedBox(height: 20),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 16),
//             //   child: TextButton(
//             //     style: ButtonStyle(
//             //       backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
//             //     ),
//             //     child: const Text(
//             //       'RESET',
//             //       style: TextStyle(color: Color(0xFF333A47)),
//             //     ),
//             //     onPressed: () => setState(() => _resetSelectedDate()),
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'Selected date is $_selectedDate',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
