import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookPlaceHolder extends StatelessWidget {
  // const LeaderBoardPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.blueGrey.withOpacity(0.1),
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
        ));
  }
}
