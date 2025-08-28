// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/tenants_provider.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/property/unit_setup.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/utilities/widgets.dart';

final List fetchedUnits = unitsForStep3;

Map? selectedUnit;

class DropdownWidget extends StatefulWidget {
  final List fetchedUnits;
  final ValueSetter<dynamic>? callback;

  const DropdownWidget({
    super.key,
    required this.fetchedUnits,
    this.callback,
  });

  @override
  DropdownWidgetState createState() {
    return DropdownWidgetState();
  }
}

class DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Map>(
        icon: const Icon(null),
        underline: Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.transparent, width: 0.0)),
          ),
        ),
        value: selectedUnit,
        onChanged: (Map? newValue) {
          setState(() {
            selectedUnit = newValue;
          });
          widget.callback!('date');
        },
        items: [
          DropdownMenuItem<Map<String, dynamic>>(
            value: null,
            child: Text(
              'Pick one house',
              style: MyTheme.darkTheme.textTheme.bodyLarge!
                  .copyWith(color: Colors.grey),
            ), // Placeholder text
          ),
          ...unitsForStep3.map<DropdownMenuItem<Map<String, dynamic>>>((unit) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: unit,
              child: Text(unit['house_number']),
            );
          }),
        ],
      ),
    );
  }
}

class TenantSetUp extends StatefulWidget {
  final int currentPageIndex;
  final PageController pageController;

  const TenantSetUp(
      {super.key,
      required this.currentPageIndex,
      required this.pageController});

  @override
  TenantSetUpState createState() {
    return TenantSetUpState();
  }
}

class TenantSetUpState extends State<TenantSetUp> {
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  String phoneNoInpt = '';
  String initialCountry = 'KE';

  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  void validateSignupInputs() {
    print('tapped');
    if (firstName.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter first name';
      });
    }
    print('tapped 11');
    if (lastName.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter last name';
      });
    }
    print('tapped 22');
    if (email.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter email address';
      });
    }
    print('tapped 33');
    if (phoneNoInpt == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
      });
    }
    print('<<<<<<<<<< selectedUnit >>>>>>>>>>');
    print(selectedUnit);
    if (selectedUnit == null) {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Select unit';
      });
    }
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
    final tenantsProvider =
        Provider.of<TenantsProvider>(context, listen: false);
    PageController pageController = widget.pageController;
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(
                Icons.person_2,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Tenant name'),
            ],
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
                    controller: firstName,
                    style: bodyText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'First Name',
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
                    controller: lastName,
                    style: bodyText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Last Name',
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
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.email,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Tenant email address'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (text) {
              validateSignupInputs();
            },
            controller: email,
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email address',
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
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.phone,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Phone Number'),
            ],
          ),
          const SizedBox(height: 10),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                phoneNoInpt = number.phoneNumber ?? '';
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
            textFieldController: phoneNo,
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
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.holiday_village,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Unit occupied by tenant'),
            ],
          ),
          const SizedBox(height: 10),
          DropdownWidget(
            fetchedUnits: unitsForStep3,
            callback: (val) {
              validateSignupInputs();
            },
          ),
          // const SizedBox(height: 24),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         margin: const EdgeInsets.only(right: 10),
          //         child: CustomRequestButton(
          //           buttonError: buttonError,
          //           buttonErrorMessage: buttonErrorMessage,
          //           url: null,
          //           method: 'POST',
          //           buttonText: 'Skip',
          //           body: const {},
          //           onSuccess: (res) {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: ((context) => const Dashboard()),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         margin: const EdgeInsets.only(left: 10),
          //         child: CustomRequestButton(
          //           cookie:
          //               'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
          //           authorization: 'Bearer ${userProvider.user?.token}',
          //           buttonError: buttonError,
          //           buttonErrorMessage: buttonErrorMessage,
          //           url: '/mobile/tenants/create',
          //           method: 'POST',
          //           buttonText: 'Add',
          //           body: {
          //             "property_id": propertyProvider.property?.id,
          //             "first_name": firstName.text,
          //             "last_name": lastName.text,
          //             "email": email.text,
          //             "phone": phoneNoInpt,
          //             "date_of_birth": "09/10/1998",
          //             "id_number": "32323232",
          //             "unit_id": selectedUnit?['id'],
          //             "contribution_id": 0
          //           },
          //           onSuccess: (res) {
          //             tenantsProvider.setGroupData({
          //               "property_id": propertyProvider.property?.id,
          //               "first_name": firstName.text,
          //               "last_name": lastName.text,
          //               "email": email.text,
          //               "phone": phoneNoInpt,
          //               "date_of_birth": "09/10/1998",
          //               "id_number": "32323232",
          //               "unit_id": selectedUnit?['id'],
          //               "contribution_id": 0
          //             });
          //             if (res['isSuccessful'] == true) {
          //               var serverStatus = res['data']['response']['status'];
          //               if (serverStatus == 1) {
          //                 showToast(
          //                   context,
          //                   'Success!',
          //                   'Tenant added successfully',
          //                   mintyGreen,
          //                 );
          //               } else {
          //                 var serverMsg = res['data']['response']['message'];
          //                 showToast(
          //                   context,
          //                   'Error!',
          //                   serverMsg,
          //                   Colors.red,
          //                 );
          //               }
          //             } else {
          //               showToast(
          //                 context,
          //                 'Error!',
          //                 res['error'] ?? 'Error adding tenant',
          //                 Colors.red,
          //               );
          //             }
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 24),
          CustomRequestButton(
            cookie:
                'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
            authorization: 'Bearer ${userProvider.user?.token}',
            buttonError: buttonError,
            buttonErrorMessage: buttonErrorMessage,
            url: '/mobile/tenants/create',
            method: 'POST',
            buttonText: 'Add',
            body: {
              "property_id": propertyProvider.property?.id,
              "first_name": firstName.text,
              "last_name": lastName.text,
              "email": email.text,
              "phone": phoneNoInpt,
              "date_of_birth": "09/10/1998",
              "id_number": "32323232",
              "unit_id": selectedUnit?['id'],
              "contribution_id": 0
            },
            onSuccess: (res) {
              tenantsProvider.setGroupData({
                "property_id": propertyProvider.property?.id,
                "first_name": firstName.text,
                "last_name": lastName.text,
                "email": email.text,
                "phone": phoneNoInpt,
                "date_of_birth": "09/10/1998",
                "id_number": "32323232",
                "unit_id": selectedUnit?['id'],
                "contribution_id": 0
              });
              if (res['isSuccessful'] == true) {
                var serverStatus = res['data']['response']['status'];
                if (serverStatus == 1) {
                  showToast(
                    'Success!',
                    'Tenant added successfully',
                    mintyGreen,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Dashboard()),
                    ),
                  );
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  var serverMsg = res['data']['response']['message'];
                  showToast(
                    'Error!',
                    serverMsg,
                    Colors.red,
                  );
                }
              } else {
                showToast(
                  'Error!',
                  res['error'] ?? 'Error adding tenant',
                  Colors.red,
                );
              }
            },
          ),
          // SizedBox(
          //   height: 48,
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: mintyGreen),
          //     onPressed: () {},
          //     child: const Text('Proceed'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
