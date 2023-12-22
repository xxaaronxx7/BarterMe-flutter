import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/components/forgetpass_page.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'components/gsignin_service.dart';

class LoginScreen extends StatefulWidget {
  final name;
  final email;
  final pass;
  const LoginScreen({super.key, this.name, this.email, this.pass});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    sendVerification();
    Future.delayed(Duration(seconds: 10), () {
      //  verifyEmail();
    });
  }

  sendVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      VxToast.show(context,
          msg: 'Please check the verification message in your email inbox');
      // Prompt the user to check their email for a verification link.
      print('email verified: ${user.emailVerified.toString()}');
    } else {
      // User is already verified or does not exist.

      //Get.offAll(const Home());
    }
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

  void verifyEmail() async {
    print(FirebaseAuth.instance.currentUser!.email);
    await FirebaseAuth.instance.currentUser
        ?.reload(); // <- Also add brackets here
    final user = FirebaseAuth.instance.currentUser;
    bool emailVerified = user!.emailVerified;
    print(emailVerified);
  }

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    final Size deviceSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    hint: passwordHint,
                    title: password,
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
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          // FirebaseAuth.instance.sendPasswordResetEmail(
                          //     email: 'philipguarin22@gmail.com');
                          Get.to(() => ForgetpassPage());
                        },
                        child: forgetPass.text.make())),
                5.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                          controller.isloading(true);

                          User? user = FirebaseAuth.instance.currentUser;
                          print(user);

                          if (controller.emailController.text.isEmpty ||
                              controller.passwordController.text.isEmpty) {
                            VxToast.show(context,
                                msg: 'Both Fields are required!');
                            controller.isloading(false);
                          } else {
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              print('value: $value');
                              if (value == null) {
                                if (user != null && user.emailVerified) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                  if (!user!.emailVerified) {
                                    verifyEmail();

                                    VxToast.show(context,
                                        msg:
                                            'Please verify first your email in your inbox');
                                  }
                                }
                              } else {
                                controller.isloading(false);
                                print('failed');
                                verifyEmail();
                              }
                            });
                          }
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: lightGolden,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
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
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  color: Colors.black,
                  height: 0.4,
                  width: deviceSize.width * .26,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19.0, right: 10),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(
                        fontSize: 16,
                        color: darkFontGrey,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: 0.4,
                  width: deviceSize.width * .24,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                GSignInService().signInWithGoogle();
              },
              child: Image.asset('assets/icons/goo.png'),
            ),
          )
        ],
      )),
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
