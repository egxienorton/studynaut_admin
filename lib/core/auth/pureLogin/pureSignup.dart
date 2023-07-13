import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/auth/auth_controller.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/core/utils/dialogs/xDialogs.dart';

import '../../typography/curtina.dart';
import '../../typography/forma.dart';
import '../../wizzy/button.dart';
import 'pure_Login.dart';

class PureSignIn extends StatefulWidget {
  PureSignIn({super.key});

  @override
  State<PureSignIn> createState() => _PureSignInState();
}

class _PureSignInState extends State<PureSignIn> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      authController.roleUser.value.email = emailController.text;
      await authController.signIn(
          context, authController.roleUser.value, passwordController.text);
      // _formKey.currentState!.save();
    } else {
      // Form is invalid, handle the invalid state
      ExDialogs.showSnackbar(context, 'Fill out the form correctly.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: NetworkImage(
          //             "https://cdn.pixabay.com/photo/2016/06/01/06/26/open-book-1428428_1280.jpg"))),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    'Sign Up',
                    // textAlign: TextAlign.left,
                    style: AppTypography.header1(context)
                        .copyWith(letterSpacing: 0, fontSize: 38),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Fill out the info below to get started',
                      // textAlign: TextAlign.left,
                      style: AppTypography.header2(context)
                      // .copyWith(letterSpacing: 0, fontSize: 32),
                      ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: roundContainer,
                    child: TextFormField(
                      decoration: xFormInput.copyWith(
                          hintText: 'Put in your email',
                          suffixIcon: Icon(IconlyBold.message)),
                      controller: emailController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fill in your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: roundContainer.copyWith(
                        color: Theme.of(context).cardColor),
                    child: TextFormField(
                      decoration: xFormInput.copyWith(
                          hintText: 'Put in your password',
                          suffixIcon: Icon(IconlyBold.hide)),
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password ';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: roundContainer.copyWith(
                        color: Theme.of(context).cardColor),
                    child: TextFormField(
                      decoration: xFormInput.copyWith(
                          hintText: 'Confirm password',
                          suffixIcon: Icon(IconlyBold.hide)),
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can\'t be empty ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     ExDialogs.showSnackbar(context, 'Please wait');
                        //   },
                        //   child: Text(
                        //     'Forgot Password ?',
                        //     style: AppTypography.header3(context),
                        //   ),
                        // ),
                        WButton(
                            onPressed: () async {
                              _submitForm();
                            },
                            label: 'Sign up')
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: roundContainer.copyWith(
                            color: Theme.of(context).primaryColorDark),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: ,
                          children: [
                            SvgIcon(
                                icon: SvgIconData('assets/icons/google.svg')),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign in  with Google',
                              style: AppTypography.header4(context),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Already have an account ',
                                style: AppTypography.header5(context)
                                    .copyWith(color: Colors.grey)),
                            TextSpan(
                              text: 'Sign In',
                              style: AppTypography.header5(context),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(() => PureLogin());
                                },
                            ),
                          ])),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
