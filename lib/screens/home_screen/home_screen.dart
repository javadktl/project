import 'package:flutter/material.dart';
import 'package:work_force/db/functions/work_functions/work_function.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/settings_/settings_screen.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int revenue = 0;
int completed = 0;
int pending = 0;
int estimatedRevenue = 0;
int totalstaff = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initialiseVariable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 198, 144),
        appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          foregroundColor: Colors.white,
          backgroundColor: primaryGray,
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
          title: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 10, left: 10, top: 33, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: smallestWidth * 4.3,
                        height: smallestHeight * 1.5,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 2.0,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                          color: Color.fromARGB(255, 250, 246, 246),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width:smallestHeight * 0.4,
                              height: smallestHeight * 0.5,
                              child: Image.asset(
                                'assets/image/totalRevenue.png',
                              ),
                            ),
                            SizedBox(
                              height: smallestHeight * 0.1,
                            ),
                            Text(
                              'Total Revenue',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '₹$revenue',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[700],
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 24,),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: smallestWidth * 4.3,
                        height: smallestHeight * 1.5,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 2.0,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                          color: Color.fromARGB(255, 250, 246, 246),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: smallestHeight * 0.4,
                              height: smallestHeight * 0.5,
                              child: Image.asset(
                                'assets/image/monthlyRevenue.png',
                              ),
                            ),
                            SizedBox(
                              height: smallestHeight *0.1,
                            ),
                            Text(
                              'Estimated Profit',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '₹$estimatedRevenue',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[700],
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: smallestHeight * 5.7,
            decoration: BoxDecoration(
                color: Color.fromARGB(165, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: smallestWidth * 4.3,
                    height: smallestHeight * 1.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          spreadRadius: 2.0,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                      color: Color.fromARGB(255, 250, 246, 246),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: smallestWidth * 1.1,
                          height: smallestHeight * 0.5,
                          child: Image.asset(
                            'assets/image/completedwork.png',
                          ),
                        ),
                        SizedBox(
                          height: smallestHeight * 0.1,
                        ),
                        Text(
                          'Completed Work',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$completed',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: smallestWidth * 4.3,
                    height: smallestHeight * 1.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          spreadRadius: 2.0,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                      color: Color.fromARGB(255, 250, 246, 246),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: smallestWidth * 1.1,
                          height: smallestHeight * 0.5,
                          child: Image.asset(
                            'assets/image/pendingwork.png',
                          ),
                        ),
                        SizedBox(
                          height:smallestHeight * 0.1,
                        ),
                        Text(
                          'Pending Work',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$pending',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: smallestHeight * 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: smallestWidth * 4.3,
                    height: smallestHeight * 1.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          spreadRadius: 2.0,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                      color: Color.fromARGB(255, 250, 246, 246),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: smallestWidth * 1.1,
                          height: smallestHeight * 0.5,
                          child: Image.asset(
                            'assets/image/totalstaff.png',
                          ),
                        ),
                        SizedBox(
                          height: smallestHeight * 0.1
                        ),
                        Text(
                          'Total Staff',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$totalstaff',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SetingsScreen()));},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: smallestWidth * 4.3,
                    height: smallestHeight * 1.5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            spreadRadius: 2.0,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                        color: Color.fromARGB(255, 250, 246, 246),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: smallestWidth * 1.1,
                          height: smallestHeight * 0.5,
                            child: Image.asset(
                              'assets/image/settings.png',
                            ),
                          ),
                          SizedBox(
                            height: smallestHeight * 0.1
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0),
                        child: GestureDetector(
                          onTap: () => _privacypolicybox(),
                          child: Container(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            height: smallestHeight * 0.4,
                            width: smallestHeight * 1.2,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2.0,
                                    offset: Offset(2, 4), // Shadow position
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Icon(
                                Icons.privacy_tip,
                                size: 17,
                              ),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(fontSize: 10),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0),
                        child: GestureDetector(
                          onTap: () => _termsandconditionbox(),
                          child: Container(
                            padding: EdgeInsets.only(right: 5, left: 5),
                             height: smallestHeight * 0.4,
                            width: smallestHeight * 1.6,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2.0,
                                    offset: Offset(2, 4), // Shadow position
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Icon(
                                Icons.task_outlined,
                                size: 17,
                              ),
                              Text(
                                'Terms and condition',
                                style: TextStyle(fontSize: 10),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0),
                        child: GestureDetector(
                          onTap: () => _contactusbox(),
                          child: Container(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            height: smallestHeight * 0.4,
                            width: smallestHeight * 1.1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2.0,
                                    offset: Offset(2, 4), // Shadow position
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Icon(
                                Icons.wifi_tethering,
                                size: 17,
                              ),
                              Text(
                                'Contact Us',
                                style: TextStyle(fontSize: 10),
                              )
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0),
                        child: GestureDetector(
                          onTap: () {
                            _aboutusbox();
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 5, left: 5),
                             height: smallestHeight * 0.4,
                            width: smallestHeight * 1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2.0,
                                    offset: Offset(2, 4), // Shadow position
                                  ),
                                ],
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Icon(
                                Icons.info_outline,
                                size: 17,
                              ),
                              Text(
                                'About Us',
                                style: TextStyle(fontSize: 10),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text(
                'Version:1.0.0',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )
            ]),
          )
        ]));
  } //-------------------------------------






  

  void _privacypolicybox() {
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

  void _termsandconditionbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Text('Terms and Conditions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: const Color.fromARGB(230, 136, 63, 3))),
                  SizedBox(
                    height: smallestHeight * 0.1,
                  ),
                  Text('Last updated: April 30, 2024'),
                  SizedBox(
                    height:smallestHeight * 0.1,
                  ),
                  Text(
                      'Please carefully review these terms and conditions before utilizing our service. These terms govern your usage of our application, WorkForce, and constitute the entire agreement between you and WorkForce. By accessing or using our service, you agree to comply with these terms. If you do not agree with any part of these terms, please refrain from accessing the service. You confirm that you are over 18 years of age; individuals under 18 are not permitted to use the service. Your use of the service is also subject to our privacy policy, which outlines our data handling practices and privacy protections. The service may contain links to third-party websites or services not owned or managed by WorkForce, and we hold no responsibility for their content or practices. We retain the right to terminate or suspend your access to the service without prior notice if you violate these terms. Our liability is limited to the amount paid by you for the service or 100, whichever is greater, and we disclaim any responsibility for indirect or consequential damages. The service is provided "as is" and "as available," and we make no warranties regarding its reliability, performance, or suitability for your needs. These terms are governed by the laws of Kerala, India, and any disputes shall be initially resolved through informal negotiation. We reserve the right to modify these terms at our discretion, with notice provided for material changes. Your continued use of the service constitutes acceptance of these revisions. If you have any questions or concerns about these terms, please contact us at freeevir@gmail.com.',
                      style: TextStyle(fontWeight: FontWeight.w500))
                ],
              )),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: smallestHeight * 0.4,
                      width: smallestWidth * 2.8,

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

  void _contactusbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Contact Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Color.fromARGB(255, 167, 77, 3))),
                    Text('''ByteForge Technologies. 
Kozhikode-Trissur Road,
Nh junction, 
Changuvetty,
Kottakkal,
Kerala 676503'''),
                    Text(
                      'freeevir@gmail.com',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(5),
                       height: smallestHeight * 0.4,
                      width: smallestWidth * 2.8,

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

  

  _aboutusbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('About Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Color.fromARGB(255, 167, 77, 3))),
                    SizedBox(
                      height: smallestHeight * 0.1,
                    ),
                    Text('About WorkForce',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                    SizedBox(
                      height:smallestHeight * 0.1,
                    ),
                    Text(
                        'WorkForce is revolutionizing the way businesses manage their staff, making it easier than ever to streamline operations, enhance productivity, and foster a more engaged and satisfied workforce. Our app is designed with the modern business environment in mind, offering a comprehensive suite of tools that cater to the needs of both employers and employees.',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      height:smallestHeight * 0.1,
                    ),
                    Text('Why WorkForce?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                    SizedBox(
                      height: smallestHeight * 0.1,
                    ),
                    Text(
                        '''Efficiency and Transparency: WorkForce provides a centralized platform where all staff-related information is easily accessible, fostering transparency and improving decision-making processes.
Employee Engagement: We understand the importance of keeping employees informed and involved. Our app includes features like a news feed, CEO and Executive updates, and opportunities for employees to share their ideas, ensuring they feel valued and part of the company's success.
Continuous Learning and Development: WorkForce encourages a culture of continuous learning and development. We offer a platform for company workshops, webinars, and conferences, enabling employees to upskill and stay ahead in their careers.
Recognition and Reward: Recognizing and rewarding employees is key to boosting morale and productivity. WorkForce makes it easy to celebrate work anniversaries, promotions, and exceptional work, ensuring that every employee feels valued and appreciated.''',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: smallestHeight * 0.1,
                    ),
                    Text('Our Mission',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                    SizedBox(
                      height: smallestHeight * 0.1,
                    ),
                    Text(
                        'At WorkForce, our mission is to empower businesses and their employees to thrive in the digital age. We believe in creating a work environment where everyone feels recognized, engaged, and motivated to contribute their best. By leveraging technology, we aim to make staff management more efficient, transparent, and enjoyable for everyone involved.',
                        style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: smallestHeight * 0.4,
                      width: smallestWidth * 2.8,
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
void initialiseVariable() async {
    revenue = await getAllRevenue();
    completed = await getALlWork();
    pending = await getALlWork(false);
    estimatedRevenue = await getEstimatedRevenue();
    setState(() {
      revenue;
      completed;
      pending;
      estimatedRevenue;
    });
  }

}
