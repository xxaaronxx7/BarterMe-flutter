import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/colors.dart';
import '../../../consts/strings.dart';
import '../../../widgets_common/applogo_widget.dart';
import '../../../widgets_common/custom_textfield.dart';

class ForgetpassPage extends StatefulWidget {
  const ForgetpassPage({super.key});

  @override
  State<ForgetpassPage> createState() => _ForgetpassPageState();
}

class _ForgetpassPageState extends State<ForgetpassPage> {
  var emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final Size deviceSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    return bgWidget(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: deviceSize.height * .1,
                ),
                applogoWidget(),
                SizedBox(
                  height: 10,
                ),
                Text('Forget Password',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: deviceSize.height * .05,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    height: deviceSize.height * .4,
                    width: deviceSize.width * .8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: deviceSize.height * .07, left: 40, right: 40),
                      child: Column(
                        children: [
                          customTextField(
                            hint: emailHint,
                            title: email,
                            isPass: false,
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill the field';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: deviceSize.height * .1,
                          ),
                          isloading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              : InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isloading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              //   actionCodeSettings: ,
                                              email:
                                                  emailController.text.trim());
                                      Future.delayed(Duration(seconds: 1), () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    'Password reset link sent! Check your email'),
                                                actions: [
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        Get.to(() =>
                                                            LoginScreen());
                                                      },
                                                      child: Text('OK'))
                                                ],
                                              );
                                            });
                                      });
                                    }
                                  },
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text('Log in',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    ));
  }
}
