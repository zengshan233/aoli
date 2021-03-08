import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static show(String msg) {
    if (msg != null && msg.isNotEmpty == true) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
