import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wingman_test/models/sending_otp.dart';
import 'package:wingman_test/screens/verify_otp_screen.dart';
import 'package:wingman_test/widgets/loading.dart';

import '../services/api_request.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({super.key});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Get Started",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Text("+91"),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: controller,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your phone number"),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  if (controller.text.length >= 10) {
                    MyLoading(context);
                    SendingOTP? data =
                        await SendOtp(controller.text.trim().toString());
                    if (data != null && data.status == true) {
                      Fluttertoast.showToast(msg: data.response);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return VerifyOtpScreen(
                          phone: controller.text,
                          req_id: data.requestId.toString(),
                        );
                      }));
                    } else {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg:
                              "Creating error to send OTP, Please try again later");
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please check your phone number",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP);
                  }
                },
                child: const Card(
                  color: Colors.amber,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Get OTP",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
