class CheckUserResponse {
  bool? loged;
  bool? blocked;

  CheckUserResponse({this.loged, this.blocked});

  CheckUserResponse.fromJson(Map<String, dynamic> json) {
    loged = json['loged'];
    blocked = json['blocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loged'] = loged;
    data['blocked'] = blocked;
    return data;
  }
}
