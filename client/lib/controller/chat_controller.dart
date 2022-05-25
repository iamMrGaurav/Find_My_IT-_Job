import 'package:flutter/material.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/model/message.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/state_manager.dart';
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

  @override
  void onInit() {
    super.onInit();
    socketFunction();
  }

  socketFunction() {
    socket.onConnect((_) {
      socket.emit('msg', 'test');
    });
    socket.emit(
        "login",
        jsonEncode({
          //id pathauni
          "userName": 26,
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
      print(chatScreen.length);
      update();
    });
  }

  sendMessages(sender, companyId, seekerId) async {
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
      if (data.statusCode == 200) {
        Message message = Message(
            companyId: 2,
            seekerId: 15,
            textMessage: sendMessage.text,
            sender: sender.toString(),
            messageDate: DateTime.now());
        chatScreen.add(message);
        socket.emit(
            "sendMessage",
            jsonEncode({
              "receiverName": "test_user",
              "companyId": 2,
              "seekerId": 15,
              "message": sendMessage.text,
              "sender": sender.toString()
            }));
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
      print(companyId);
      print(seekerId);
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
    }
  }
}
