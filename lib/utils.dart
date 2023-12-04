import 'package:expence_app/const/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //This function is used to tost message
  void toMassage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: kfirstColor,
      textColor: kWhite,
      fontSize: 16.0,
    );
  }
}
