import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/property_list.dart';
import 'package:x_rent/screens/authentication/signup.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final bool? justSignedup;
  const Login({super.key, this.justSignedup});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String phoneNoController = '';
  String finalPassword = '';

  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  bool _obscurePassword = true;

  checkIfFreshSignup() {
    if (widget.justSignedup == true) {
      showToast(
        context,
        'Success',
        'You have Signed up successfully. Use your details to log in.',
        Colors.green,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      checkIfFreshSignup();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                            'assets/images/icons/logo3.png',
                            width: 40,
                          ),
                        ),
                        Text(
                          'Kodi',
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
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            phoneNoController = number.phoneNumber ?? '';
                          });
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
                        textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
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
                        obscureText: _obscurePassword,
                        style: bodyText,
                        controller: passwordController,
                        onChanged: (value) {
                          setState(() {
                            finalPassword = value;
                          });
                        },
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
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
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
                    body: {
                      "phone": phoneNoController,
                      "password": finalPassword,
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
                      var userData = res['data']['response']['user'];
                      var accessToken = res['data']['response']['access_token'];
                      final userProvider = context.read<UserProvider>();
                      userProvider.setUser(
                        User(
                          firstName: userData['first_name'],
                          lastName: userData['last_name'],
                          phone: userData['phone'],
                          email: userData['email'],
                          id: userData['id'],
                          token: accessToken,
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const PropertyList()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            //    SizedBox(
            //   height: 40,
            //  ),
            // Container(
            //  margin: const EdgeInsets.only(left: 20, right: 20),
            //  child: CustomRequestButton(
            //   url: '/mobile/login',
            //   method: 'POST',
            //  buttonText: 'Demo Account',
            // body: const {
            // "phone": '254721882678',
            // "password": '00000000',
            // "remember": true
            // },
            //  onSuccess: (res) {
            //   if (res['data']['response']['status'] != 1) {
            //   return showToast(
            //    context,
            //   'Error!',
            //   res['data']['message'] ?? 'Error, please try again later.',
            //  Colors.red,
            //  );
            // }
            // var userData = res['data']['response']['user'];
            // var accessToken = res['data']['response']['access_token'];
            // final userProvider = context.read<UserProvider>();
            // userProvider.setUser(
            //  User(
            //  firstName: userData['first_name'],
            //   lastName: userData['last_name'],
            //   phone: userData['phone'],
            //  email: userData['email'],
            //  id: userData['id'],
            //   token: accessToken,
            // ),
            //  );
            //  Navigator.push(
            //   context,
            //  MaterialPageRoute(
            //   builder: ((context) => const PropertyList()),
            //     ),
            //   );
            // },
            // ),
            // ),
            const SizedBox(height: 20),
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
        ),
      ),
    ));
  }
}
