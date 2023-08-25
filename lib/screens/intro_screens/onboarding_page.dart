// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/screens/authentication/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to XRent",
          body:
              "Manage your rental properties effortlessly. View all apartments, tenants, and send invoices seamlessly. Get started and make property management a breeze.",
          image: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/images/icons/logo-green.png',
                  width: 40,
                ),
              ),
              Text(
                'XRent',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              )
            ],
          ),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Stay Organized with XSoft",
          body:
              "Easily access information about your properties and tenants. Keep track of payments, agreements, and maintenance requests. Simplify your rental management journey.",
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/illustrations/organize.png'),
          ),
          decoration: pageDecoration(),
        ),
        PageViewModel(
          title: "Efficient Invoice Management!",
          body:
              "With XSoft, send monthly invoices to tenants effortlessly. Receive payments and keep track of outstanding amounts. Experience hassle-free rental management now!",
          image: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Image.asset('assets/illustrations/invoice.png'),
          ),
          decoration: pageDecoration(),
        ),
      ],
      onDone: () {
        // Handle the done action
      },
      showSkipButton: true,
      dotsFlex: 0,
      nextFlex: 0,
// skipOrBackFlex: 0,
      skip: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.transparent,
          child: Text('Skip', style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),

      next: Padding(
        padding: EdgeInsets.only(left: 120),
        child: Icon(
          Icons.arrow_forward,
          color: primaryDarkColor,
        ),
      ),
      done: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(left: 60),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Signup(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDarkColor,
            ),
            child: Text(
              'Get Started',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
      // doneAlign: Alignment.bottomRight,
      //dotsDecorator: centerDotsDecorator(),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: primaryDarkColor,
        color: primaryDarkColor.withOpacity(0.5), // Color of inactive dots
        spacing: const EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  // DotsDecorator centerDotsDecorator() {
  //   return DotsDecorator(
  //     activeColor: Color.fromRGBO(36, 77, 97, 1.0),
  //     activeSize: Size(20.0, 10.0),
  //     activeShape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(25.0),
  //     ),
  //     spacing: EdgeInsets.all(10.0), // Adjust the spacing between dots
  //     color: Color.fromRGBO(36, 77, 97, 0.3), // Color of inactive dots
  //     size: Size(10.0, 10.0),
  //     // Size of inactive dots
  //   );
  // }

  PageDecoration pageDecoration() {
    return PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.displayLarge!,
      bodyTextStyle: Theme.of(context).textTheme.bodyMedium!,
      imagePadding: EdgeInsets.fromLTRB(0, 60, 0, 60),
      contentMargin: EdgeInsets.symmetric(horizontal: 16.0),
      safeArea: 80,
      bodyFlex: 6,
      imageFlex: 6,
    );
  }
}
