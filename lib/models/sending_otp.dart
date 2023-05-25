class SendingOTP {
  SendingOTP({
    required this.status,
    required this.response,
    required this.requestId,
  });
  late final bool status;
  late final String response;
  late final String requestId;

  SendingOTP.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response'] = response;
    _data['request_id'] = requestId;
    return _data;
  }
}
