import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes.dart';

class WidgetUtils {
  static void showErrorSnackbar(
      GlobalKey<ScaffoldState> scaffoldKey, String error) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showConfirmDialog(
    BuildContext context,
    String content,
    Function onCancel,
    Function onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: TextStyle(color: lightTheme.textTheme.caption.color),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                onCancel();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: lightTheme.primaryColor),
              ),
            ),
          ],
          content: Text(content),
        );
      },
    );
  }

  static void showErrorDialog(BuildContext context, String error) {
    if (context == null) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.orange),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Sorry', style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok', style: TextStyle(color: Colors.orange)),
            ),
          ],
          content: Text(error),
        );
      },
    );
  }

  static void showErrorDialogExtended(
    BuildContext context,
    String title,
    String description,
    List<Widget> actions,
  ) {
    if (context == null) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.orange),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(title, style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
          actions: actions,
          content: Text(description),
        );
      },
    );
  }

  static void showSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  static Widget loadingView() {
    return Center(child: CircularProgressIndicator());
  }

  static void applyNotEmptyValidation(
      FocusNode focusNode,
      TextEditingController controller,
      Function showEmptyFieldError,
      Function removeError) {
    // Add error for empty input on focus lost
    focusNode.addListener(() {
      if (!focusNode.hasFocus && controller.text.isEmpty) {
        showEmptyFieldError();
      }
    });

    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        removeError();
      }

      if (focusNode.hasFocus && controller.text.isEmpty) {
        showEmptyFieldError();
      }
    });
  }

  static void showSuccessDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success!', style: TextStyle(color: Colors.green)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok', style: TextStyle(color: Colors.green)),
            ),
          ],
          content: Text(content),
        );
      },
    );
  }

  static void showLoginDialog(
    BuildContext context,
    String content,
    Function onCancel,
    Function onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: TextStyle(color: lightTheme.textTheme.caption.color),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                onCancel();
                Navigator.pop(context);
              },
              child: Text(
                'Go to Login',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            FlatButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Text(
                'Login Now',
                style: TextStyle(color: lightTheme.primaryColor),
              ),
            ),
          ],
          content: Text(content),
        );
      },
    );
  }
}
