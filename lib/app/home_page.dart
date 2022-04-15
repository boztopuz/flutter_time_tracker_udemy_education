import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_tracker_flutter/widget/show_alert_dialog.dart';

import '../services/auth.dart';



class HomePage extends StatelessWidget {
  

  Future<void> _signOut(BuildContext context) async {
    try {
          final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _comfirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      cancelActionText: "Cancel",
      title: "Logut",
      content: "Are you sure that you want to logout?",
      defaultActionText: "Logout",
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          TextButton(
            child: const Text(
              "LogOut",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: () => _comfirmSignOut(context),
          )
        ],
      ),
    );
  }
}
