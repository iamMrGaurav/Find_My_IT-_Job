import "package:flutter/material.dart";
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [kPurple, klightpurple],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 30,
                right: 30,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/email.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Verification Code",
                      style: TextStyle(
                        color: kPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "We have sent you an OTP to verify your email address.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: TextField(
                        autofocus: true,
                        maxLength: 5,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          letterSpacing: 15,
                        ),
                        // focusNode: myFocusNode,
                        decoration: const InputDecoration(
                          counter: Offstage(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kPurple,
                              width: 2,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.otp = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.verifyOtp(controller.otp);
                          },
                          style: ElevatedButton.styleFrom(primary: kPurple),
                          child: const Text(
                            "Verify",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(0, size.height); //starting point

    var controllPoint = Offset(size.width / 5, size.height / 2);
    // var controllPoint =
    //     Offset(size.width / 2, size.height); // point from where the curve start
    var endPoint =
        Offset(size.width, size.height); // point where the curve ends
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, controllPoint.dx, controllPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
