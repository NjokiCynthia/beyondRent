import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, // Set the color of the bottom border
                  width: 2.0, // Set the width of the bottom border
                ),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                // Set the border radius to zero
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.black,
                  selectionHandleColor: Colors.black,
                  selectionColor: Colors.black,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: controller,
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputBorder: InputBorder.none, // Remove the border
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
