import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/auth/pureLogin/pureSignup.dart';

import '../../typography/curtina.dart';
import '../../typography/forma.dart';
import '../../typography/typo.dart';
import '../../wizzy/button.dart';
import '../../utils/dialogs/xDialogs.dart';
import '../auth_controller.dart';

class PureLogin extends StatefulWidget {
  PureLogin({super.key});

  @override
  State<PureLogin> createState() => _PureLoginState();
}

class _PureLoginState extends State<PureLogin> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  bool obscurePassword = true;
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordController.text = '08125107448';
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
        body: Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width * .7,
        ),
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
                    'Welcome back',
                    // textAlign: TextAlign.left,
                    style: AppTypography.header1(context)
                        .copyWith(letterSpacing: 0, fontSize: 38),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Get back in! your students await you',
                      // textAlign: TextAlign.left,
                      style: AppTypography.header2(context)
                      // .copyWith(letterSpacing: 0, fontSize: 32),
                      ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: roundContainer,
                    child: TextFormField(
                      decoration: xFormInput.copyWith(
                          hintText: 'Put in your email',
                          suffixIcon: Icon(IconlyBold.message)),
                      controller: emailController,
                      // obscureText: true,
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
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: roundContainer.copyWith(
                        color: Theme.of(context).cardColor),
                    child: TextFormField(
                      style: AppTypography.header4(context),
                      decoration: xFormInput.copyWith(
                          hintText: 'Put in your password',
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              child: obscurePassword
                                  ? Icon(IconlyBold.hide)
                                  : Icon(IconlyBold.unlock))),
                      controller: passwordController,
                      // obscureText: obscurePassword,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Enter your password to sign in';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            ExDialogs.showSnackbar(context, 'Please wait');
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: AppTypography.header3(context),
                          ),
                        ),
                        WButton(
                            onPressed: () async {
                              _submitForm();
                            },
                            label: 'Sign in')
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
                                text: 'Don\'t have an account ',
                                style: AppTypography.header5(context)
                                    .copyWith(color: Colors.grey)),
                            TextSpan(
                              text: 'Create one !',
                              style: AppTypography.header5(context),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(() => PureSignIn());
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
