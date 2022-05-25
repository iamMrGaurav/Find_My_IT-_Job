import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/normaltextfield.dart';
import '../components/custometextfield.dart';
import '../components/customdivider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  signUp(username, role, email, password) async {
    var url = "$api/register";
    var response = await http.post(Uri.parse(url), body: {
      "email_address": email,
      "user_name": username,
      "password": password,
      "role": role,
      "verification_status": "false"
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  String? dropdownvalue;

  var items = ['Company', 'Seeker'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Hero(
              tag: 'logo',
              child: Image.asset(
                "assets/images/logo.png",
                height: 100,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: "Sign in to your Account ",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: NormalTextfield(
                    controller: username,
                    labelText: "User Name",
                    keboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: kPurple,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade200,
                  ),
                  child: DropdownButton(
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Role",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    items: items.map(
                      (String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropdownvalue = newValue;
                          print(dropdownvalue);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: NormalTextfield(
                controller: email,
                labelText: "Email Address",
                keboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email,
                  color: kPurple,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTextField(
                controller: password,
                labelText: "Enter a Password",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTextField(
                controller: repassword,
                labelText: "Re-Enter Password",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 47,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPurple,
                ),
                onPressed: () {
                  setState(() {
                    if (username.text == '' ||
                        password.text == '' ||
                        email.text == '' ||
                        repassword.text == '') {
                      Fluttertoast.showToast(
                          msg: "Fill the empty fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      final bool isValid = EmailValidator.validate(email.text);

                      if (isValid) {
                        if (password.text.length > 6) {
                          if (password.text == repassword.text) {
                            signUp(
                                username.text,
                                dropdownvalue == "Company" ? "1" : "2",
                                email.text,
                                password.text);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password does not match",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Password Must be greater than 6",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Invalid Email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  });

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const FirstSignUp(),
                  //   ),
                  // );
                },
                child: Text(
                  "Sign-Up",
                  style: GoogleFonts.roboto(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomerDivider(
              text: "Already a User?",
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text(
                      "Sign-In",
                      style: TextStyle(
                        color: Color(0xff8f26e0),
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
