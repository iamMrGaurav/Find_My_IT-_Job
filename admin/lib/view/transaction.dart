import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/controller/admin%20Controller/admin_controller.dart';
import 'package:fyp_admin/model/transaction.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({Key? key}) : super(key: key);
  final Admin_Controller controller = Admin_Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        title: const Text("Transaction"),
      ),
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.88,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: const Color(0xffF0EEFA),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white38.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: klightpurple,
                                      ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextField(
                                    controller:
                                        controller.searchTransactionValue,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                IconlyLight.search,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      hintText: "Search Companies",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 39,
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
                                onPressed: () {
                                  controller.searchTransactionDetail();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "ID",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                                Text(
                                  "Username",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                                Text(
                                  "Email address",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                                Text(
                                  "Address",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                                Text(
                                  "Paid amount",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                                Text(
                                  "Payment date",
                                  style: GoogleFonts.roboto(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.49,
                            child: FutureBuilder(
                                future: controller.fetchTransaction(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Obx(
                                      () => ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller
                                                  .searchTransaction.isEmpty
                                              ? controller.transaction.length
                                              : controller
                                                  .searchTransaction.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: AlertBox(
                                                      tran: controller
                                                              .searchTransaction
                                                              .isEmpty
                                                          ? controller
                                                                  .transaction[
                                                              index]
                                                          : controller
                                                                  .searchTransaction[
                                                              index],
                                                    ));
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .searchTransaction
                                                                .isEmpty
                                                            ? controller
                                                                .transaction[
                                                                    index]
                                                                .userId
                                                                .toString()
                                                            : controller
                                                                .searchTransaction[
                                                                    index]
                                                                .userId
                                                                .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "https://avatars.githubusercontent.com/u/64460040?v=4"),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            " ${controller.searchTransaction.isEmpty ? controller.transaction[index].companyName : controller.transaction[index].companyName}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        controller
                                                                .searchTransaction
                                                                .isEmpty
                                                            ? controller
                                                                .transaction[
                                                                    index]
                                                                .emailAddress
                                                            : controller
                                                                .transaction[
                                                                    index]
                                                                .emailAddress,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        controller
                                                                .searchTransaction
                                                                .isEmpty
                                                            ? controller
                                                                .transaction[
                                                                    index]
                                                                .districtName
                                                            : controller
                                                                .transaction[
                                                                    index]
                                                                .districtName,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        controller
                                                                .searchTransaction
                                                                .isEmpty
                                                            ? controller
                                                                .transaction[
                                                                    index]
                                                                .payAmount
                                                                .toString()
                                                            : controller
                                                                .transaction[
                                                                    index]
                                                                .payAmount
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        controller
                                                                .searchTransaction
                                                                .isEmpty
                                                            ? controller
                                                                .transaction[
                                                                    index]
                                                                .paymentDate
                                                                .toString()
                                                                .substring(
                                                                    0, 10)
                                                            : controller
                                                                .transaction[
                                                                    index]
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: klightpurple,
                                    ));
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  final Transaction tran;
  const AlertBox({Key? key, required this.tran}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
              const Positioned(
                top: 176,
                left: 30,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/64460040?v=4"),
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
                tran.companyName,
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
                      tran.companyName,
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
                      tran.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    tran.verificationStatus == "true"
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
                      tran.website,
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
                      tran.website,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Pay amount :",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  tran.payAmount,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Payment date :",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  tran.paymentDate.toString().substring(0, 10),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                tran.companyDescription,
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
