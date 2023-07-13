import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

import '../../../core/auth/auth_controller.dart';

class NoobieHome extends StatelessWidget {
  AuthController authController = Get.find<AuthController>();

  // Animation<double>? controller = AnimationController(vsync: this),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        authController.signOut();
      }),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 400,
            width: 300,
            child: LottieBuilder.network(
              'https://assets2.lottiefiles.com/private_files/lf30_TBKozE.json',
              animate: true,
              // repeat: false,
            ),
          ),
          Text(
            'Welcome, noobie!',
            style: TextStyle(fontFamily: 'Aspira', fontSize: 32),
          )
        ],
      )),
    );
  }
}


// 