import 'dart:convert';

import 'package:wingman_test/models/sending_otp.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_test/models/submit_details.dart';
import 'package:wingman_test/models/verify_otp.dart';
import 'package:wingman_test/services/apis.dart';

Future<SendingOTP?> SendOtp(String phoneNumber) async {
  try {
    Map data = {'mobile': phoneNumber};
    var body = json.encode(data);

    var response = await http.post(sendOtpPath(), body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return SendingOTP.fromJson(data);
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<VerifyOTP?> VerifyOtp(String otp, String req_id) async {
  try {
    Map data = {"request_id": req_id, "code": otp};
    var body = json.encode(data);
    final response = await http.post(verifyOtpPath(), body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return VerifyOTP.fromJson(data);
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<SubmitDetails?> submitDetails(
    context, String name, String email, String token) async {
  try {
    Map data = {"name": name, "email": email};

    var body = json.encode(data);
    final response = await http.post(submitDetailsPath(), body: body, headers: {
      "Token": token,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return SubmitDetails.fromJson(data);
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
  }
}
