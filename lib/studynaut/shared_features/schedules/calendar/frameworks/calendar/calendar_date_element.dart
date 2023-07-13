import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'calendar.dart';
import 'calendar_event.dart';

class ScreenSize {
  static const double width = 414.0;
  static const double height = 896.0;
}

class CalendarDateElement extends StatelessWidget {
  final int date;
  final bool today;
  final bool fade;
  final Function() onTap;
  final bool selected;

  const CalendarDateElement({
    Key? key,
    required this.date,
    this.today = false,
    this.fade = false,
    required this.onTap,
    this.selected = false,
  })  : assert(date != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (ScreenUtil() == null) {
    //   ScreenUtil.init(
    //     // context,
    //     designSize: Size(
    //       ScreenSize.width,
    //       ScreenSize.height,
    //     ),
    //     // minTextAdapt: true,
    //     allowFontScaling: true,
    //     // i think that is the old way to say things
    //   );
    // }

    if (today) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setWidth(40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: SchoolToolkitColors.lighterBlue,
            border: Border.all(
              color: today && selected
                  ? SchoolToolkitColors.blue
                  : Colors.transparent,
              width: ScreenUtil().setWidth(2.0),
            ),
          ),
          child: Text(
            '$date',
            style: TextStyle(
              color: SchoolToolkitColors.blue,
              fontSize: FontSize.fontSize16,
              fontWeight: FontSize.semiBold,
            ),
          ),
        ),
      );
    } else if (selected) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setWidth(40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: SchoolToolkitColors.lighter_blue,
            border: Border.all(
              color: SchoolToolkitColors.blue,
              width: ScreenUtil().setWidth(2.0),
            ),
          ),
          child: Text(
            '$date',
            style: TextStyle(
              color: SchoolToolkitColors.blue,
              fontSize: FontSize.fontSize16,
              fontWeight: FontSize.semiBold,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setWidth(40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Text(
            '$date',
            style: TextStyle(
              color: fade
                  ? SchoolToolkitColors.lightGrey
                  : SchoolToolkitColors.darkBlack,
              fontSize: FontSize.fontSize16,
              fontWeight: FontSize.semiBold,
            ),
          ),
        ),
      );
    }
  }
}
