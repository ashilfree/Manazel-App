

class AyaTest {
  int id;
  String name;
  String type;
  String setting;
  String setting2;
  String createdAt;
  String updatedAt;

  AyaTest(
      {this.id,
        this.name,
        this.type,
        this.setting,
        this.setting2,
        this.createdAt,
        this.updatedAt});

  AyaTest.fromJson(Map<String, dynamic> json) {
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