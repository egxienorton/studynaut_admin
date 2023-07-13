import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:iconly/iconly.dart';

import 'package:intl/intl.dart';
import 'calendar_date_element.dart';
import 'calendar_event.dart';

class Calendar extends StatefulWidget {
  final bool startExpanded;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onPreviousMonth;
  final Function(DateTime) onNextMonth;
  final List<CalendarEvent> recurringEventsByWeekday;
  final List<CalendarEvent> calendarEvents;
  final List<CalendarEvent> recurringEventsByDay;

  const Calendar({
    Key? key,
    this.startExpanded = false,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.calendarEvents,
    required this.recurringEventsByWeekday,
    required this.recurringEventsByDay,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  late List<DateTime> _weekDayDateTimeList;
  bool _expanded = false;
  late DateTime _startOfMonth;
  late List<DateTime> _monthDateTimeList;
  late List<List<DateTime>> _calendarData;

  @override
  void initState() {
    _expanded = widget.startExpanded;
    _initCalendar();
    super.initState();
  }

  void _initCalendar() {
    _weekDayDateTimeList = <DateTime>[];
    _monthDateTimeList = <DateTime>[];
    _calendarData = <List<DateTime>>[];

    if (_selectedDate.day == 1) {
      _startOfMonth = _selectedDate;
    } else {
      _startOfMonth = _selectedDate.subtract(
        Duration(days: _selectedDate.day - 1),
      );
    }

    if (_startOfMonth.day != DateTime.sunday) {
      _startOfMonth = _startOfMonth.subtract(
        Duration(days: _startOfMonth.weekday),
      );
    }
    // look here below
    for (int i = 0;; i = i + 7) {
      DateTime date = _startOfMonth.add(Duration(days: i));
      List<DateTime> tempDateList = <DateTime>[];

      for (int i = 0; i < 7; i++) {
        tempDateList.add(date.add(Duration(days: i)));
      }
      _calendarData.add(tempDateList);
      if (_startOfMonth.add(Duration(days: i + 7)).month !=
          _selectedDate.month) {
        break;
      }
    }

    DateTime weekDayCalendar;
    if (_selectedDate.weekday == DateTime.sunday) {
      weekDayCalendar = _selectedDate;
    } else {
      weekDayCalendar = _selectedDate.subtract(Duration(
        days: _selectedDate.weekday,
      ));
    }
    for (int i = 0; i < 7; i++) {
      _weekDayDateTimeList.add(weekDayCalendar.add(Duration(days: i)));
    }

    for (int i = 0;; i++) {
      DateTime date = _startOfMonth.add(Duration(days: i));
      if (date.month != _selectedDate.month) {
        break;
      }
      _monthDateTimeList.add(date);
    }
  }

  void _nextMonth() {
    if (_selectedDate.month == DateTime.december) {
      _selectedDate = DateTime(
        _selectedDate.year + 1,
        1,
        _selectedDate.day,
      );
    } else {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        _selectedDate.day,
      );
    }
    setState(() {
      _initCalendar();
    });
  }

  void _previousMonth() {
    if (_selectedDate.month == DateTime.january) {
      _selectedDate = DateTime(
        _selectedDate.year - 1,
        12,
        _selectedDate.day,
      );
    } else {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month - 1,
        _selectedDate.day,
      );
    }
    setState(() {
      _initCalendar();
    });
  }

  void _selectDate(DateTime date) {
    _selectedDate = date;
    setState(() {
      _initCalendar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(414),
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(25),
          ),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: ScreenUtil().setHeight(15),
                color: SchoolToolkitColors.blackShadow,
                offset: Offset(
                  0,
                  ScreenUtil().setHeight(15),
                ),
                spreadRadius: ScreenUtil().setHeight(13),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      _previousMonth();
                      if (widget.onPreviousMonth != null) {
                        widget.onPreviousMonth(_selectedDate);
                      }
                    },
                    icon: Icon(Icons.arrow_back
                        // size: FontSize.fontSize20,
                        // color: SchoolToolkitColors.black,
                        ),
                    // icon: FaIcon(
                    //   FontAwesomeIcons.chevronLeft,
                    //   size: FontSize.fontSize20,
                    //   color: SchoolToolkitColors.black,
                    // ),
                  ),
                  Text(
                    '${DateFormat('MMMM, yyyy').format(_selectedDate)}',
                    style: TextStyle(
                      color: SchoolToolkitColors.darkBlack,
                      fontWeight: FontSize.semiBold,
                      fontSize: FontSize.fontSize20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _nextMonth();
                      if (widget.onNextMonth != null) {
                        widget.onNextMonth(_selectedDate);
                      }
                    },
                    icon: Icon(Icons.arrow_forward
                        // size: FontSize.fontSize20,
                        // color: SchoolToolkitColors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(22),
              ),
              AnimatedSize(
                // vsync: this,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: _expanded
                      ? Container(
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: _weekDayDateTimeList.map((day) {
                                  String dayInital = DateFormat('E')
                                      .format(day)
                                      .substring(0, 1);
                                  return Center(
                                    child: Text(
                                      '$dayInital',
                                      style: TextStyle(
                                        color: day.weekday ==
                                                DateTime.now().weekday
                                            ? SchoolToolkitColors.blue
                                            : SchoolToolkitColors.lightGrey,
                                        fontWeight: FontSize.semiBold,
                                        fontSize: FontSize.fontSize20,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              for (List<DateTime> dateList
                                  in _calendarData) ...[
                                TableRow(
                                  children: [
                                    for (int i = 0; i < 7; i++)
                                      Container(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                  ],
                                ),
                                TableRow(
                                  children: dateList.map((date) {
                                    return Column(
                                      children: <Widget>[
                                        CalendarDateElement(
                                          date: date.day,
                                          today:
                                              date.day == DateTime.now().day &&
                                                  date.month ==
                                                      DateTime.now().month,
                                          fade:
                                              date.month != _selectedDate.month,
                                          selected: date.day ==
                                                  _selectedDate.day &&
                                              date.month == _selectedDate.month,
                                          onTap: () {
                                            _selectDate(date);
                                            if (widget.onDateSelected != null) {
                                              widget.onDateSelected(date);
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5.0),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(6),
                                          height: ScreenUtil().setWidth(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: CalendarUtils
                                                .getCalendarEventColor(
                                              date,
                                              widget.recurringEventsByWeekday,
                                              widget.recurringEventsByDay,
                                              widget.calendarEvents,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        )
                      : Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: _weekDayDateTimeList.map((day) {
                                String dayInitial =
                                    DateFormat('E').format(day).substring(0, 1);
                                return Center(
                                  child: Text(
                                    '$dayInitial',
                                    style: TextStyle(
                                      color:
                                          day.weekday == DateTime.now().weekday
                                              ? SchoolToolkitColors.blue
                                              : SchoolToolkitColors.lightGrey,
                                      fontWeight: FontSize.semiBold,
                                      fontSize: FontSize.fontSize20,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            TableRow(
                              children: [
                                for (int i = 0; i < 7; i++)
                                  Container(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                              ],
                            ),
                            TableRow(
                              children: _weekDayDateTimeList.map((date) {
                                return Column(
                                  children: <Widget>[
                                    CalendarDateElement(
                                      date: date.day,
                                      today: date.day == DateTime.now().day &&
                                          date.month == DateTime.now().month,
                                      fade: date.month != _selectedDate.month,
                                      selected: date.day == _selectedDate.day &&
                                          date.month == _selectedDate.month,
                                      onTap: () {
                                        _selectDate(date);
                                        if (widget.onDateSelected != null) {
                                          widget.onDateSelected(date);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(5.0),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(6),
                                      height: ScreenUtil().setWidth(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            CalendarUtils.getCalendarEventColor(
                                          date,
                                          widget.recurringEventsByWeekday,
                                          widget.recurringEventsByDay,
                                          widget.calendarEvents,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Container(
              width: ScreenUtil().setWidth(66),
              height: ScreenUtil().setHeight(30),
              color: SchoolToolkitColors.lighterBlue,
              child: Icon(
                _expanded ? IconlyBold.arrow_up_2 : IconlyBold.arrow_down_2,
                color: SchoolToolkitColors.blue,
                size: ScreenUtil().setWidth(18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CalendarUtils {
  /// holday takes precedence over other colors

  /// holday takes precedence over other colors
  static Color getCalendarEventColor(
    DateTime date,
    List<CalendarEvent> recurringEventsByWeekday,
    List<CalendarEvent> recurringEventsByDay,
    List<CalendarEvent> calendarEvents,
  ) {
    Color color = Colors.transparent;
    CalendarEvent? holidayEvent;

    if (checkIfRecurringByWeekDay(date, recurringEventsByWeekday)) {
      recurringEventsByWeekday.forEach((element) {
        if (element.weekDay == date.weekday) {
          if (element.holiday) {
            holidayEvent = element;
            color = element.color;
          } else if (holidayEvent == null) {
            color = element.color;
          }
        }
      });
    }

    if (checkIfRecurringByDay(date, recurringEventsByDay)) {
      recurringEventsByDay.forEach((element) {
        if (element.dateTime.day == date.day) {
          if (element.holiday) {
            holidayEvent = element;
            color = element.color;
          } else if (holidayEvent == null) {
            color = element.color;
          }
        }
      });
    }

    if (checkIfCalendarEvent(date, calendarEvents)) {
      calendarEvents.forEach((element) {
        if (element.dateTime.day == date.day &&
            element.dateTime.month == date.month &&
            element.dateTime.year == date.year) {
          if (element.holiday) {
            holidayEvent = element;
            color = element.color;
          } else if (holidayEvent == null) {
            color = element.color;
          }
        }
      });
    }

    return color;
  }

  static bool checkIfRecurringByDay(
      DateTime date, List<CalendarEvent> eventList) {
    if (eventList == null) return false;
    return eventList.indexWhere((event) => event.dateTime.day == date.day) !=
        -1;
  }

  static bool checkIfCalendarEvent(
      DateTime date, List<CalendarEvent> eventList) {
    if (eventList == null) return false;
    return eventList.indexWhere((event) => (event.dateTime.day == date.day &&
            event.dateTime.month == date.month &&
            event.dateTime.year == date.year)) !=
        -1;
  }

  static bool checkIfRecurringByWeekDay(
      DateTime date, List<CalendarEvent> eventList) {
    if (eventList == null) return false;
    return eventList.indexWhere((event) => event.weekDay == date.weekday) != -1;
  }
}

class FontSize {
  static const double _fontSize10 = 10.0;
  static const double _fontSize12 = 12.0;
  static const double _fontSize14 = 14.0;
  static const double _fontSize15 = 15.0;
  static const double _fontSize16 = 16.0;
  static const double _fontSize18 = 18.0;
  static const double _fontSize20 = 20.0;
  static const double _fontSize22 = 22.0;
  static const double _fontSize24 = 24.0;
  static const double _fontSize26 = 26.0;
  static const double _fontSize28 = 28.0;
  static const double _fontSize30 = 30.0;
  static const double _fontSize32 = 32.0;
  static const double _fontSize34 = 34.0;
  static const double _fontSize36 = 36.0;

  static double get fontSize10 => ScreenUtil().setSp(_fontSize10);
  static double get fontSize12 => ScreenUtil().setSp(_fontSize12);
  static double get fontSize14 => ScreenUtil().setSp(_fontSize14);
  static double get fontSize15 => ScreenUtil().setSp(_fontSize15);
  static double get fontSize16 => ScreenUtil().setSp(_fontSize16);
  static double get fontSize18 => ScreenUtil().setSp(_fontSize18);
  static double get fontSize20 => ScreenUtil().setSp(_fontSize20);
  static double get fontSize22 => ScreenUtil().setSp(_fontSize22);
  static double get fontSize24 => ScreenUtil().setSp(_fontSize24);
  static double get fontSize26 => ScreenUtil().setSp(_fontSize26);
  static double get fontSize28 => ScreenUtil().setSp(_fontSize28);
  static double get fontSize30 => ScreenUtil().setSp(_fontSize30);
  static double get fontSize32 => ScreenUtil().setSp(_fontSize32);
  static double get fontSize34 => ScreenUtil().setSp(_fontSize34);
  static double get fontSize36 => ScreenUtil().setSp(_fontSize36);

  static FontWeight get thin => FontWeight.w100;
  static FontWeight get extraLight => FontWeight.w200;
  static FontWeight get light => FontWeight.w300;
  static FontWeight get regular => FontWeight.w400;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get semiBold => FontWeight.w600;
  static FontWeight get bold => FontWeight.w700;
  static FontWeight get extraBold => FontWeight.w800;
  static FontWeight get black => FontWeight.w900;
}
