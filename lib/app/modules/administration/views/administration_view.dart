import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/administration_controller.dart';

class AdministrationView extends GetView<AdministrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdministrationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AdministrationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
