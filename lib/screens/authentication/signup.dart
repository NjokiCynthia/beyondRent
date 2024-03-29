import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/authentication/login.dart';
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

  String? selectedValue;

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
          formatInput: false,
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
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Select role',
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
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: <String>[
            'Agent',
            'Landlord',
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/images/icons/logo.png',
                          width: 250,
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

              // ),
              const SizedBox(
                height: 30,
              ),
              // Container(
              //   margin: const EdgeInsets.only(left: 20, right: 20),
              //   child: CustomOutlinedButton(
              //     url: '/mobile/login',
              //     method: 'POST',
              //     buttonText: 'Demo Account',
              //     body: const {
              //       "phone": '2547398712777',
              //       "password": 'innovations1234',
              //       "remember": true
              //     },
              //     onSuccess: (res) {
              //       if (res['data']['response']['status'] != 1) {
              //         return showToast(
              //           context,
              //           'Error!',
              //           res['data']['message'] ??
              //               'Error, please try again later.',
              //           Colors.red,
              //         );
              //       }
              //       var userData = res['data']['response']['user'];
              //       var accessToken = res['data']['response']['access_token'];
              //       final userProvider = context.read<UserProvider>();
              //       userProvider.setUser(
              //         User(
              //           firstName: userData['first_name'],
              //           lastName: userData['last_name'],
              //           phone: userData['phone'],
              //           email: userData['email'],
              //           id: userData['id'],
              //           token: accessToken,
              //         ),
              //       );
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: ((context) => const PropertyList()),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 20),
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
        ),
      ),
    );
  }
}
