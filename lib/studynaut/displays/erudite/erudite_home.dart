import 'package:flutter/material.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

class EruditeHome extends StatelessWidget {
  const EruditeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'For Erudite Studs',
          style: AppTypography.header1(context),
        ),
      ),
    );
  }
}
