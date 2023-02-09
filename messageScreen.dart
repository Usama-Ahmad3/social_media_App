import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class MessageScreen extends StatefulWidget {
  final String image, name, email, receiverId;
  const MessageScreen(
      {Key? key,
      required this.image,
      required this.email,
      required this.receiverId,
      required this.name})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('chat');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name.toString()),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(snapshot.child('image').value.toString(),fit: BoxFit.cover,)),
                      title: Text(snapshot.child('message').value.toString()),
                      subtitle:
                          Text('Sender Email :${snapshot.child('email').value.toString()}'),
                    ),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(height: 0, fontSize: 19),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                sendMessage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(15),
                            hintText: 'Enter Message',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    height: 0,
                                    color: AppColors.primaryTextTextColor
                                        .withOpacity(0.8)),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldDefaultFocus),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.alertColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        AppColors.textFieldDefaultBorderColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))),
                      ),
                    )),
                  ],
                ),
              )
            ]));
  }

  void sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userid.toString(),
        'receiver': widget.receiverId,
        'type': 'text',
        'time': timeStamp.toString(),
        'email': widget.email,
        'image': widget.image
      }).then((value) {
        messageController.text.toString();
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    }
  }
}
