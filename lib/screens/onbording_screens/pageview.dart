
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_force/globalfuntion/variables.dart';
import 'package:work_force/screens/onbording_screens/onboarding_screen.dart';
import 'package:work_force/bottomnav/bottomnav.dart';
class Scrool extends StatefulWidget {
  const Scrool({super.key});

  @override
  State<Scrool> createState() => _ScroolState();
}

PageController controller = PageController();
int currentPage = 0;

class _ScroolState extends State<Scrool> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  void setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    mediaqQueryHightAndWidth(context);
    return _isFirstTime
        ? Scaffold(
            body: Stack(
              children: [
                PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: controller,
                  children: [
                    OnBoardingPage(
                        imagePath: 'assets/image/onboardpit1.png',
                        description:
                            'We ensure your information is encrypted, protected from unauthorized access, and stored securely at all times.',
                        title: 'Your data is safe with us'),
                    OnBoardingPage(
                        imagePath: 'assets/image/onboardpit1.png',
                        description:
                            'Effortlessly access your secure data anytime, anywhere, with our user-friendly interface.',
                        title: 'Your Information is at Your Fingertips'),
                    OnBoardingPage(
                        imagePath: 'assets/image/onboard3.png',
                        description:
                            'Maximize your productivity by easily scheduling tasks, managing deadlines, and organizing your workflow within our user-friendly platform.',
                        title: 'Stay organized with easy scheduling'),
                  ],
                ),
                Positioned(
                  top: 670,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: smallestWidth * 0.6),
                      TextButton(
                          onPressed: () {
                            setFirstTime(); // Mark onboarding as completed
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottomNav()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(fontSize: 17),
                          )),
                      SizedBox(width: smallestWidth * 1.5),
                      Wrap(
                        spacing: 20,
                        children: List.generate(
                          3,
                          (index) => CircleAvatar(
                            backgroundColor: index == currentPage
                                ? Color.fromARGB(255, 21, 4, 145)
                                : Colors.white,
                            radius: 7,
                          ),
                        ),
                      ),
                      SizedBox(width: smallestWidth * 1.5),
                      TextButton(
                        onPressed: currentPage == 2
                            ? () {
                                setFirstTime(); // Mark onboarding as completed
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => BottomNav()));
                              }
                            : () {
                                controller.animateToPage(
                                  (controller.page ?? 0).toInt() + 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.decelerate,
                                );
                              },
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : BottomNav(); // If not the first time, navigate to the main screen directly
  }
}










// import 'package:flutter/material.dart';
// import 'package:work_force/globalfuntion/variables.dart';
// import 'package:work_force/screens/onbording_screens/onboarding_screen.dart';
// import 'package:work_force/bottomnav/bottomnav.dart';



// class Scrool extends StatefulWidget {
//   const Scrool({super.key});

//   @override
//   State<Scrool> createState() => _ScroolState();
// }

// PageController controller = PageController();
// int currentPage = 0;

// class _ScroolState extends State<Scrool> {
//   @override
//   void initState() {
    
//     super.initState();
//     //serviceBox.put('services', ['Cleaning','Plumbing','Electritians']);
//   }
//   @override
//   Widget build(BuildContext context) {
     
//      mediaqQueryHightAndWidth(context);
//     return Scaffold(
//         body: Stack(
//       children: [
//         PageView(
//           //  physics: const NeverScrollableScrollPhysics(),
//           onPageChanged: (value) {
//             setState(() {
//               currentPage = value;
//             });
//           },
//           controller: controller,
//           children: [
//             OnBoardingPage(
//                 imagePath: 'assets/image/onboardpit1.png',
//                 description:
//                     'We ensure your information is encrypted, protected from unauthorized access, and stored securely at all times.',
//                 title: 'Your data is safe with us'),
//             OnBoardingPage(
//                 imagePath: 'assets/image/onboardpit1.png',
//                 description:
//                     'Effortlessly access your secure data anytime, anywhere, with our user-friendly interface.',
//                 title: 'Your Information is at Your Fingertips'),
//             OnBoardingPage(
//                 imagePath: 'assets/image/onboard3.png',
//                 description:
//                     'Maximize your productivity by easily scheduling tasks, managing deadlines, and organizing your workflow within our user-friendly platform.',
//                 title: 'Stay organized with easy scheduling'),
//           ],
//         ),
//         Positioned(
//           top: 670,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: smallestWidth * 0.6),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => BottomNav()));
//                   },
//                   child: Text(
//                     'Skip',
//                     style: TextStyle(fontSize: 17),
//                   )),
//               SizedBox(width: smallestWidth * 1.5),
//               Wrap(
//                 spacing: 20,
//                 children: List.generate(
//                   3,
//                   (index) => CircleAvatar(
//                     backgroundColor: index == currentPage
//                         ? Color.fromARGB(255, 21, 4, 145)
//                         : Colors.white,
//                     radius: 7,
//                   ),
//                 ),
//               ),
//               SizedBox(width: smallestWidth * 1.5),
//               TextButton(
//                 onPressed: currentPage == 2
//                     ? () => Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => BottomNav()))
//                     : () {
//                         controller.animateToPage(
//                           (controller.page ?? 0).toInt() + 1,
//                           duration: const Duration(seconds: 1),
//                           curve: Curves.decelerate,
//                         );
//                       },
//                 child: Text(
//                   'Next',
//                   style: TextStyle(fontSize: 17),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }
