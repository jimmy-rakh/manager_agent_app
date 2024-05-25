class DefaultResponse {
  late bool success;
  String? errorMessage;

  DefaultResponse({required this.success, this.errorMessage});

  DefaultResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error_message'] = errorMessage;
    return data;
  }
}
