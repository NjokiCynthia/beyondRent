import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/intro_screens/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-RENT',
      theme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/rentals.png'),
            const Text(
              'XSoft', // Replace with the desired text
            ),
          ],
        ),
        // Replace with your splash image asset
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: // You can change the transition type
      ),
      routes: {
        '/home': (_) => const HomePage(),
      },
    );
  }
}
