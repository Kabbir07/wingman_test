class VerifyOTP {
  VerifyOTP({
    required this.status,
    required this.profileExists,
    required this.jwt,
  });
  late final bool status;
  late final bool profileExists;
  late final String jwt;

  VerifyOTP.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profileExists = json['profile_exists'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['profile_exists'] = profileExists;
    _data['jwt'] = jwt;
    return _data;
  }
}
