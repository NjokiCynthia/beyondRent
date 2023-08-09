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
      theme: MyTheme.darkTheme.copyWith(
        primaryColor:
            MyTheme.primaryColor, // Use your primary color from the theme
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: AnimatedSplashScreen(
        duration: 113000,
        splash:
            AnimatedScaleImage(), // Use the custom widget for animated image
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
      routes: {
        '/home': (_) => const HomePage(),
      },
    );
  }
}

class AnimatedScaleImage extends StatefulWidget {
  @override
  _AnimatedScaleImageState createState() => _AnimatedScaleImageState();
}

class _AnimatedScaleImageState extends State<AnimatedScaleImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width *
            1.0, // Adjust the width as needed
        height: MediaQuery.of(context).size.width *
            1.0, // Adjust the height as needed
        child: Image.asset('assets/images/rentals.png'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
