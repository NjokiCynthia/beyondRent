import 'package:flutter/material.dart';
import 'package:x_rent/screens/intro_screens/onboarding_page.dart';
import 'package:x_rent/screens/intro_screens/splash.dart';
import 'package:x_rent/utilities/constants.dart';

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
      home: SplashScreen(), // Use the SplashScreen widget as the home
      routes: {
        '/home': (_) => const HomePage(),
      },
    );
  }
}
