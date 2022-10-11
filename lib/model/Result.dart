

class ResultApi {

   int state = 20;
   String error;
   dynamic success;
   String message;

  ResultApi.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    error = json['error'];
    success = json['success'];
    message = json['message'];

    if(error!=null){
       state = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['error'] = this.error;
    data['success'] = this.success;
    return data;
  }

}