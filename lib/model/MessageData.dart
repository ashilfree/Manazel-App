import 'package:get/get.dart';
import 'package:manazel_alabrar/Api/Api.dart';
import 'package:manazel_alabrar/model/User.dart';
import 'package:provider/provider.dart';


class MessageData {

  int id;
  String message;
  String type;
  String filePath;
  String fileName;
  int userId;
  int teacherId;
  int senderId;
  int subGroupId;
  String createdAt;
  String updatedAt;
  String recordDuration;

  MessageData(
      {this.id,
        this.message,
        this.type,
        this.filePath,
        this.fileName,
        this.userId,
        this.teacherId,
        this.senderId,
        this.subGroupId,
        this.createdAt,
        this.updatedAt,
        this.recordDuration});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    filePath = json['file_path'];

    if(json['file_name']!=null){
      fileName = Url.getLinkRecordVoice(json['file_name']);
    }

    userId = json['user_id'];
    teacherId = json['teacher_id'];
    senderId = json['sender_id'];
    subGroupId = json['sub_group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recordDuration = json['record_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['type'] = this.type;
    data['file_path'] = this.filePath;
    data['file_name'] = this.fileName;
    data['user_id'] = this.userId;
    data['teacher_id'] = this.teacherId;
    data['sender_id'] = this.senderId;
    data['sub_group_id'] = this.subGroupId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['record_duration'] = this.recordDuration;
    return data;
  }

  bool get isText{
    return type == "text";
  }

  bool get isAudio{
    return type == "audio";
  }

  bool get isMe {
    return senderId.toString() == Get.context.read<User>().id.toString();
  }

}