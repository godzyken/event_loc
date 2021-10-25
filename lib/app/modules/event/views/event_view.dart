import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EventView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EventView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
