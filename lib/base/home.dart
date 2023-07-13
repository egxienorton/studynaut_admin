import 'package:flutter/material.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

class AdminBaseHome extends StatelessWidget {
  const AdminBaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Admin Homepage',
          // style: AppTypography.header1(context),
        ),
      ),
    );
  }
}
