import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilController>(builder: (_) {
      return Scaffold(
        body: ListView(
            shrinkWrap: true,
            clipBehavior: Clip.none,
            padding: EdgeInsets.zero,
            children: <Widget>[buildTop(_), buildContent(_)]),
      );
    });
  }

  Column buildContent(ProfilController _) {
    return Column(
      children: [
        // Text('${_.user!.firstname} ${_.user!.lastname}',
        // style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
        // const SizedBox(height: 8,),
        // Text(
        //   '${_.user!.email}',
        //   style: const TextStyle(fontSize: 20, color: Colors.black),
        // ),
        // const SizedBox(height: 16,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     buildSocialIcon(FontAwesomeIcons.slack),
        //     const SizedBox(width: 12,),
        //     buildSocialIcon(FontAwesomeIcons.github),
        //     const SizedBox(width: 12,),
        //     buildSocialIcon(FontAwesomeIcons.twitter),
        //     const SizedBox(width: 12,),
        //     buildSocialIcon(FontAwesomeIcons.linkedin),
        //   ],
        // ),
        // const SizedBox(height: 16,),
        // const Divider(),
        // const SizedBox(height: 16,),
        // const NumbersWidget(),
        const SizedBox(
          height: 16,
        ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
        buildForm(_),
      ],
    );
  }

  ListView buildForm(ProfilController _) {
    return ListView(shrinkWrap: true, clipBehavior: Clip.hardEdge, children: [
      Column(
        children: [
          Form(
              child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _.firstname.value,
                        keyboardType: TextInputType.name,
                        decoration:
                            const InputDecoration(labelText: 'firstname'),
                      ),
                      TextFormField(
                        controller: _.lastname.value,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(labelText: 'lastname'),
                      ),
                      TextFormField(
                        controller: _.email.value,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(labelText: 'email'),
                      ),
                      TextFormField(
                        controller: _.phone.value,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: 'phone'),
                      ),
                      TextFormField(
                        controller: _.avatar.value,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(labelText: 'avatar'),
                      ),
                      TextFormField(
                        controller: _.location.value,
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(labelText: 'location'),
                      ),
                      TextFormField(
                        controller: _.type.value,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(labelText: 'type'),
                      ),
                      TextFormField(
                        controller: _.state.value,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: 'state'),
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 5),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _.updateUser(
                              _.firstname.value.text,
                              _.lastname.value.text,
                              _.email.value.text,
                              _.phone.value.text,
                              _.avatar.value.text,
                              _.location.value.text,
                              _.type.value.text,
                              _.state.value.text);
                          Get.to(() => HomeView());
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Expanded(
                                    child: Text(
                                  "update",
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            )),
                      ))),
            ],
          ))
        ],
      )
    ]);
  }

  buildSocialIcon(IconData icon) => CircleAvatar(
      radius: 25,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Icon(
              icon,
              size: 32,
            ),
          ),
        ),
      ));

  Stack buildTop(ProfilController _) {
    final top = _.coverHeight - _.profileHeight;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(_),
        Positioned(top: top, child: buildCircleAvatar(_))
      ],
    );
  }

  CircleAvatar buildCircleAvatar(ProfilController _) {
    return CircleAvatar(
      radius: _.profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(_.user!.avatarUrl),
    );
  }

  Container buildCoverImage(ProfilController _) {
    return Container(
      color: Colors.grey,
      child: Image.network(_.user!.avatarUrl,
          width: double.infinity, height: _.coverHeight, fit: BoxFit.cover),
    );
  }
}