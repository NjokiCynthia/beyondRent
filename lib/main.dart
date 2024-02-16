import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_rent/providers/tenant_list.dart';
import 'package:x_rent/providers/tenants_provider.dart';
import 'package:x_rent/screens/authentication/login.dart';
import 'package:x_rent/screens/intro_screens/onboarding_page.dart';
import 'package:x_rent/screens/intro_screens/splash.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/providers/property_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider<PropertyProvider>.value(
          value: PropertyProvider(),
        ),
        ChangeNotifierProvider<PropertyListProvider>.value(
          value: PropertyListProvider(),
        ),
        ChangeNotifierProvider<TenantsProvider>.value(
          value: TenantsProvider(),
        ),
        ChangeNotifierProvider<TenantListProvider>.value(
          value: TenantListProvider(),
        ),
      ],
      child: MyApp(isFirstLaunch: isFirstLaunch),
      //const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

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
        home: isFirstLaunch ? const SplashScreen() : const Login(),
        //const SplashScreen(),
        routes: {
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
