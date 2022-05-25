import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/components/custometextfield.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/setup_profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fmij/model/districts.dart';

class PageThree extends StatefulWidget {
  final PageController pageController;
  final setupProfile obj;

  PageThree({
    Key? key,
    required this.pageController,
    required this.obj,
  }) : super(key: key);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String? dropdownvalue = 'Select district';

  var items = [
    'Select district',
  ];

  var listOfDistricts = <District>[];

  fetchDistrict() async {
    var url =
        "https://iamkrishnaa.github.io/nepal_province_to_municipality/districts.json";

    var data = await http.get(Uri.parse(url));
    listOfDistricts = districtFromJson(data.body);
    if (items.length < 2) {
      for (District d in listOfDistricts) {
        items.add(d.name);
      }
    }
  }

  final CompanyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: fetchDistrict(),
            builder: (context, snapshot) {
              return Container(
                height: 50,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: const Text(
                      "Hint Text",
                      textAlign: TextAlign.center,
                    ),
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    items: items.map(
                      (String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropdownvalue = newValue;
                        },
                      );
                    },
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 50,
        ),
        DescriptionField(
          controllerField: controller.companyDescription,
          labelText: "Company Description",
          suffixIcon: const Icon(Icons.text_fields),
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
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),
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
                  widget.obj.address = dropdownvalue;
                  widget.obj.companyDesc = controller.companyDescription.text;

                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 230),
                    curve: Curves.bounceIn,
                  );
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
