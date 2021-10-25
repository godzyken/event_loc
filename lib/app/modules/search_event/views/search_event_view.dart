import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_event_controller.dart';

class SearchEventView extends GetView<SearchEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchEventView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SearchEventView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
