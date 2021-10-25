import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/statistique_controller.dart';

class StatistiqueView extends GetView<StatistiqueController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StatistiqueView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StatistiqueView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
