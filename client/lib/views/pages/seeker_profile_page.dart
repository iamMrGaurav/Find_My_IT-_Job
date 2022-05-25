import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/main.dart';
import 'package:fmij/utilities/global.dart';

import 'package:fmij/views/pages/message.dart';
import 'package:fmij/views/seeker/test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/constants.dart';
import '../../model/seeker.dart';
import 'package:url_launcher/url_launcher.dart';

class SeekerProfilePage extends StatelessWidget {
  final String isAppliedSeeker;
  final SeekerProfile profileController;
  const SeekerProfilePage({
    Key? key,
    required this.profileController,
    required this.isAppliedSeeker,
    // required this.isPostJob
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.29,
                    color: Colors.deepPurple,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "$api/${profileController.imagePath}"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${profileController.firstName.capitalizeFirst} ${profileController.lastName.capitalizeFirst}",
                              style: GoogleFonts.roboto(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "@${profileController.userName}",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.work,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      " ${profileController.jobPosition.capitalizeFirst.toString()}",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      IconlyLight.calendar,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      " ${profileController.dob.toString().substring(0, 10)}",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      IconlyLight.location,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      " ${profileController.districtName}",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  " Bio",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "${profileController.bio.toString()}  ",
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    await launch('tel:${profileController.contactNo}');
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconlyLight.call,
                        color: klightpurple,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(profileController.contactNo.toString())
                    ],
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await launch(
                          'mailto:${profileController.emailAddress}?subject=This is Subject Title&body=This is Body of Email');
                    } catch (exception) {
                      print(exception);
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconlyLight.message,
                        color: klightpurple,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        profileController.emailAddress,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xffB980F0),
                child: Icon(
                  IconlyLight.document,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Highest Qualification",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                profileController.highestQualification,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xffFF6363),
                child: Icon(
                  IconlyLight.timeCircle,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Work Experience",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "${profileController.workExperience.toString()} yrs",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Text(
                  "Skills",
                  style: GoogleFonts.roboto(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: profileController.languages.length,
                  itemBuilder: (contex, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? const Color(0xffcdd3ff)
                              : const Color(
                                  0xffddc2ff,
                                ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            profileController.languages[index],
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 36,
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    child: const Text(
                      "View CV",
                      style: TextStyle(
                        fontSize: 18,
                        color: klightpurple,
                        letterSpacing: 1.1,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffF0EEFA),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: Color(0xffF0EEFA),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print(profileController.cv);
                      Get.to(
                        Pdf(
                          path: profileController.cv,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                isAppliedSeeker == "yes"
                    ? GestureDetector(
                        onTap: () {
                          Get.to(ChatScreen(
                            companyId: MainScreen.companyId,
                            seekerId: profileController.seekerId.toString(),
                            isCompany: "yes",
                            imagepath: profileController.imagePath,
                            title: profileController.firstName,
                            receiverName: profileController.userName,
                          ));
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: klightpurple,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                              Text(
                                "Message",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            )
          ],
        ));
  }
}
