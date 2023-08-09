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

class AnimatedRotationImage extends StatefulWidget {
  @override
  _AnimatedRotationImageState createState() => _AnimatedRotationImageState();
}

class _AnimatedRotationImageState extends State<AnimatedRotationImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.forward().whenComplete(() {
      _controller
          .dispose(); // Dispose of the controller after the initial rotation
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/rentals.png'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}