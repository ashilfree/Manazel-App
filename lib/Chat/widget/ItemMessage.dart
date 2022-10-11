


import 'package:flutter/material.dart';
import 'package:manazel_alabrar/Chat/Controller/ChatController.dart';
import 'package:manazel_alabrar/Chat/widget/ItemMessageText.dart';
import 'package:manazel_alabrar/Chat/widget/ItemMessageVoice.dart';
import 'package:manazel_alabrar/model/MessageData.dart';
import 'package:manazel_alabrar/model/MessageType.dart';



class ItemMessage extends StatelessWidget {
  final MessageData messageData;
  final ChatController controller;
  const ItemMessage({Key key, this.messageData, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (messageData.type.toString()) {
      case MessageType.text:
        return ItemMessageText(messageData:messageData,
          isMe: !messageData.isMe,);
        break;

      case MessageType.audio:
        return ItemMessageVoice(messageData:messageData,
          isMe: !messageData.isMe,);
        break;
    }
    return Container();
  }
}