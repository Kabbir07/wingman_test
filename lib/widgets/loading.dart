import 'package:flutter/material.dart';

Future MyLoading(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      });
}
