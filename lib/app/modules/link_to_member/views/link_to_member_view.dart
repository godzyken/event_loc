import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/link_to_member_controller.dart';

class LinkToMemberView extends GetView<LinkToMemberController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LinkToMemberView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LinkToMemberView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
