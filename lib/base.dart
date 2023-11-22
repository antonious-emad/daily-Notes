import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseConnector{
showLoading();
showmessage(String message);
hideLoading();
}
class BaseViewModel<CONNECTOR extends BaseConnector> extends ChangeNotifier{
CONNECTOR? connector;
}
abstract class BaseView<VIEWMODEL extends BaseViewModel ,S extends StatefulWidget> extends State<S> implements BaseConnector{
late VIEWMODEL viewmodel;

VIEWMODEL inintMyViewModel();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel=inintMyViewModel();
  }

@override
hideLoading() {
  Navigator.pop(context);
}

@override
showLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      title: Center(child: CircularProgressIndicator()),
    ),);
}

showMessage(String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      title: Text("Error"),
      content: Text(message),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Thanks")),
      ],
    ),);
}

}