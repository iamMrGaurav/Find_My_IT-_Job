import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/admin Controller/admin_controller.dart';

class Add_Widget extends StatelessWidget {
  Add_Widget({Key? key}) : super(key: key);

  final Admin_Controller controller = Get.put(Admin_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              color: kPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.only(left: 59),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                                  primary: klightpurple,
                                ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextField(
                              onChanged: (value) {
                                controller.searchSelectedJobPosition(value);
                              },
                              decoration: const InputDecoration(
                                hintText: "Search ",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 29,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Color(0xffF0EEFA),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xffF0EEFA),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.add),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ThemeData()
                                                .colorScheme
                                                .copyWith(
                                                  primary: klightpurple,
                                                ),
                                          ),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      controller.jobPosition,
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons.work),
                                                    labelText: 'Job Position',
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: kPurple,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: klightpurple),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  height: 46,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: kPurple,
                                                    ),
                                                    onPressed: () {
                                                      controller.addJobPosition(
                                                          controller.jobPosition
                                                              .text);
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 21,
                                                        color: Colors.white,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  )
                ],
              )),
          Flexible(
            child: FutureBuilder(
                future: controller.fetchCompanyJobPosition(),
                builder: (context, snapshot) {
                  return Obx(
                    () => controller.searchJobPosition.isEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.JobPostPosition.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        controller.editJobPosition.text =
                                            controller.JobPostPosition[index]
                                                .jobPositionName;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme: ThemeData()
                                                      .colorScheme
                                                      .copyWith(
                                                        primary: klightpurple,
                                                      ),
                                                ),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextFormField(
                                                        controller: controller
                                                            .editJobPosition,
                                                        decoration:
                                                            const InputDecoration(
                                                          icon:
                                                              Icon(Icons.work),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: kPurple,
                                                              width: 2,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    klightpurple),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color:
                                                                          klightpurple))),
                                                          TextButton(
                                                              onPressed: () {
                                                                controller.updateJobPosition(
                                                                    controller
                                                                        .JobPostPosition[
                                                                            index]
                                                                        .jobPositionId,
                                                                    controller
                                                                        .editJobPosition
                                                                        .text);
                                                              },
                                                              child: const Text(
                                                                "Update",
                                                                style: TextStyle(
                                                                    color:
                                                                        klightpurple),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: kPurple,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        controller.JobPostPosition[index]
                                            .jobPositionName,
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          color: Colors.grey[600],
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      trailing: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Are you sure you want to delete ${controller.JobPostPosition[index].jobPositionName} ?"),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color:
                                                                          klightpurple))),
                                                          TextButton(
                                                              onPressed: () {
                                                                controller.deleteJobPosition(controller
                                                                    .JobPostPosition[
                                                                        index]
                                                                    .jobPositionId);
                                                              },
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color:
                                                                        klightpurple),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text("Delete",
                                            style:
                                                TextStyle(color: klightpurple)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.searchJobPosition.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {},
                                      leading: CircleAvatar(
                                        backgroundColor: kPurple,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        controller.searchJobPosition[index]
                                            .jobPositionName,
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          color: Colors.grey[600],
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      trailing: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: klightpurple),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
