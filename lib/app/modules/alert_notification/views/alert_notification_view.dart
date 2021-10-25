import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/alert_notification_controller.dart';

class AlertNotificationView extends GetView<AlertNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertNotificationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AlertNotificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
