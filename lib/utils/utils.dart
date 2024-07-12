import 'package:flutter/material.dart';
import '../navigator_key.dart';
import 'custom_colors.dart';

class Utils {
  Utils._();

  static void showCustomDialog({
    required String title,
    required String content,
    required Function onTap,
  }) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                onTap();
              },
              child: Text('Tamam', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  static void showCustomDialogSnackbar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  static void showCustomDialogWithOptions({
    required String title,
    required String content,
    required Function onTap,
  }) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Geri', style: TextStyle(color: Colors.blue)),
                ),
                Divider(
                  color: Colors.black87,
                  height: 10.0,
                ),
                TextButton(
                  onPressed: () {
                    onTap();
                  },
                  child: Text('Hesabı sil', style: TextStyle(color: CustomColors.bwyRed)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
