import 'package:flutter/material.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/controller/admin%20Controller/admin_controller.dart';
import 'package:fyp_admin/view/profile.dart';
import 'package:get/get.dart';

class Companies extends StatelessWidget {
  Companies({Key? key}) : super(key: key);

  final Admin_Controller controller = Get.put(Admin_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPurple,
        centerTitle: true,
        title: const Text(
          "Companies",
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: kPurple,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(80.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
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
                            child: TextField(
                              controller: controller.searchedCompany,
                              decoration: const InputDecoration(
                                hintText: "Search ",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 29,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 44,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: ElevatedButton(
                            child: const Text(
                              "Search",
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
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: const BorderSide(
                                    color: Color(0xffF0EEFA),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              controller.searchCompanies();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.88,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: FutureBuilder(
                          future: controller.fetchCompaniesData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Obx(
                                () => controller.searchText.isEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller.companies.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Profile(
                                                            company: controller
                                                                    .companies[
                                                                index],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "http://localhost:4000/${controller.companies[index].imagePath}",
                                                    ),
                                                  ),
                                                  title: Text(controller
                                                      .companies[index]
                                                      .companyName),
                                                  subtitle: Text(
                                                    controller.companies[index]
                                                        .emailAddress,
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.location_on,
                                                color: klightpurple,
                                                size: 15,
                                              ),
                                              Text(controller.companies[index]
                                                  .districtName),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                            ],
                                          );
                                        })
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller.searchText.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  onTap: () {
                                                    Get.to(Profile(
                                                      company: controller
                                                          .searchText[index],
                                                    ));
                                                  },
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      "http://localhost:4000/${controller.searchText[index].imagePath}",
                                                    ),
                                                  ),
                                                  title: Text(controller
                                                      .searchText[index]
                                                      .companyName),
                                                  subtitle: Text(
                                                    controller.searchText[index]
                                                        .emailAddress,
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.location_on,
                                                color: klightpurple,
                                                size: 15,
                                              ),
                                              Text(controller.searchText[index]
                                                  .districtName),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                            ],
                                          );
                                        }),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
