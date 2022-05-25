import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/controller/setup_profile_controller.dart';
import 'package:fmij/main.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class PageFour extends StatefulWidget {
  final PageController pageController;
  final setupProfile obj;
  final String text;
  const PageFour(
      {Key? key,
      required this.pageController,
      required this.obj,
      required this.text})
      : super(key: key);

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        widget.obj.image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: "No Image Selected",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  upload(
    File imageFile,
  ) async {
    var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));

    var length = await imageFile.length();

    var uri = Uri.parse(
        "$api/${widget.text}/${widget.text == "company/update" ? "?token=${LoginController.authenticateToken}" : ""}");

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file_field', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['company_name'] = widget.obj.companyName!;
    request.fields['email'] = widget.obj.email!;
    request.fields['website'] = widget.obj.website!;
    request.fields['contact_no'] = widget.obj.contact!;
    request.fields['district'] = widget.obj.address!;

    if (widget.text == "stats/insert") {
      request.fields['user_id'] = LoginController.userID.toString();
    } else {
      request.fields['company_id'] = MainScreen.companyId.toString();
    }
    request.fields['company_desc'] = widget.obj.companyDesc!;

    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Profile Setup Completely",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      if (widget.text == "stats/insert") {
        Get.to(LoginScreen());
      } else {
        Get.back();
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    response.stream.transform(utf8.decoder).listen((value) {});
  }

  final CompanyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async => await getImage(),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: kPurple,
            child: CircleAvatar(
              backgroundImage: widget.obj.image != null
                  ? FileImage(widget.obj.image!)
                  : null,
              backgroundColor: Colors.white,
              radius: 50,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton(
          onPressed: () async {
            await getImage();
          },
          child: Text(
            "Upload Photo",
            style: GoogleFonts.carterOne(
              fontSize: 20,
              color: kPurple,
            ),
          ),
        ),
        const SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kTheme,
                ),
                onPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                  );
                },
                child: Text(
                  "Back",
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 68, 52, 52)),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPurple,
                ),
                onPressed: () async {
                  await upload(widget.obj.image!);
                },
                child: Text(
                  "Upload",
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
