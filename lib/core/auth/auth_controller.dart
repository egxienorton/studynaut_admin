import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:studynaut_admin/base/home.dart';
import 'package:studynaut_admin/core/404.dart';
import 'package:studynaut_admin/core/auth/pureLogin/pure_Login.dart';
import 'package:studynaut_admin/lectura/home.dart';

import '../../studynaut/displays/erudite/erudite_home.dart';
import '../../studynaut/displays/noobie/noobie_home.dart';
import '../../studynaut/displays/prime/launcher/prime_launcher.dart';
import '../models/roleUser.dart';
import '../utils/dialogs/xDialogs.dart';

class UserLevel {
  // refactor this level word to maybe rank or something else
  static const USERLEVEL = "userLevel";
  static const ROLE = "role";
  static const PROFILEINITIALIZED = "profile_initialized";
  String value;
  bool? filledForm;
  String role;
  UserLevel(this.value, this.role);
  UserLevel.fromJson(Map<String, dynamic> json)
      : this.value = json['value'],
        this.role = json['role'],
        this.filledForm = json['profile_initialized'];

  UserLevel.fromDocumentSnapshot(
      // QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : value = snapshot[USERLEVEL],
        role = snapshot[ROLE],
        filledForm = snapshot[PROFILEINITIALIZED];

  UserLevel.fromDocumentMap(
      // QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      Map<String, dynamic> snapshot)
      : value = snapshot[USERLEVEL],
        role = snapshot[ROLE],
        filledForm = snapshot[PROFILEINITIALIZED];

  Map<String, dynamic> toJson() =>
      {'value': value, 'role': role, 'filledForm': filledForm};
}

class AuthController extends GetxController {
// move these controllers to login controllers free up some memory once user is authenticated
  //! For traversing the schedules
  Rx<List<String>> institutionList =
      Rx<List<String>>(['Select an institution']);
  Rx<Map<String, dynamic>> institutionBallot =
      Rx<Map<String, dynamic>>({'Select an institution': 'None Selected'});
  Rx<List<dynamic>> collegeList = Rx<List<dynamic>>(['Select a faculty']);
  Rx<List<String>> facultyList = Rx<List<String>>(['Select a faculty']);
  Rx<List<String>> departmentList =
      Rx<List<String>>(['Choose your department']);

  //TODO: A default value or the first should be poured here..

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List<dynamic> get listOfColleges => collegeList.value;

  Rx<UserLevel> _userLevel = Rx<UserLevel>(UserLevel('', ''));

  UserLevel get userLevelGetter => _userLevel.value;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var valueparser = ''.obs;
  var role = ''.obs;

  getFaculties(String institution) async {
    // List<dynamic>? faculties;
    Map<String, dynamic>? getter;
    DocumentSnapshot facultiesData =
        await firestore.collection('colleges').doc(institution).get();

    if (facultiesData.exists) {
      getter = facultiesData.data() as Map<String, dynamic>?;
    }
    // faculties = getter?['General List'];

    // faculties.forEach((element) { });
    facultyList.value.clear();
    facultyList.value = List<String>.from(getter?['General List']);
    Get.snackbar('faculties in ${institution}', "Fetched");
    // collegeList.value = faculties!;
    // print(faculties);
  }

  getDepartments(String institution, String faculty) async {
    Map<String, dynamic>? getter;
    DocumentSnapshot departmentsData =
        await firestore.collection('colleges').doc(institution).get();
    if (departmentsData.exists) {
      getter = departmentsData.data() as Map<String, dynamic>?;
    }

    departmentList.value.clear();

    if (getter?['Faculties'][faculty] != null) {
      departmentList.value =
          List<String>.from(getter?['Faculties'][faculty]['Departments']);
    } else {
      departmentList.value = ['No departments here'];
    }
  }

  Rx<RoleUser> roleUser = Rx<RoleUser>(RoleUser(
      role: "",
      id: "",
      firstName: "",
      middleName: "",
      lastName: "",
      avatarUrl: "",
      image: "",
      about: "",
      nickname: "",
      createdAt: "",
      isOnline: false,
      lastActive: "",
      email: "",
      pushToken: "",
      dateOfBirth: "",
      level: "",
      department: "",
      faculty: "",
      matriculationNumber: "",
      institution: "",
      phoneNumber: ""));

  @override
  void onReady() {
    checkAuth();
    // notifyEngine();fire this up only when there is a user
    super.onReady();
  }

  // late FirebaseAuth _auth;
  // final _user = Rxn<User>();
  Rxn<User> firebaseUser = Rxn<User>();

  late Stream<User> _authStateChanges;

  FirebaseAuth auth = FirebaseAuth.instance;

  void checkAuth() async {
    log(valueparser.value);

    firebaseUser = Rxn<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    // collegeList.bindStream(collegeStream());
    // log(collegeList);
  }

  void fireUserLevel(userId) async {
    _userLevel.value = await firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((doc) => UserLevel.fromDocumentSnapshot(doc));

    // xDialogs.showSnackbar(context,
    //     'Auth from ${_userLevel.value.toJson()['filledForm'].toString()}');

    valueparser.value = _userLevel.value.toJson()['value'];
    role.value = _userLevel.value.toJson()['role'];

    if (role.value == 'admin' &&
        valueparser.value != 'prime' &&
        valueparser.value != 'erudite' &&
        valueparser.value != 'noobie') {
      Get.offAll(() => AdminBaseHome());
    } else if (role.value == 'lecturer' &&
        valueparser.value != 'prime' &&
        valueparser.value != 'erudite' &&
        valueparser.value != 'noobie') {
      Get.offAll(() => LecturaHome());
    } else if (role.value == 'student') {
      if (valueparser.value == 'prime') {
        Get.off(() => PrimeLauncher());
      } else if (valueparser.value == 'erudite') {
        Get.offAll(() => const EruditeHome());
      } else if (valueparser.value == 'noobie') {
        Get.offAll(() => NoobieHome());
      } else
        Get.offAll(
          () => NoScreen(), //! Is this fair for this expression :)
        );
      // xDialogs.showSnackbar(context, 'Your Account has been synced');
    } else {
      Get.off(
        () => NoScreen(),
      );
    }

    // You stopped here userModel vs userLevel ..exe
  }

  Future _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => PureLogin());
    } else {
      fireUserLevel(user.uid);

      // Get.offAll(() => SidebarXExampleApp());
    }
  }

  Future<void> signIn(
      BuildContext context, RoleUser student, String pwd) async {
    // _userLevel.value = UserLevel('erudite');
    // await JsonStore().setItem('userLevel', _userLevel.toJson(), encrypt: true);
    String _level = userLevelGetter.value;

    //! Remove this wicked code
    //TODO

    // String xpwd = pwd.substring(0, pwd.length - 2);
    try {
      await auth.signInWithEmailAndPassword(
          // email: student.email, password: pwd);
          email: student.email,
          password: pwd);

      if (!auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);

        Get.defaultDialog(
            radius: 5.0,
            title: "Kindly Verify your email and check back",
            titlePadding: const EdgeInsets.all(20),
            titleStyle: const TextStyle(fontFamily: 'Product Sans'),
            barrierDismissible: false,
            content: LoadingAnimationWidget.hexagonDots(
              color: Colors.deepPurpleAccent,
              size: 50,
            ));
      } else {
        Get.defaultDialog(
            radius: 5.0,
            title: "Signing you in...",
            titlePadding: const EdgeInsets.all(20),
            titleStyle: const TextStyle(fontFamily: 'Product Sans'),
            barrierDismissible: false,
            content: LoadingAnimationWidget.discreteCircle(
              color: Colors.deepPurpleAccent,
              size: 50,
            ),
            contentPadding: const EdgeInsets.all(20));
      }

      fireUserLevel(auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      ExDialogs.showSnackbar(context, e.message!);
    }
  }

  Future<void> signUp(BuildContext context, String email, String pwd) async {
    String _level = userLevelGetter.value;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pwd);

      await sendEmailVerification(context);

      //     .then((creed) {
      //   creed.user!.updateDisplayName(firstName.text
      //!      .trim()); // creed returns a userCrendetial.user!.updateDisplayName(name); in the extract..

      //   String _userId = creed.user!.uid;

      //   _addUserToFirestore(_userId, _level);
      //   _initializeUserModel(_userId);
      // });
      // _userLevel.value = UserLevel(aLevel.text);
      // await JsonStore()
      //     .setItem('userLevel', _userLevel.toJson(), encrypt: true);
    } catch (e) {
      ExDialogs.showSnackbar(context, 'Oops try again');
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      auth.currentUser!.sendEmailVerification();
      ExDialogs.showSnackbar(context, 'Check your email for verification');
    } on FirebaseAuthException catch (e) {
      ExDialogs.showSnackbar(context, e.message!);
    }
  }

  Future<void> signOut() async {
    // AppLogger.d("Sign out");

    try {
      await auth.signOut();

      // navigateToHome();
    } on FirebaseAuthException catch (e) {
      // AppLogger.e(e);
      Get.snackbar("SOmething went wrong", e.toString());
    }
  }

  User? getUser() {
    firebaseUser.value = auth.currentUser;
    return firebaseUser.value;
    // _user.value = _auth.currentUser;
    // return _user.value;
  }

  bool isLogedIn() {
    return auth.currentUser != null;
  }

  // void navigateToHome() {
  //   Get.offAllNamed(HomeScreen.routeName);
  //   Get.offAll(() => LoginScreen());
  // }

  // void navigateToLogin() {
  //   Get.toNamed(LoginScreen.routeName);
  // }

  // void navigateToIntroduction() {
  //   Get.offAllNamed(AppIntroductionScreen.routeName);
  // }
}
