import 'package:fluttertoast/fluttertoast.dart';

class DialogService {
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
