import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/components/privacy_policy_screen.dart';
import 'package:emart_app/views/auth_screen/components/term_and_cond_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  final _formKey = GlobalKey<FormState>();
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    storeUser();
  }

  storeUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        if (user.emailVerified) {
          controller.storeUserData(
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text);
          //   Get.to(() => const Home());
        }
      }
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool hidePass = true;
  bool hidePass2 = true;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                      isPass: false,
                    ),
                    customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                      isPass: false,
                    ),
                    customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: hidePass,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        child: Icon(
                          hidePass ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        } else if (value.length < 6) {
                          return 'Password should be atleast 6 characters';
                        }
                        return null;
                      },
                    ),
                    customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePass2 = !hidePass2;
                          });
                        },
                        child: Icon(
                          hidePass2 ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        // Check if the entered password matches the retype password
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      isPass: hidePass2,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to the Terms and Conditions screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TermsAndConditionsScreen(),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to the Privacy Policy screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PrivacyPolicyScreen(),
                                      ),
                                    );
                                  },
                              )
                            ],
                          )),
                        )
                      ],
                    ),
                    5.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false &&
                                  _formKey.currentState!.validate()) {
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    return controller.storeUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text);
                                  }).then((value) {
                                    print(value);
                                    // VxToast.show(context, msg: loggedin);
                                    // Get.offAll(const Home());
                                    controller.isloading(false);
                                    Get.to(() => LoginScreen());
                                  });
                                } catch (e) {
                                  print(e);
                                  // auth.signOut();
                                  // VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                  if (e.toString().contains(
                                      'Null check operator used on a null value')) {
                                    showCupertinoDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                        title: const Text('No Connection'),
                                        content: const Text(
                                            'Please check your internet connectivity'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyHaveAccount.text.color(fontGrey).make(),
                        login.text.color(redColor).make().onTap(() {
                          Get.back();
                        }),
                      ],
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            )
          ],
        )),
      ),
    ));
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
