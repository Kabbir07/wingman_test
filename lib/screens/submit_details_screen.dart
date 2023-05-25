import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wingman_test/models/submit_details.dart';
import 'package:wingman_test/services/api_request.dart';
import 'package:wingman_test/widgets/loading.dart';

import 'home_screen.dart';

class SubmitDetailsScreen extends StatefulWidget {
  final String token;
  const SubmitDetailsScreen({super.key, required this.token});

  @override
  State<SubmitDetailsScreen> createState() => _SubmitDetailsScreenState();
}

class _SubmitDetailsScreenState extends State<SubmitDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Looks like you are new here. Tell us a bit about yourself.",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Name'),
                      hintText: "Enter your name here.."),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                      hintText: "Enter your email here.."),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Empty fields can not be proceed");
                    } else {
                      MyLoading(context);
                      SubmitDetails? data = await submitDetails(
                          context,
                          nameController.text.trim().toString(),
                          emailController.text.trim().toString(),
                          widget.token);

                      if (data != null && data.status == true) {
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const HomeScreen();
                        }));
                      }
                    }
                  },
                  child: const Expanded(
                      child: Card(
                    color: Colors.amber,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    )),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
