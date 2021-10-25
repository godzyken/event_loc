import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_event_controller.dart';

class AddEventView extends GetView<AddEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddEventView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddEventView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
