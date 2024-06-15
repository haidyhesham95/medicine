// import 'package:flutter/material.dart';
// import 'package:pharmacy/views/auth/login/login.dart';
// import 'package:pharmacy/views/splash_screen/splash_screen.dart';

// class SplashScreenWrapper extends StatefulWidget {
//   const SplashScreenWrapper({super.key});

//   @override
//   _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
// }

// class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }

//   _navigateToHome() async {
//     // Simulate a delay for the splash screen
//     await Future.delayed(Duration(seconds: 3));
//     // After the delay, navigate to the main screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(); // Show the splash screen
//   }
// }
