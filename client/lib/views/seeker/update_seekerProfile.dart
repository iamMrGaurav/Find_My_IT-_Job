import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/components/custometextfield.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/get.dart';
import '../../controller/seeker_controller.dart';

class UpdateProfile extends StatefulWidget {
  final String isUpdate;
  UpdateProfile({Key? key, required this.isUpdate}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final SeekerController getController = Get.put(SeekerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: getController.fetchDistrict(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: const Text("Update Profile"),
                        leading: getController.image != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    FileImage(getController.image!),
                              )
                            : widget.isUpdate == "yes"
                                ? getController
                                            .seekerProfileDetail[0].imagePath !=
                                        null
                                    ? CircleAvatar(
                                        radius: 45,
                                        backgroundImage: NetworkImage(
                                            "$api/${getController.seekerProfileDetail[0].imagePath}"),
                                      )
                                    : const CircleAvatar(
                                        radius: 45,
                                        backgroundImage: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                                      )
                                : const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                                  ),
                        trailing: IconButton(
                          onPressed: () async {
                            await getController.getImage();
                            setState(() {});
                            if (widget.isUpdate == "yes") {
                              await getController
                                  .updateProfileImage(getController.image!);
                              setState(() {});
                              getController.fetchSeekerProfile();
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.firstName,
                        labelText: "First Name",
                        suffixIcon: const Icon(IconlyLight.profile),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.lastName,
                        labelText: "Last Name",
                        suffixIcon: const Icon(Icons.timelapse),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.email,
                        labelText: "Email",
                        suffixIcon: const Icon(IconlyLight.message),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        onTap: () {},
                        title: const Text("Select Date Of Birth"),
                        subtitle: Text(
                          getController.dob != null
                              ? getController.dob.toString().substring(0, 10)
                              : "",
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1000),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            setState(() {
                              if (date != null) {
                                getController.dob = date;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_today,
                            color: kPurple,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffF0EEFA),
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
                            value: getController.dropdownvalue,
                            icon: const Icon(IconlyLight.arrowDownCircle),
                            iconSize: 24,
                            items: getController.items.map(
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
                                  getController.dropdownvalue = newValue;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.contactNo,
                        labelText: "Contact No",
                        suffixIcon: const Icon(IconlyLight.call),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.number,
                        controller: getController.workExperience,
                        labelText: "Work Experience",
                        suffixIcon: const Icon(IconlyLight.timeSquare),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffF0EEFA),
                        ),
                        child: DropdownButton(
                          value: getController.dropdownValueJob,
                          underline: const SizedBox(),
                          hint: const Text(
                            "Hint Text",
                            textAlign: TextAlign.center,
                          ),
                          isExpanded: true,
                          icon: const Icon(IconlyLight.arrowDownCircle),
                          iconSize: 24,
                          items: getController.itemsJob.map(
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
                              getController.dropdownValueJob =
                                  newValue.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.highestQualification,
                        labelText: "Highest Qualification",
                        suffixIcon: const Icon(IconlyLight.document),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.jobPosition,
                        labelText: "Job Postion (Optional)",
                        suffixIcon: const Icon(Icons.work),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomeJobPostField(
                        input: TextInputType.text,
                        controller: getController.preferLanguages,
                        labelText: "Type prefer languages",
                        suffixIcon: const Icon(Icons.abc_rounded),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DescriptionField(
                        controllerField: getController.bio,
                        labelText: "Bio",
                        suffixIcon: const Icon(IconlyLight.paper),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 36,
                            width: MediaQuery.of(context).size.width * 0.32,
                            child: ElevatedButton(
                              child: const Text(
                                "Upload CV",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: klightpurple,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color(0xffF0EEFA),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                      color: Color(0xffF0EEFA),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await getController.getCv();
                                if (widget.isUpdate == "yes") {
                                  await getController
                                      .updateProfileCV(getController.cv!);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 36,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: ElevatedButton(
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.deepPurple,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                      color: Colors.deepPurple,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (widget.isUpdate == "yes") {
                                  await getController.updateProfileFields(
                                      getController.dropdownvalue);
                                } else {
                                  getController.upload(
                                    getController.image!,
                                    getController.cv!,
                                    getController.dropdownvalue,
                                    widget.isUpdate,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: klightpurple,
                  ));
                }
              }),
        ),
      ),
    );
  }
}
