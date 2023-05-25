import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:wingman_test/models/verify_otp.dart';
import 'package:wingman_test/screens/home_screen.dart';
import 'package:wingman_test/screens/submit_details_screen.dart';
import 'package:wingman_test/widgets/loading.dart';

import '../services/api_request.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;
  final String req_id;
  const VerifyOtpScreen({super.key, required this.phone, required this.req_id});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    var pinputController = TextEditingController();
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
              Text(
                "Verify OTP \n that sent to +91-${widget.phone}",
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Pinput(
                controller: pinputController,
                length: 6,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  if (pinputController.text.length == 6) {
                    MyLoading(context);
                    VerifyOTP? data = await VerifyOtp(
                      pinputController.text.trim().toString(),
                      widget.req_id,
                    );
                    if (data != null) {
                      if (data.profileExists == false) {
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SubmitDetailsScreen(token: data.jwt);
                        }));
                      } else {
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const HomeScreen();
                        }));
                      }
                    } else {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "Something error occured");
                    }
                  } else {
                    Fluttertoast.showToast(msg: "OTP not matched");
                  }
                },
                child: const Card(
                  color: Colors.amber,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Verify OTP",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Retry"))
            ],
          ),
        ),
      ),
    );
  }
}
