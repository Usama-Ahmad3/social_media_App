import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/view/dashboard/chat/messageScreen.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ref = FirebaseDatabase.instance.ref('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (SessionController().userid.toString() ==
                      snapshot.child('uid').value.toString()) {
                    return Container();
                  } else {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: MessageScreen(
                                  receiverId:
                                      snapshot.child('uid').value.toString(),
                                  email:
                                      snapshot.child('email').value.toString(),
                                  name: snapshot
                                      .child('username')
                                      .value
                                      .toString(),
                                  image: snapshot
                                      .child('profile')
                                      .value
                                      .toString()),
                              withNavBar: false);
                        },
                        title:
                            Text(snapshot.child('username').value.toString()),
                        subtitle:
                            Text(snapshot.child('email').value.toString()),
                        leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryTextTextColor)),
                            child:
                                snapshot.child('profile').value.toString() == ''
                                    ? const Icon(Icons.person)
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          snapshot
                                              .child('profile')
                                              .value
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
