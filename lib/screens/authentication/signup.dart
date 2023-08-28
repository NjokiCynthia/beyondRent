import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/authentication/login.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/property/property.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    margin: const EdgeInsets.only(bottom: 20),
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
                      const SizedBox(height: 20),
                      Text(
                        'Enter Your Name',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: TextFormField(
                                style: bodyText,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'First name',
                                  labelStyle: MyTheme
                                      .darkTheme.textTheme.bodyLarge!
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
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                style: bodyText,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Last name',
                                  labelStyle: MyTheme
                                      .darkTheme.textTheme.bodyLarge!
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Enter Phone Number',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
                        'Enter Property Name',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Property name',
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
                      const SizedBox(height: 20),
                      Text(
                        'Enter Property Location',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Property location',
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
                  const SizedBox(height: 20),
                  CustomRequestButton(
                    url: '/mobile/signup',
                    method: 'POST',
                    buttonText: 'Sign up',
                    body: const {
                      "request_id": "5v76g4v567344334355475cd4f",
                      "first_name": "Alice",
                      "last_name": "Kimani",
                      "identity": "0703802740",
                      "property_name": "Kirui Apartments",
                      "location": "Buru Age 3",
                      "password": "123456789"
                    },
                    onSuccess: (res) {
                      if (res['data']['response_code'] != '1') {
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
                          builder: ((context) => const Property()),
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
                builder: ((context) => const Dashboard()),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Demo Account',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const Login()),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login',
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
