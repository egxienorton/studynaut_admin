import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

import 'auth/auth_controller.dart';

class NoScreen extends StatelessWidget {
  // const NoScreen({super.key});

  AuthController authController = Get.find<AuthController>();

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
              'https://assets7.lottiefiles.com/private_files/lf30_tonsVH.json',
              animate: true,
            ),
          ),
          Text(
            'Oops, Something went wrong \n That\'s all we know.',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Aspira', fontSize: 32),
          )
        ],
      )),
    );
  }
}
