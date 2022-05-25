import 'package:flutter/material.dart';
import 'package:fmij/controller/setup_profile_controller.dart';
import 'package:fmij/views/pages/setup_pageThree.dart';
import 'package:fmij/views/pages/setup_pageTwo.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/constants.dart';
import 'pages/setup_pageFour.dart';
import 'pages/setup_pageOne.dart';

class FirstSignUp extends StatelessWidget {
  final String? text;
  FirstSignUp({Key? key, required this.text}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  setupProfile obj = setupProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ClipPath(
        clipper: Waves(),
        child: Container(
          color: kPurple,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Setup Profile",
                    style: GoogleFonts.carterOne(
                        fontSize: 30, color: Colors.white),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          pageSnapping: false,
                          controller: pageController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageOne(
                                pageController: pageController,
                                obj: obj,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageTwo(
                                obj: obj,
                                pageController: pageController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageThree(
                                obj: obj,
                                pageController: pageController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageFour(
                                text: text!,
                                obj: obj,
                                pageController: pageController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Waves extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 10,
      size.width + 30,
      size.height,
    );

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
