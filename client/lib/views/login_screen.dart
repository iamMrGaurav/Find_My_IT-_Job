import "package:flutter/material.dart";
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/views/signup_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fmij/components/constants.dart';
import '../components/normaltextfield.dart';
import '../components/custometextfield.dart';
import '../components/customdivider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 100,
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Sign in to your Account ",
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
                NormalTextfield(
                  controller: controller.email,
                  keboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: kPurple,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: controller.password,
                  labelText: "Password",
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: klightpurple,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      controller.forgotPass();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 400,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPurple,
                    ),
                    onPressed: () {
                      if (controller.email.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Email is required",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (!EmailValidator.validate(
                          controller.email.text)) {
                        Fluttertoast.showToast(
                            msg: "Email is not valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (controller.password.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Password is required",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        controller.login();
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style:
                          GoogleFonts.roboto(fontSize: 18, letterSpacing: 1.1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomerDivider(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await controller.googleLogin();

                    controller.googleSign();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 28, right: 30),
                    height: 50,
                    margin: const EdgeInsets.only(left: 10, right: 13),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            "Or,   Login with Google",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("./assets/images/google_icon.png"),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "New User?",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          "CREATE AN ACCOUNT ?",
                          style: TextStyle(color: Color(0xff8f26e0)),
                        ),
                        onPressed: () {
                          Get.to(SignUp());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
