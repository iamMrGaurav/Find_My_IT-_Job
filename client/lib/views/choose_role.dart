import 'dart:convert';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fmij/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

var email = LoginController.google_email;

updateRole(role, email) async {
  var url = "$api/googlelogin/chooserole";
  var response = await http.post(Uri.parse(url), body: {
    "email_address": email,
    "role": role,
  });

  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Get.offAll(LoginScreen());
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

class _RoleScreenState extends State<RoleScreen> {
  String? dropdownvalue;
  var items = ['Company', 'Seeker'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              top: MediaQuery.of(context).size.height * 0.3,
              left: 30,
              right: 35,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.39,
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
                      text: "Choose Your Role",
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
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffF0EEFA),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        underline: const SizedBox(),
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
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.58,
              left: MediaQuery.of(context).size.width * 0.25,
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
                  setState(
                    () {
                      updateRole(dropdownvalue == "Company" ? "1" : "2", email);
                    },
                  );
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
