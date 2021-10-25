import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/publicity_controller.dart';

class PublicityView extends GetView<PublicityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PublicityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PublicityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
