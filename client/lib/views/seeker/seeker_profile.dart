import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:fmij/views/seeker/test.dart';
import 'package:fmij/views/seeker/update_seekerProfile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../controller/seeker_controller.dart';

class SeekerProfile extends StatelessWidget {
  SeekerProfile({Key? key}) : super(key: key);

  final SeekerController profileController = Get.put(SeekerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: profileController.fetchSeekerProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.38,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [kPurple, klightpurple],
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        color: Colors.white,
                                        onPressed: () {
                                          Get.back();
                                          profileController
                                              .fetchSeekerProfile();
                                        },
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      ),
                                      color: Colors.white,
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();

                                            LoginController.authenticateToken =
                                                "";
                                            Get.to(LoginScreen());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Icon(
                                                Icons.logout,
                                              ),
                                              Text("Log Out")
                                            ],
                                          ),
                                          value: 1,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            "$api/${profileController.seekerProfileDetail[0].imagePath}"),
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
                                      "${profileController.seekerProfileDetail[0].firstName.capitalizeFirst} ${profileController.seekerProfileDetail[0].lastName.capitalizeFirst}",
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
                                      "@${profileController.seekerProfileDetail[0].userName}",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
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
                                              " ${profileController.seekerProfileDetail[0].jobPosition.capitalizeFirst.toString()}",
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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
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
                                              " ${profileController.seekerProfileDetail[0].dob.toString().substring(0, 10)}",
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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
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
                                              " ${profileController.seekerProfileDetail[0].districtName}",
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
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          " Bio",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 19,
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
                          "${profileController.seekerProfileDetail[0].bio.toString()}  ",
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
                        Row(
                          children: [
                            const Icon(
                              IconlyLight.call,
                              color: klightpurple,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(profileController
                                .seekerProfileDetail[0].contactNo
                                .toString())
                          ],
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Row(
                          children: [
                            const Icon(
                              IconlyLight.message,
                              color: klightpurple,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              profileController
                                  .seekerProfileDetail[0].emailAddress,
                            )
                          ],
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
                        profileController
                            .seekerProfileDetail[0].highestQualification,
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
                        "${profileController.seekerProfileDetail[0].workExperience.toString()} yrs",
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
                          itemCount: profileController
                              .seekerProfileDetail[0].languages.length,
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
                                    profileController.seekerProfileDetail[0]
                                        .languages[index],
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
                          width: MediaQuery.of(context).size.width * 0.34,
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
                            onPressed: () {
                              print(
                                  profileController.seekerProfileDetail[0].cv);
                              Get.to(
                                Pdf(
                                  path: profileController
                                      .seekerProfileDetail[0].cv,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: ElevatedButton(
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                            onPressed: () {
                              Get.to(
                                UpdateProfile(
                                  isUpdate: "yes",
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
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
    );
  }
}
