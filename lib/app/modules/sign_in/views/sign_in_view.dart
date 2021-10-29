import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:event_loc/app/modules/otp/views/otp_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GetBuilder<SignInController>(
          init: SignInController(),
          builder: (_) {
            final widgetList = [
              Row(
                children: const [
                  SizedBox(
                    width: 28,
                  ),
                  Text(
                    'Bienvenue',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Form(
                  key: _.formKey,
                  onChanged: () => _.checkLogin(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 10.0, top: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey, //Color(0xfff05945),
                                        offset: Offset(0, 0),
                                        blurRadius: 5.0),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)),
                              width: (_.screenWidth / 2) - 140,
                              height: 55,
                              child: Material(
                                borderRadius: BorderRadius.circular(12.0),
                                child: InkWell(
                                  onTap: () => _.emailFormVisibility(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.email,
                                          size: 40,
                                          color: Colors.orangeAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 30.0, top: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey, //Color(0xfff05945),
                                        offset: Offset(0, 0),
                                        blurRadius: 5.0),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)),
                              width: (_.screenWidth / 2) - 140,
                              height: 55,
                              child: Material(
                                borderRadius: BorderRadius.circular(12.0),
                                child: InkWell(
                                  onTap: () => _.phoneFormVisibility(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.phone,
                                            size: 40, color: Colors.green),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: _.emailFormVisible.value,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                controller: _.email.value,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (newValue) => _.email.value.text = newValue!,
                                validator: (value) => _.verifyEmail(value),
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.email),
                                    labelText: 'Email'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                controller: _.password.value,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                onSaved: (value) {
                                  _.password.value.text = value!;
                                },
                                validator: (value) => _.verifyPassword(value!),
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.password),
                                    labelText: 'Password'),
                              ),
                            )
                          ])),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Visibility(
                          visible: _.telFormVisible.isTrue,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                controller: _.phone.value,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.phone),
                                    labelText: 'Phone Number'),
                              ),
                            )
                          ])),
                      Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 5),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_.phone.value.text != '') {
                                    _.verifyPhone(_.phone.value.text);
                                    Get.to(() => OtpView());
                                  } else {
                                    if (_.registerWithEmailPassword(
                                        _.email.value.text,
                                        _.password.value.text) != false) {
                                      Get.to(() => HomeView());
                                    }
                                    Get.back();
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 15.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Expanded(
                                            child: Text(
                                          "Sign up",
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    )),
                              ))),
                    ],
                  )),
              const SizedBox(
                height: 15.0,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 10.0, top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //Color(0xfff05945),
                                offset: Offset(0, 0),
                                blurRadius: 5.0),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      width: (_.screenWidth / 2) - 140,
                      height: 55,
                      child: Material(
                        borderRadius: BorderRadius.circular(12.0),
                        child: InkWell(
                          onTap: () {
                            print("facebook tapped");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/logo/fb.png",
                                    fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 30.0, top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //Color(0xfff05945),
                                offset: Offset(0, 0),
                                blurRadius: 5.0),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      width: (_.screenWidth / 2) - 140,
                      height: 55,
                      child: Material(
                        borderRadius: BorderRadius.circular(12.0),
                        child: InkWell(
                          onTap: () {
                            print("google tapped");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/logo/google.png",
                                    fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
            ];

            return _.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: _.pinned.value,
                        snap: _.snap.value,
                        floating: _.floating.value,
                        expandedHeight: _.coverHeight - 25,
                        backgroundColor: const Color(0xFFdccdb4),
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Image.asset(
                            'assets/images/logo/register.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(),
                            gradient: LinearGradient(colors: <Color>[
                              Color(0xFFdccdb4),
                              Color(0xFFd8c3ab)
                            ]),
                          ),
                          width: _.screenWidth,
                          height: 25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: _.screenWidth,
                                height: 25,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => widgetList[index],
                            childCount: widgetList.length),
                      ),
                    ],
                  );
          }),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 50.0,
            color: Colors.white,
            child: Center(
              child: Wrap(
                children: [
                  Text(
                    "connection user state: ${controller.auth.currentUser}",
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
