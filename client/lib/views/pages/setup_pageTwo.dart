import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/components/custometextfield.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/setup_profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTwo extends StatefulWidget {
  final PageController pageController;
  final setupProfile obj;
  const PageTwo({Key? key, required this.pageController, required this.obj})
      : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final CompanyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomeJobPostField(
          controller: controller.website,
          input: TextInputType.text,
          labelText: "Website",
          suffixIcon: const Icon(
            Icons.web,
            color: kPurple,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomeJobPostField(
          controller: controller.contactNo,
          input: TextInputType.text,
          labelText: "Contact No",
          suffixIcon: const Icon(
            Icons.perm_contact_cal,
            color: kPurple,
          ),
        ),
        const SizedBox(
          height: 40,
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
                  setState(
                    () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceIn,
                      );
                    },
                  );
                },
                child: Text(
                  "Back",
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
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
                onPressed: () {
                  widget.obj.website = controller.website.text;
                  widget.obj.contact = controller.contactNo.text;

                  // if (pageController.hasClients) {
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 230),
                    curve: Curves.bounceIn,
                  );
                  // }
                },
                child: Text(
                  "Next",
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
