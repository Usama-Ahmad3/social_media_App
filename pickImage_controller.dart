import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/res/components/input_text_field.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class ImagePickController with ChangeNotifier {
  final controller = TextEditingController();
  final focus = FocusNode();
  final databaseRef = FirebaseDatabase.instance.ref('user');
  final ref = firebase_storage.FirebaseStorage.instance
      .ref('/profile/${SessionController().userid}');
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  File? _image;
  File? get image => _image;
  Future cameraPicker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  void signout(BuildContext context) {
    setLoading(true);
    final auth = FirebaseAuth.instance;
    auth.signOut().then((value) {
      Utils.toastMessage('Log Out Successfully');
      setLoading(false);
      Navigator.pushNamed(context, RouteName.loginView);
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
    SessionController().userid = '';
  }

  Future<void> uploadImage() async {
    firebase_storage.UploadTask uploadTask =
        ref.putFile(File(image!.absolute.path));
    await Future.value(uploadTask);
    final url = await ref.getDownloadURL();
    databaseRef
        .child(SessionController().userid.toString())
        .update({'profile': url.toString()}).then((value) {
      Utils.toastMessage('Image Updated');
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }

  Future galleryPicker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage();
      notifyListeners();
    }
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      cameraPicker();
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      galleryPicker();
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.image),
                    title: const Text('Gallery'),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> showusername(BuildContext context, String name, String hint) {
    controller.text = name.toString();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Username')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: controller,
                      focusNode: focus,
                      onFileSubmittedValue: (_) {},
                      onValidator: (_) {},
                      keyboardType: TextInputType.text,
                      hint: hint,
                      obscureText: false)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: AppColors.alertColor))),
              TextButton(
                  onPressed: () {
                    databaseRef
                        .child(SessionController().userid.toString())
                        .update({'username': controller.text.toString()}).then(
                            (value) {
                      Utils.toastMessage('Updated');
                      controller.text = '';
                    }).onError((error, stackTrace) {
                      Utils.toastMessage(error.toString());
                    });
                    Navigator.pop(context);
                  },
                  child:
                      Text('OK', style: Theme.of(context).textTheme.subtitle2))
            ],
          );
        });
  }

  Future<void> showphone(BuildContext context, String name, String hint) {
    controller.text = name.toString();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Phone')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: controller,
                      focusNode: focus,
                      onFileSubmittedValue: (_) {},
                      onValidator: (_) {},
                      keyboardType: TextInputType.phone,
                      hint: hint,
                      obscureText: false),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    databaseRef
                        .child(SessionController().userid.toString())
                        .update({'phone': controller.text.toString()}).then(
                            (value) {
                      Utils.toastMessage('Updated');
                      controller.text = '';
                    }).onError((error, stackTrace) {
                      Utils.toastMessage(error.toString());
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
            ],
          );
        });
  }
}
