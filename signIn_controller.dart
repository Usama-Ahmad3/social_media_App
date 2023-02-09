import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class loginController with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void signin(BuildContext context, String email, String password) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userid = value.user!.uid.toString();
        Utils.toastMessage('Login Successful');
        Navigator.pushNamed(context, RouteName.dashboardScreen);
        setLoading(false);
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
