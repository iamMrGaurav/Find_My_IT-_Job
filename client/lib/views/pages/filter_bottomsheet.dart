import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/seeker_controller.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatefulWidget {
  final String isSeeker;

  const FilterBottomSheet({
    Key? key,
    required this.isSeeker,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

final CompanyController controller = Get.find();
final SeekerController getSeeker = Get.find();

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.fetchDistrict(),
        builder: (context, snapshot) {
          return Container(
              padding: const EdgeInsets.all(25),
              height: 290,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 69,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Choose your filters",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<CompanyController>(
                      init: controller,
                      builder: (controller) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.6,
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
                                  value: controller.dropdownvalueD,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 24,
                                  items: controller.itemsD.map(
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
                                    setState(
                                      () {
                                        controller.dropdownvalueD =
                                            newValue.toString();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
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
                                      controller.jobTypeValue =
                                          newValue.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
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
                          value: controller.dateValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          items: controller.dateValues.map(
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
                            setState(
                              () {
                                controller.dateValue = newValue.toString();
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.1,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ))),
                      onPressed: () {
                        if (widget.isSeeker == "seeker") {
                          getSeeker.getFilterSearchData(
                              getSeeker.searchTextField.text.isEmpty
                                  ? "nothing"
                                  : getSeeker.searchTextField.text,
                              controller.dropdownvalueD,
                              controller.jobTypeValue,
                              controller.dateValue);
                          Get.back();
                        } else {
                          controller.getFilterSearchData(
                            controller.searchJob.text,
                            controller.dropdownvalueD,
                            controller.jobTypeValue,
                            controller.dateValue,
                          );
                          Get.back();
                        }
                      },
                    ),
                  )
                ],
              ));
        });
  }
}
