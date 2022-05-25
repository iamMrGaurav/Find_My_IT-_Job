import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/custometextfield.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass({Key? key}) : super(key: key);

  final LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPurple,
        elevation: 0,
        title: Text(
          "Create New Password",
          style: GoogleFonts.lato(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
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
              right: 35,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    // spreadRadius: 2,
                    color: Colors.grey,
                    offset: Offset(2, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: "Create new password",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.forgotPassword,
                    labelText: "New Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.confirmPassword,
                    labelText: "Confirm New Password",
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.6,
              left: MediaQuery.of(context).size.width * 0.23,
              right: 35,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  primary: kPurple,
                ),
                onPressed: () {
                  print(controller.confirmPassword.text);
                  if (controller.forgotPassword.text.isEmpty ||
                      controller.confirmPassword.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please fill all the fields",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else if (controller.forgotPassword.text !=
                      controller.confirmPassword.text) {
                    Fluttertoast.showToast(
                        msg: "Password does not match",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    controller.changePassword();
                    Get.to(LoginScreen());
                  }
                },
                child: const Text("Change"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var controllPoint = Offset(size.width / 5, size.height / 2);

    var endPoint = Offset(size.width, size.height);
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
