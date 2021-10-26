import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
        init: OtpController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('OtpView'),
              centerTitle: true,
            ),
            body: _.loginC.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      children: [
                        const Spacer(),
                        TextField(
                          controller: _.otp,
                          decoration: const InputDecoration(
                            hintText: "Enter OTP",
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () => _.loginC.otpVerify(_.otp.value.text),
                          child: Text("Verify"),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
          );
        });
  }
}
