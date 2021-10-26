import 'package:event_loc/app/modules/otp/views/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (_) {
              return _.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: [
                        Column(children: [
                          Form(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: TextFormField(
                                  controller: _.phone.value,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number'),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 40, bottom: 5),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          _.verifyPhone(_.phone.value.text);
                                          Get.to(() => OtpView());
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 15.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const <Widget>[
                                                Expanded(
                                                    child: Text(
                                                  "Sign In",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ],
                                            )),
                                      ))),
                            ],
                          ))
                        ])
                      ],
                    );
            }));
  }
}
