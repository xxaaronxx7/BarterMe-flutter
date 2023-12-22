import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Terms and Conditions".text.fontFamily(bold).white.size(22).make(),
            15.heightBox,
            Column(
              children: [
                Text(
                  '''Introduction
      
      1.1 Welcome to BarterMe. By using the App, you agree to comply with and be bound by these Terms and Conditions.
      
      User Agreement
      
      2.1 Users are solely responsible for the accuracy of the information provided on the App.
      
      Barter Transactions
      
      3.1 The App facilitates non-monetary transactions between users for the exchange of goods or services ("Barter Transactions").
      
      3.2 Users are responsible for ensuring the legality and condition of items involved in Barter Transactions.
      
      User Responsibilities
      
      4.1 Users agree not to engage in any unlawful, fraudulent, or harmful activities on the App.
      
      4.2 Users must respect the intellectual property rights of others when listing items for barter.
      
      Content Policy
      
      5.1 Users are prohibited from posting offensive, misleading, or inappropriate content on the App.
      
      5.2 The App reserves the right to remove any content that violates these Terms and Conditions.
      
      Privacy Policy
      
      6.1 The App collects and processes user data in accordance with the Privacy Policy, available on the App.
      
      6.2 Users consent to the collection and use of their data as outlined in the Privacy Policy.
      
      Security Measures
      
      7.1 Users are responsible for maintaining the security of their accounts and must not share login credentials.
      
      7.2 The App employs security measures, but users acknowledge the inherent risks of online transactions.
      
      Termination of Account
      
      8.1 The App reserves the right to suspend or terminate user accounts for violations of these Terms and Conditions.
      
      8.2 Users may terminate their accounts at any time by following the provided procedures.
      
      Limitation of Liability
      
      9.1 The App is not responsible for the quality, safety, or legality of items exchanged in Barter Transactions.
      
      9.2 The App shall not be liable for any indirect, incidental, or consequential damages.
      
      Changes to Terms
      
      10.1 The App reserves the right to modify these Terms and Conditions at any time, with notice to users.
      
      10.2 Continued use of the App after changes constitutes acceptance of the modified Terms.
      
      Governing Law
      
      11.1 These Terms and Conditions are governed by the laws.
      
      11.2 Any disputes arising out of or in connection with these Terms shall be resolved through arbitration.
      
      By using the App, you agree to these Terms and 
      Conditions. If you do not agree, please refrain from using the App.''',
                  style: TextStyle(fontSize: 16),
                ),
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
      ),
    ));
  }
}
