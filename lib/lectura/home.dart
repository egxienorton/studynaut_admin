import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:studynaut_admin/core/auth/auth_controller.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

class LecturaHome extends StatelessWidget {
  // const LecturaHome({super.key});

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
              'https://assets5.lottiefiles.com/packages/lf20_AMBEWz.json',
              animate: true,
              repeat: false,
            ),
          ),
          Text(
            'Welcome, Lectura!',
            style: TextStyle(fontFamily: 'Aspira', fontSize: 32),
          )
        ],
      )),
    );
  }
}
