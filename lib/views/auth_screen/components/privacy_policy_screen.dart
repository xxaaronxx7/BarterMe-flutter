import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Privacy Policy".text.fontFamily(bold).white.size(22).make(),
          15.heightBox,
          Column(
            children: [
              "Aaosjdaioaoisdhaoidhasiodhasdajsdiahsduiashduiashdiasudhauisdhasdjdaiodjasiodhasiodhasidhasdioashdioahsdioashdasiodhasoidasiodhasiofhasoifshdiosdhfioashfaiofhaisofahsfasdjaodijasdioasjdoiasjdasiodjasiodjasoidjasiodjasdioasjdioasjdasiodjasiodjasiodjasiodjasidoasjdioasjdiasodjasiodjasiodjasiodjasiodjasiodjasdiojasdioasjdioasjdiasojdasiodjasiodjasiodjasoidjasidojasdiojasdioasjdioasjdoiasdjasiodjasiodjasiodjasiodjasdiojasdioasjdioasjdioasjdasiodjaisodjasiodjasodijasdioasjdioasjdioasjdaoisdjiaiosdj"
                  .text
                  .size(16)
                  .make(),
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .shadowSm
              .make(),
        ],
      )),
    ));
  }
}
