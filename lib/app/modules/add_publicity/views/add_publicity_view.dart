import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_publicity_controller.dart';

class AddPublicityView extends GetView<AddPublicityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddPublicityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddPublicityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
