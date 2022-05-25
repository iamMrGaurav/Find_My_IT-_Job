import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/chat_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String imagepath;
  final String isCompany;
  final String seekerId;
  final String companyId;
  ChatScreen(
      {Key? key,
      required this.title,
      required this.imagepath,
      required this.isCompany,
      required this.seekerId,
      required this.companyId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("$api/${widget.imagepath}"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title.toString().capitalizeFirst.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: controller.fetchChatScreen(widget.companyId, widget.seekerId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => widget.isCompany == "yes"
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.chatScreen.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Align(
                                    alignment:
                                        controller.chatScreen[index].sender ==
                                                "1"
                                            ? Alignment.topLeft
                                            : Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: controller
                                                    .chatScreen[index].sender ==
                                                "0"
                                            ? const BorderRadius.only(
                                                topRight:
                                                    Radius.elliptical(-4, -99),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(9),
                                                topLeft: Radius.circular(8),
                                              )
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(8),
                                                topLeft:
                                                    Radius.elliptical(-80, 1),
                                              ),
                                        color: controller
                                                    .chatScreen[index].sender ==
                                                "0"
                                            ? klightpurple
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller
                                              .chatScreen[index].textMessage,
                                          style: TextStyle(
                                              color: controller
                                                          .chatScreen[index]
                                                          .sender ==
                                                      "0"
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.chatScreen.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Align(
                                    alignment:
                                        controller.chatScreen[index].sender ==
                                                "0"
                                            ? Alignment.topLeft
                                            : Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: controller
                                                    .chatScreen[index].sender ==
                                                "0"
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(9),
                                                topLeft:
                                                    Radius.elliptical(-80, 1),
                                              )
                                            : const BorderRadius.only(
                                                topRight:
                                                    Radius.elliptical(-4, -99),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(8),
                                                topLeft: Radius.circular(8),
                                              ),
                                        color: controller
                                                    .chatScreen[index].sender ==
                                                "0"
                                            ? Colors.white
                                            : klightpurple,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller
                                              .chatScreen[index].textMessage,
                                          style: GoogleFonts.roboto(
                                              color: controller
                                                          .chatScreen[index]
                                                          .sender ==
                                                      "0"
                                                  ? klightpurple
                                                  : Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kTheme,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
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
                                    controller: controller.sendMessage,
                                    decoration: InputDecoration(
                                      hintText: "Type message",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          if (controller
                                              .sendMessage.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Please type your message",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            controller.sendMessages(
                                                widget.isCompany == "yes"
                                                    ? 0
                                                    : 1,
                                                widget.companyId,
                                                widget.seekerId);
                                          }
                                        },
                                        icon: const Icon(Icons.send),
                                        color: klightpurple,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
