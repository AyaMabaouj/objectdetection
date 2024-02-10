import 'package:flutter/material.dart';

class VisualNotif {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Color.fromARGB(255, 227, 0, 0),
              ),
              SizedBox(width: 10),
              Text('Faites attention'),
            ],
          ),
          content: Text('Votre message ici...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
