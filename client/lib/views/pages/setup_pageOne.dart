import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/components/custometextfield.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/setup_profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOne extends StatefulWidget {
  final PageController pageController;
  final setupProfile obj;

  const PageOne({
    Key? key,
    required this.pageController,
    required this.obj,
  }) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final CompanyController controller = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomeJobPostField(
          input: TextInputType.text,
          labelText: "Company Name",
          suffixIcon: const Icon(
            Icons.people,
            color: kPurple,
          ),
          controller: controller.companyName,
        ),
        const SizedBox(
          height: 50,
        ),
        CustomeJobPostField(
          input: TextInputType.text,
          labelText: "Email",
          suffixIcon: const Icon(
            Icons.email_outlined,
            color: kPurple,
          ),
          controller: controller.email,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPurple,
                ),
                onPressed: () {
                  widget.obj.companyName = controller.companyName.text;
                  widget.obj.email = controller.email.text;

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
