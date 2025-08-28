import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddTenant extends StatefulWidget {
  final num? unitID;
  const AddTenant({super.key, this.unitID});

  @override
  AddTenantState createState() {
    return AddTenantState();
  }
}

class AddTenantState extends State<AddTenant> {
  bool tenantInfoLoading = true;
  Map tenantDetails = {};
  Map unitDetails = {};
  String? tenantName;

  // fetchTenantDetails() async {
  //   setState(() {
  //     tenantInfoLoading = true;
  //   });
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final tenantProvider = Provider.of<TenantsProvider>(context, listen: false);
  //   final token = userProvider.user?.token;

  //   final postData = {"id": widget.tenantID};

  //   final apiClient = ApiClient();
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   try {
  //     var response = await apiClient.post('/mobile/tenants/get', postData,
  //         headers: headers);
  //     if (response['response']['status'] == 1) {
  //       print('This is my tenant details>>>>>>>>>>>');
  //       print(response['response']['tenant']);

  //       setState(() {
  //         tenantDetails = response['response']['tenant'];
  //         tenantName = tenantDetails['first_name'];
  //         print(tenantDetails['first_name']);
  //       });
  //     }
  //   } catch (e) {
  //     print('e');
  //     print(e);
  //   }
  //   setState(() {
  //     tenantInfoLoading = false;
  //   });
  // }

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController identityDetails = TextEditingController();
  String phoneNoInpt = '';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all inputs';

  void validateSignupInputs() {
    if (firstName.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter first name';
      });
    }
    if (lastName.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter last name';
      });
    }
    if (email.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter email address';
      });
    }
    if (identityDetails.text == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter ID details';
      });
    }
    if (phoneNoInpt == '') {
      return setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter phone number';
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
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardAppbar(
                  backButton: true,
                  backButtonText: 'Add Tenant to Unit',
                ),
                const SizedBox(
                  height: 24,
                ),
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
                            labelText: 'Fist Name',
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
                  controller: email,
                  onChanged: (text) {
                    validateSignupInputs();
                  },
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
                      Icons.email,
                      color: primaryDarkColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Enter Tenant ID details'),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: identityDetails,
                  onChanged: (text) {
                    validateSignupInputs();
                  },
                  style: bodyText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'ID',
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
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CustomRequestButton(
                          url: null,
                          method: 'POST',
                          buttonText: 'Cancel',
                          body: const {},
                          onSuccess: (res) {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CustomRequestButton(
                          cookie:
                              'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=cm3qq525g91dr97u8114d8vr37hrut99; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                          authorization: 'Bearer ${userProvider.user?.token}',
                          buttonError: buttonError,
                          buttonErrorMessage: buttonErrorMessage,
                          url: '/mobile/tenants/create',
                          method: 'POST',
                          buttonText: 'Save',
                          body: {
                            "property_id": propertyProvider.property?.id,
                            "first_name": firstName.text,
                            "last_name": lastName.text,
                            "email": email.text,
                            "phone": phoneNoInpt,
                            "date_of_birth": "09/10/1998",
                            "id_number": identityDetails.text,
                            "unit_id": widget.unitID,
                            "contribution_id": 0
                          },
                          onSuccess: (res) {
                            if (res['isSuccessful'] == true) {
                              var serverStatus =
                                  res['data']['response']['status'];
                              if (serverStatus == 1) {
                                Navigator.pop(context, {
                                  'tenantName':
                                      '${firstName.text} ${lastName.text}',
                                });
                                showToast(
                                  'Success!',
                                  'Tenant added to unit successfully',
                                  mintyGreen,
                                );
                              } else {
                                var serverMsg =
                                    res['data']['response']['message'];
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
