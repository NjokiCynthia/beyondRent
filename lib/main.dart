import 'package:flutter/material.dart';
import 'package:x_rent/screens/intro_screens/onboarding_page.dart';
import 'package:x_rent/screens/intro_screens/splash.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/providers/property_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider<PropertyProvider>.value(
          value: PropertyProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'X-RENT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            titleLarge: AppTextStyles.headerBig,
            displayLarge: AppTextStyles.header,
            displayMedium: AppTextStyles.smallHeaderSlightlyBold,
            bodyMedium: AppTextStyles.normal,
            bodySmall: AppTextStyles.small,
            labelMedium: AppTextStyles.normalGreen,
            titleMedium: AppTextStyles.titleNormalBold,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
