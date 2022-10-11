


class Home {
  int state;
  List<HomeNotification> status;
  HomeVideo homeVideo;

  Home({this.state, this.status, this.homeVideo});

  Home.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['success'] != null) {
      status = new List<HomeNotification>();
      json['success'].forEach((v) {
        status.add(new HomeNotification.fromJson(v));
      });
    }
    homeVideo = json['home_video'] != null
        ? new HomeVideo.fromJson(json['home_video'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.status != null) {
      data['success'] = this.status.map((v) => v.toJson()).toList();
    }
    if (this.homeVideo != null) {
      data['home_video'] = this.homeVideo.toJson();
    }
    return data;
  }
}

class HomeNotification {
  int id;
  String status;
  int homeWorkId;
  int groupId;
  int userId;
  String createdAt;
  String updatedAt;
  String username;

  HomeNotification(
      {this.id,
        this.status,
        this.homeWorkId,
        this.groupId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.username});

  HomeNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    homeWorkId = json['home_work_id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['home_work_id'] = this.homeWorkId;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    return data;
  }
}

class HomeVideo {
  int id;
  String name;
  String type;
  String setting;
  String setting2;
  String createdAt;
  String updatedAt;

  HomeVideo(
      {this.id,
        this.name,
        this.type,
        this.setting,
        this.setting2,
        this.createdAt,
        this.updatedAt});

  HomeVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    setting = json['setting'];
    setting2 = json['setting2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['setting'] = this.setting;
    data['setting2'] = this.setting2;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}