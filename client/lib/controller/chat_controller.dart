import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/main.dart';
import 'package:fmij/model/message.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatController extends GetxController {
  TextEditingController sendMessage = TextEditingController();

  var chatScreen = <Message>[].obs;
  late IO.Socket socket = IO.io(api, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  // Timer? timer;
  int? seekerId;
  int? companyId;

  @override
  void onInit() {
    super.onInit();
    activate();
    // timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   fetchChatScreen(seekerId, companyId);
    // });
  }

  String? uid;
  activate() async {
    SharedPreferences pfs = await SharedPreferences.getInstance();
    uid = pfs.getString("uName");
    await fetchChatScreen(companyId, seekerId);

    socketFunction();
  }

  socketFunction() {
    socket.onConnect((_) {
      socket.emit('msg', 'test');
    });

    socket.emit(
        "login",
        jsonEncode({
          "userName": uid,
        }));
    socket.on("receive-message", (data) {
      Message message = Message(
          companyId: data["companyId"],
          seekerId: data["seekerId"],
          textMessage: data["message"],
          messageDate: DateTime.now(),
          sender: data["sender"]);
      chatScreen.add(message);
      chatScreen.refresh();
      fetchChatScreen(companyId, seekerId);
      update();
    });
  }

  sendMessages(int sender, int companyId, int seekerId, receiverId) async {
    try {
      var url =
          "$api/company/sendMessage/?token=${LoginController.authenticateToken}";
      var message = {
        "company_id": companyId.toString(),
        "seeker_id": seekerId.toString(),
        "text_message": sendMessage.text,
        "isSender": sender.toString(),
        "message_date": DateTime.now().toString()
      };
      var data = await http.post(Uri.parse(url), body: message);
      print(data.body);
      print(data.statusCode);
      if (data.statusCode == 200) {
        Message message = Message(
            companyId: companyId,
            seekerId: seekerId,
            textMessage: sendMessage.text,
            sender: sender.toString(),
            messageDate: DateTime.now());

        print("i got msg");
        print(receiverId.toString());
        socket.emit(
            "sendMessage",
            jsonEncode({
              "receiverName": receiverId.toString(),
              "companyId": companyId,
              "seekerId": seekerId,
              "message": sendMessage.text,
              "sender": sender.toString()
            }));
        chatScreen.add(message);
        chatScreen.refresh();
        update();
        sendMessage.clear();
      } else {
        print(data.body);
      }
    } catch (e) {
      print(e);
    }
  }

  fetchChatScreen(companyId, seekerId) async {
    try {
      var url =
          "$api/company/getMessage/?token=${LoginController.authenticateToken}";
      var data = await http.post(Uri.parse(url), body: {
        "company_id": companyId.toString(),
        "seeker_id": seekerId.toString()
      });

      var result = jsonDecode(data.body);

      chatScreen.value = messageFromJson(jsonEncode(result["data"]));
      return chatScreen;
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }
}
