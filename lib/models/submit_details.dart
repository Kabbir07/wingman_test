class SubmitDetails {
  SubmitDetails({
    required this.status,
    required this.response,
  });
  late final bool status;
  late final String response;

  SubmitDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response'] = response;
    return _data;
  }
}
