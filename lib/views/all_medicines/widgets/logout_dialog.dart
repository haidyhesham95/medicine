import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../lang/widget/app_local.dart';
import '../../auth/login/login.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        getLang(context, 'Logout'),
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      )),
      content: Text(
        getLang(context, "Are you sure you want to logout?"),
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                backgroundColor: WidgetStatePropertyAll( const Color(0xFF4DA8CF).withOpacity(0.9),
    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(getLang(context, 'Cancel'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal)),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(3),
                // backgroundColor: WidgetStatePropertyAll(ColorsAsset.kBrown),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ));
              },
              child: Text(getLang(context, 'Yes'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal)),
            ),
          ],
        ),
      ],
    );
  }
}
