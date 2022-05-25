import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/components/custometextfield.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetContent extends StatefulWidget {
  BottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final CompanyController controller = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.fetchCompanyJobPosition(),
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.all(25),
            height: 900,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 69,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        " Post your Job",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade200,
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text(
                        "Hint Text",
                        textAlign: TextAlign.center,
                      ),
                      isExpanded: true,
                      value: controller.dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      items: controller.items.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.dropdownValue = newValue.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeJobPostField(
                    input: TextInputType.text,
                    controller: controller.jobTitle,
                    labelText: "Job Title (Optional)",
                    suffixIcon: const Icon(Icons.work),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade200,
                    ),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text(
                        "Hint Text",
                        textAlign: TextAlign.center,
                      ),
                      isExpanded: true,
                      value: controller.jobTypeValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      items: controller.jobType.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.jobTypeValue = newValue.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeJobPostField(
                    input: TextInputType.text,
                    controller: controller.minimumEducation,
                    labelText: "Minimum Education",
                    suffixIcon: const Icon(Icons.book),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeJobPostField(
                    input: TextInputType.text,
                    controller: controller.languages,
                    labelText: "Type prefer languages",
                    suffixIcon: const Icon(Icons.abc_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomeJobPostField(
                          input: TextInputType.number,
                          controller: controller.salary,
                          labelText: "Salary",
                          suffixIcon: const Icon(Icons.money_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Is Negotiable ?"),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(
                            controller.getColor),
                        value: controller.isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            controller.isChecked = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListTile(
                      onTap: () {},
                      title: const Text("Select Deadline Date"),
                      subtitle: Text(
                        controller.expiryDate.toString(),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              builder: (widget, child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          onPrimary: Colors.white,
                                          onSurface: kPurple,
                                          primary: Colors.deepPurple),
                                      dialogBackgroundColor: Colors.white,
                                      textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              textStyle: const TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  fontFamily: 'Quicksand'),
                                              primary: Colors.white,
                                              backgroundColor: Colors
                                                  .deepPurple, // Background color
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: kPurple,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))))),
                                  child: child!,
                                );
                              });
                          setState(() {
                            if (date != null) {
                              controller.expiryDate = date;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.calendar_today,
                          color: kPurple,
                        ),
                      ),
                    ),
                  ),
                  CustomeJobPostField(
                    input: TextInputType.number,
                    controller: controller.minimumExperience,
                    labelText: "Minimum Experience (yrs)",
                    suffixIcon: const Icon(Icons.timelapse),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DescriptionField(
                      controllerField: controller.jobDescription,
                      labelText: "Job Description",
                      suffixIcon: const Icon(Icons.text_fields_sharp)),
                  const SizedBox(
                    height: 20,
                  ),
                  DescriptionField(
                    controllerField: controller.jobSpecification,
                    labelText: "Job Specification",
                    suffixIcon: const Icon(Icons.text_fields),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            // addDynamic();
                            controller.postJob();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Post",
                            style: GoogleFonts.roboto(
                              fontSize: 21,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
