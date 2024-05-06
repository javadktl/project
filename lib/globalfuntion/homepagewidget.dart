



import 'package:flutter/material.dart';
import 'package:work_force/globalfuntion/variables.dart';

void _privacypolicybox(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: const Color.fromARGB(230, 136, 63, 3)),
                ),
                Text(
                  'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text(
                  'Personal Information Collection',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(
                  height:smallestHeight * 0.1,
                ),
                Text(
                    'We collect certain personal information from you when you use our service, such as your name, contact details, and address. Additionally, we gather data about your device and how you interact with our service, including your IP address, browser type, and the pages you visit. This information is essential for us to provide and improve our service. For instance, we use it to maintain and monitor the performance of our service, manage your account, and offer personalized support. Moreover, we may use your data to communicate with you about updates, special offers, and other relevant information.',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text('Sharing of Your Personal Data',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text(
                    'We may share your personal data with various parties for different purposes. This includes service providers who help us analyze and enhance our service, affiliates and business partners with whom we collaborate to offer products or services, and other users with whom you interact publicly or with your consent. We ensure that these parties adhere to similar privacy standards to protect your information.',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(
                  height:smallestHeight * 0.1,
                ),
                Text('Retention and Deletion of Personal Data',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text(
                  'We retain your personal data only for as long as necessary to fulfill the purposes outlined in our privacy policy. If you wish to delete or update your information, you can do so through your account settings or by contacting us directly. However, please note that certain data may need to be retained to comply with legal obligations or resolve disputes.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text('Security and Childrens Privacy',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                SizedBox(
                  height: smallestHeight * 0.1,
                ),
                Text(
                    'While we take measures to safeguard your personal data, such as encryption and regular security audits, it is important to acknowledge that no method of data transmission over the internet is entirely secure. Therefore, we cannot guarantee absolute security. Additionally, our service is not intended for children under the age of 13, and we do not knowingly collect personal information from them without parental consent.',
                    style: TextStyle(fontWeight: FontWeight.w500))
              ],
            ))),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: smallestHeight * 0.4,
                      width: smallestWidth * 2.8,


                      // height: smallestHeight * 0.4,
                      // width: smallestWidth * 2.8,

                      
                      decoration: BoxDecoration(
                          color: Color.fromARGB(230, 136, 63, 3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Ok',
                          // style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }







  