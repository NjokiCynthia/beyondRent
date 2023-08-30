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
  final TextEditingController first_name_ctrl = TextEditingController();
  final TextEditingController last_name_ctrl = TextEditingController();
  final TextEditingController phone_number_ctrl = TextEditingController();
  final TextEditingController property_name_ctrl = TextEditingController();
  final TextEditingController property_location_ctrl = TextEditingController();
  final TextEditingController password_ctrl = TextEditingController();
  String phone_number_inpt = '';
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';
  bool _obscurePassword = true;

  validateSignupInputs() {
    print('phone_number_inpt');
    print(phone_number_inpt);
    if (first_name_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter first name';
      });
    }
    if (last_name_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter last name';
      });
    }

    if (phone_number_inpt == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
    }
    if (password_ctrl.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter password';
      });
    }
    if (password_ctrl.text.length < 8) {
      return setState(() {
        buttonError = true;
        buttonErrorMessage =
            'Minimum password length must be at least 8 characters';
      });
    }
    print('buttonError');
    print(buttonError);
    return setState(() {
      buttonError = false;
      buttonErrorMessage = 'Enter sending request';
    });
  }

  @override
  void initState() {
    super.initState();
    validateSignupInputs();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Column(
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
                  onChanged: (text) {
                    validateSignupInputs();
                  },
                  controller: first_name_ctrl,
                  keyboardType: TextInputType.name,
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'First name',
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
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  onChanged: (text) {
                    validateSignupInputs();
                  },
                  controller: last_name_ctrl,
                  style: bodyText,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Last name',
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
          onInputChanged: (PhoneNumber number) {
            setState(() {
              phone_number_inpt = number.phoneNumber ?? '';
            });
            validateSignupInputs();
          },
          onInputValidated: (bool value) {},
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            setSelectorButtonAsPrefixIcon: true,
            leadingPadding: 10,
          ),
          textStyle: bodyText,
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: number,
          textAlignVertical: TextAlignVertical.top,
          textFieldController: phone_number_ctrl,
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
        // Text(
        //   'Enter Property Name',
        //   style: Theme.of(context).textTheme.bodySmall,
        // ),
        // const SizedBox(height: 10),
        // TextFormField(
        //   onChanged: (text) {
        //     validateSignupInputs();
        //   },
        //   keyboardType: TextInputType.text,
        //   controller: property_name_ctrl,
        //   style: bodyText,
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: Colors.white,
        //     labelText: 'Property name',
        //     labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
        //         .copyWith(color: Colors.grey),
        //     border: OutlineInputBorder(
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //         width: 1.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: Colors.grey.shade300,
        //         width: 2.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //         width: 1.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        // Text(
        //   'Enter Property Location',
        //   style: Theme.of(context).textTheme.bodySmall,
        // ),
        // const SizedBox(height: 10),
        // TextFormField(
        //   onChanged: (text) {
        //     validateSignupInputs();
        //   },
        //   keyboardType: TextInputType.text,
        //   controller: property_location_ctrl,
        //   style: bodyText,
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: Colors.white,
        //     labelText: 'Property location',
        //     labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
        //         .copyWith(color: Colors.grey),
        //     border: OutlineInputBorder(
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //         width: 1.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(
        //         color: Colors.grey.shade300,
        //         width: 2.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderSide: const BorderSide(
        //         color: Colors.grey,
        //         width: 1.0,
        //       ),
        //       borderRadius: BorderRadius.circular(8.0),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        Text(
          'Enter Password',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        TextFormField(
          onChanged: (text) {
            validateSignupInputs();
          },
          keyboardType: TextInputType.text,
          //obscureText: true,
          obscureText: _obscurePassword,
          style: bodyText,
          controller: password_ctrl,
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
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
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
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
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
                    form,
                    const SizedBox(height: 20),
                    CustomRequestButton(
                      buttonError: buttonError,
                      buttonErrorMessage: buttonErrorMessage,
                      url: '/mobile/signup',
                      method: 'POST',
                      buttonText: 'Sign up',
                      // body: {
                      //   "request_id": "5v76g4v567344334355475cd4f",
                      //   "first_name": first_name_ctrl.text,
                      //   "last_name": last_name_ctrl.text,
                      //   "identity": phone_number_inpt,
                      //   "property_name": "Kirui Apartments",
                      //   "location": "Buru Age 3",
                      //   "password": password_ctrl.text
                      // },
                      body: {
                        "request_id": "5v76g4v567344334355475cd4f",
                        "first_name": first_name_ctrl.text,
                        "last_name": last_name_ctrl.text,
                        "identity": phone_number_inpt,
                        "property_name": "Kirui Apartments",
                        "location": "Buru Age 3",
                        "password": password_ctrl.text
                      },
                      onSuccess: (res) {
                        print('<<<<<<<<<<<< res >>>>>>>>>>>>>');
                        print(password_ctrl.text.runtimeType);
                        print(res);
                        if (res['isSuccessful'] == false) {
                          return showToast(
                            context,
                            'Error!',
                            res['error'] ?? 'Error, please try again later.',
                            Colors.red,
                          );
                        }
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
                            builder: ((context) =>
                                const Login(justSignedup: true)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) => const Dashboard()),
          //       ),
          //     );
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          //     margin: const EdgeInsets.only(bottom: 50),
          //     decoration: BoxDecoration(
          //       color: mintyGreen,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Text(
          //       'Demo Account',
          //       style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w600,
          //           fontSize: 15),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Login(justSignedup: false)),
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
      ),
    );
  }
}
