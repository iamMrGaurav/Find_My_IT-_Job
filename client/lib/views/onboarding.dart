import 'package:flutter/material.dart';
import 'package:flutter_onboarding/onboarding_model.dart';
import 'package:flutter_onboarding/flutter_onboarding.dart';
import 'package:fmij/views/login_screen.dart';
import '../components/constants.dart';

class Onboard extends StatelessWidget {
  Onboard({Key? key}) : super(key: key);

  final pages = [
    IntroModel(
      imagePath: "assets/images/onBoard.png",
      title: "It's Easy to search jobs.",
      titleColor: Colors.purple,
      description:
          "Find the best IT companies. Everyone \nhas got there's. Have you apply yet? ",
      descriptionColor: Colors.purple,
    ),
    IntroModel(
      imagePath: "assets/images/applicant.jpg",
      title: "Pool of talented applicants.",
      titleColor: Colors.purple,
      description: "Hire the best applicants out there.",
      descriptionColor: Colors.purple,
    ),
    IntroModel(
      imagePath: "assets/images/men.png",
      title: "Vert easy to navigate.",
      titleColor: Colors.purple,
      description:
          "With it's interactive UI, you can easily get familar with it's UI",
      descriptionColor: Colors.purple,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterOnBoarding(
        pages: pages,
        backgroundColor: Colors.white,
        nextButtonColor: kPurple,
        skipButtonTextStyle: const TextStyle(color: Color(0xff8f26e0)),
        inactiveIndicatorColor: const Color(0xff8f26e0),
        activeIndicatorColor: const Color(0xff790faa),
        onGetStartedRoute: MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
    );
  }
}
// const Color(0xff0000b3)