import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_article_controller.dart';

class AddArticleView extends GetView<AddArticleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddArticleView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddArticleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
