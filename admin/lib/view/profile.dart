import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/model/company.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final CompanyDetails company;
  const Profile({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 176,
                left: 30,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://localhost:4000/${company.imagePath}"),
                  radius: 50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 55,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 40,
              ),
              Text(
                "${company.companyName.toString().capitalizeFirst}",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: klightpurple,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      company.districtName,
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 19,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      IconlyLight.message,
                      color: klightpurple,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      company.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    company.verificationStatus == "true"
                        ? Image.asset(
                            "assets/images/verified.png",
                            height: 19,
                            width: 19,
                          )
                        : const Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 19,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      IconlyLight.call,
                      color: klightpurple,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      company.contactNo,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 19,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      IconlyLight.category,
                      color: klightpurple,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      company.website,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 19,
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "${company.companyDescription} ",
                style: const TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
