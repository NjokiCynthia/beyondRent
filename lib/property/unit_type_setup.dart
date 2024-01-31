import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';

class UnitTypes extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;
  const UnitTypes(
      {super.key, this.fromPage, this.currentPageIndex, this.pageController});

  @override
  State<UnitTypes> createState() => _UnitTypesState();
}

enum AccountSettlementOption { yes, no }

enum Notification { yes, no }

class _UnitTypesState extends State<UnitTypes> {
  String? selectedFrequency;
  String? selectedDay;

  bool accountSettlement = true;
  bool accountSettlementNo = false;

  AccountSettlementOption? selectedOption;
  bool sms = true;
  bool email = false;

  Notification? notification;

  void initState() {
    super.initState();
    selectedDay = 'Every 5th';
    selectedFrequency = 'Monthly';
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
    PageController pageController = widget.pageController!;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Icon(
                  Icons.maps_home_work_outlined,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Select unit type'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: bodyText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Price of the unit',
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
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.money_off_sharp,
                  color: primaryDarkColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Enter amount for the unit type'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: bodyText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Price of the unit',
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
              height: 10,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Do you wish to enable automatic tenant invoicing?',
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: AccountSettlementOption.yes,
                      groupValue: selectedOption,
                      onChanged: (AccountSettlementOption? value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                      activeColor: primaryDarkColor,
                    ),
                    Text(
                      "Yes",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: AccountSettlementOption.no,
                      groupValue: selectedOption,
                      onChanged: (AccountSettlementOption? value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                      activeColor: primaryDarkColor,
                    ),
                    Text(
                      "No",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedOption == AccountSettlementOption.yes,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Preferred invoice frequency.'),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedFrequency ?? 'Monthly',
                    // style: MyTheme.darkTheme.textTheme.bodyLarge!
                    //     .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    items: [
                      //'Weekly',
                      'Monthly',
                      // 'Quarterly',
                      // 'Annually',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedFrequency = value!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Select frequency',
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
                    height: 10,
                  ),
                  const Text('Preferred invoice date.'),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedDay ?? 'Every 5th',
                    items: [
                      'Every 1st',
                      'Every 2nd',
                      'Every 3rd',
                      'Every 4th',
                      'Every 5th',
                      'Every 6th',
                      'Every 7th',
                      'Every 8th',
                      'Every 9th',
                      'Every 10th',
                      'Every 11th',
                      'Every 12th',
                      'Every 13th',
                      'Every 14th',
                      'Every 15th',
                      'Every 16th',
                      'Every 17th',
                      'Every 18th',
                      'Every 19th',
                      'Every 20th',
                      'Every 21st',
                      'Every 22nd',
                      'Every 23rd',
                      'Every 24th',
                      'Every 25th',
                      'Every 26th',
                      'Every 27th',
                      'Every 28th',
                      'Every 29th',
                      'Every 30th',
                      'Every 31st',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDay = value!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Select day',
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
            ),
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Do you wish to send sms or email to tenants?',
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: Notification.yes,
                      groupValue: notification,
                      onChanged: (Notification? value) {
                        setState(() {
                          notification = value;
                        });
                      },
                      activeColor: primaryDarkColor,
                    ),
                    Text(
                      "Yes",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: Notification.no,
                      groupValue: notification,
                      onChanged: (Notification? value) {
                        setState(() {
                          notification = value;
                        });
                      },
                      activeColor: primaryDarkColor,
                    ),
                    Text(
                      "No",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text('Confirm')),
            ),
          ],
        ),
      )),
    );
  }
}
