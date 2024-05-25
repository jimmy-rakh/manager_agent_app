class UserRequestsDto {
  int? id;
  String? type;
  String? status;
  String? createdAt;

  UserRequestsDto({this.id, this.type, this.status, this.createdAt});

  UserRequestsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}