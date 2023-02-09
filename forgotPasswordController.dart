import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';

class ForgotPasswordController with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void fogotpassword(BuildContext context, String email) {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        Utils.toastMessage('Email Send. Please Check Your Email');
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
