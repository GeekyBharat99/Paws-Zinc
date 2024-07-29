class DogBreedsResponseModel {
  List<String>? message;
  String? status;

  DogBreedsResponseModel({this.message, this.status});

  DogBreedsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
