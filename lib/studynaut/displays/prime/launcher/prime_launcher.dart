import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:studynaut_admin/core/auth/auth_controller.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/studynaut/displays/prime/pages/dashboard.dart';

class PrimeLauncher extends StatelessWidget {
  // const PrimeHome({super.key});
  AuthController authController = Get.find<AuthController>();

  // Animation<double>? controller = AnimationController(vsync: this),

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        authController.signOut();
      }),
      backgroundColor:
          (size.width > 984 && size.height > 604) ? Colors.white : Colors.black,
      body: SizedBox(
        child: (size.width > 1184 && size.height > 604)
            ? PrimeDashBoard()
            // Center(
            //     child: Column(
            //     children: [
            //       SizedBox(
            //         height: 400,
            //         width: 300,
            //         child: LottieBuilder.network(
            //           'https://assets5.lottiefiles.com/packages/lf20_AMBEWz.json',
            //           animate: true,
            //           repeat: false,
            //         ),
            //       ),
            //       Text(
            //         'Welcome, prime kid',
            //         style: TextStyle(fontFamily: 'Aspira', fontSize: 32),
            //       )
            //     ],
            //   ))
            : Center(
                child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    width: 300,
                    child: LottieBuilder.asset(
                      'assets/lottieFiles/smallScreenLottie.json',
                      animate: true,
                    ),
                  ),
                  Container(
                    width: size.width * 0.5,
                    child: Text(
                      'Please your current window size is insufficient for optimal use of this web app. Kindly maximize your window for an optimal experience."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Satoshis',
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  )
                ],
              )),
      ),
    );
  }
}
