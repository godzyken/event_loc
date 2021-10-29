import 'package:event_loc/app/modules/login/views/login_view.dart';
import 'package:event_loc/app/modules/profil/views/profil_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return Text(
                      'Hello boss are you log ?: ${_.user!.email} ',
                      style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    );
                  }),
                  TextButton(
                      onPressed: () => Get.to(() => ProfilView()),
                      child: const Icon(
                        Icons.person_add_alt,
                        size: 50,
                      )),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.logout),
              onPressed: () async {
                await _.auth.signOut();
                if (_.auth.currentUser == null) {
                  Get.to(() => LoginView());
                }
              },
            ),
          );
        });
  }
}
