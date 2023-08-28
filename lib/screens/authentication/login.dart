import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/property_list.dart';
import 'package:x_rent/screens/authentication/signup.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/widgets.dart';

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
        body: Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Row(
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
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Phone Number',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {},
                        onInputValidated: (bool value) {},
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        textStyle: bodyText,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textAlignVertical: TextAlignVertical.top,
                        textFieldController: controller,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        maxLength: 10,
                        inputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        inputDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Phone number',
                          labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {},
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Enter Password',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter password',
                          labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomRequestButton(
                    url: '/mobile/login',
                    method: 'POST',
                    buttonText: 'Log in',
                    body: const {
                      "phone": "0766444600",
                      "password": "123456789",
                      "remember": true
                    },
                    onSuccess: (res) {
                      if (res['data']['response']['status'] != 1) {
                        return showToast(
                          context,
                          'Error!',
                          res['data']['message'] ??
                              'Error, please try again later.',
                          Colors.red,
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const Dashboard()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const Signup()),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Signup',
                    style: TextStyle(color: mintyGreen),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}
