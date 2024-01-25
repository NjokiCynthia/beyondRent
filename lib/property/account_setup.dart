import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/widgets.dart';

import '../providers/property_provider.dart';

class AccountSetup extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;
  const AccountSetup(
      {super.key, this.fromPage, this.currentPageIndex, this.pageController});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  String? selectedValue;
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankBranchController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all fields';
  accountInputValidator() async {
    if (bankNameController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter bank name';
      });
      return false;
    } else if (bankBranchController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter bank location';
      });
      return false;
    } else if (accountNameController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter account name';
      });
      return false;
    } else if (accountNumberController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter the account number';
      });
      return false;
    } else {
      setState(() {
        buttonError = false;
        buttonErrorMessage = 'Enter all fields';
      });
      return true;
    }
  }

  final propertyProvider = Provider.of<PropertyProvider>(
    context,
    listen: false,
  );
  final userProvider = Provider.of<UserProvider>(
    context,
    listen: false,
  );
  PageController pageController = widget.pageController!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select bank'),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Select bank',
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
                'Equity',
                'KCB',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select bank branch.'),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Select branch',
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
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Icon(
                  Icons.person,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Enter account name'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                accountInputValidator();
              },
              controller: accountNameController,
              style: bodyText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Account name',
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
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Icon(
                  Icons.numbers,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Enter Account number'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                accountInputValidator();
              },
              controller: accountNameController,
              style: bodyText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Account number',
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
            SizedBox(
              height: 30,
            ),
            const SizedBox(height: 20),
            CustomRequestButton(
              cookie:
                  'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
              authorization: 'Bearer ${userProvider.user?.token}',
              buttonError: buttonError,
              buttonErrorMessage: buttonErrorMessage,
              url: '/mobile/units/batch_create',
              method: 'POST',
              buttonText: 'Proceed',
              body: {
                "property_id": propertyProvider.property?.id,
                "house_numbers": unitsToSend,
                "house_types": const [1, 2, 3, 4],
                "blocks": const [1, 1, 1, 2],
                "floor": const [1, 2, 3, 4, 5, 6],
                "tenant_id": const [0, 0, 0, 0],
                "contribution_id": const [0, 0, 0, 0]
              },
              onSuccess: (res) {
                if (!buttonError) {
                  print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
                  print(res);
                  if (res['isSuccessful'] == true) {
                    var response = res['data']['response']['status'];
                    if (response == 1) {
                      setState(() {
                        unitsForStep3 = res['data']['response']['units'];
                      });
                      showToast(
                        context,
                        'Success!',
                        'Unit added successfully',
                        mintyGreen,
                      );

                      pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      // Future.delayed(const Duration(seconds: 2), () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: ((context) => const Dashboard()),
                      //     ),
                      //   );
                      // });
                      // pageController.animateToPage(
                      //   0,
                      //   duration: const Duration(milliseconds: 300),
                      //   curve: Curves.easeInOut,
                      // );
                    } else {
                      showToast(
                        context,
                        'Error!',
                        res['data']['response']['message'],
                        Colors.red,
                      );
                    }
                  } else {
                    showToast(
                      context,
                      'Error!',
                      "Error saving unit",
                      Colors.red,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
