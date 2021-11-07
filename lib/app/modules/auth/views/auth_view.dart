import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthView'),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(builder: (_) {
        return Column(children: [
          Expanded(
              child: PageView.builder(
            itemCount: _.books.length,
            itemBuilder: (context, index) {
              final book = _.books[index];

              return Column(
                children: [
                  Expanded(
                      child: Image.network(
                    book!.urlImage!,
                    fit: BoxFit.cover,
                  )),
                  const SizedBox(height: 8,),
                  Text(book.title!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                ],
              );
            },
          )),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: ElevatedButton(
              child: const Text('Fetch book'),
              onPressed: ()=> _.getBook,
            ),
          )
        ]);
      }),
    );
  }
}
