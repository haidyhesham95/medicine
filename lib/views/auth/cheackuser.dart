
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../wrapper.dart';
import '../splash_screen/splash_screen.dart';

class CheackUser extends StatefulWidget {
  const CheackUser({Key? key}) : super(key: key);

  @override
  State<CheackUser> createState() => _CheackUserState();
}

class _CheackUserState extends State<CheackUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return Wrapper();
          
        }else{
          return AnimatedSplashScreen();
        }
      },
    );
  }
}
