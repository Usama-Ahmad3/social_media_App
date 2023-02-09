import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class SignupController with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void signup(
      BuildContext context, String username, String email, String password) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userid = value.user!.uid.toString();
        Utils.toastMessage('SignUp Succeed');
        setLoading(false);
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': '',
          'phone': '',
          'username': username,
          'profile': ''
        }).then((value) {
          Navigator.pushNamed(context, RouteName.dashboardScreen);
          Utils.toastMessage('Account Created');
          setLoading(false);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.toastMessage(error.toString());
        });
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
