import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:studynaut_admin/core/typography/curtina.dart';
import 'package:shimmer/shimmer.dart';

class StackOverflowPlaceHolder extends StatelessWidget {
  const StackOverflowPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 70.0,
      decoration:
          roundContainer.copyWith(color: Theme.of(context).primaryColorDark),
      // color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: 10.0,
      decoration: roundContainer.copyWith(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.4),
      highlightColor: Colors.blueGrey.withOpacity(0.1),
      child: EasySeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
        children: [
          EasySeparatedColumn(
            children: [
              line,
              // line,
              // line,
            ],
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 5,
              );
            },
          ),
          answer,
          // answer,
          // answer,
          // answer,

          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
