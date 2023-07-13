import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'core/auth/auth_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAyURvUzwekH06icjINFTrZtyiAtnzpS6A",
        appId: "1:92926142869:web:6623e33d214c61baf6ae9c",
        messagingSenderId: "92926142869",
        projectId: "quizzle-demo-ac8e4",
        storageBucket: "quizzle-demo-ac8e4.appspot.com"),
  );
  InitialBinding().dependencies();

  // Get.put(QuizController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Studynaut Web',
        // theme: FlexColorScheme.dark().toTheme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fade,
        home: SplashScreen());
    // return
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    // Get.put(NavigationController());
  }
}

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 350,
        width: 300,
        child: LottieBuilder.network(
          // 'https://assets5.lottiefiles.com/packages/lf20_AMBEWz.json',
          'https://assets10.lottiefiles.com/private_files/lf30_ployuqvp.json',
          animate: true,
        ),
      )),
    );
  }
}
