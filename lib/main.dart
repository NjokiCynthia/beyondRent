import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:x_rent/utilities/constants.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.header,
          displayMedium: AppTextStyles.smallHeaderSlightlyBold,
          bodyMedium: AppTextStyles.normal,
          bodySmall: AppTextStyles.small,
          labelMedium: AppTextStyles.normalGreen,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/rentals.png'),
            const Text(
              'XSoft',
            ),
          ],
        ),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
      routes: {
        '/home': (_) => const HomePage(),
      },
    );
  }
}
