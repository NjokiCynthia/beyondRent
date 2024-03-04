import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class UnitTypes extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;

  const UnitTypes(
      {Key? key, this.fromPage, this.currentPageIndex, this.pageController})
      : super(key: key);

  @override
  State<UnitTypes> createState() => _UnitTypesState();
}

enum AccountSettlementOption { yes, no }

enum Notification { yes, no }

enum EmailSms { yes, no }

class _UnitTypesState extends State<UnitTypes> {
  bool fetchUnitTypes = false;

  String? selectedFrequency;
  String? selectedDay;

  bool accountSettlement = true;
  bool accountSettlementNo = false;

  AccountSettlementOption? selectedOption;

  bool isEmailSelected = false;
  bool isSmsSelected = false;

  Notification? notification;

  EmailSms? notify;

  void initState() {
    super.initState();
    selectedDay = 'Every 5th';
    selectedFrequency = 'Monthly';
  }

  List<Map<String, dynamic>> unitTypes = [];

  Future<void> _showBottomSheet(BuildContext context) async {
    TextEditingController unitypecontroller = TextEditingController();
    TextEditingController amountController = TextEditingController();

    int getOption() {
      if (selectedOption == 'Yes') {
        return 1;
      } else if (selectedOption == 'No') {
        return 0;
      } else {
        return 1;
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
    bool buttonError = true;
    String buttonErrorMessage = 'Enter all fields';
    propertyInputValidator() async {
      if (unitypecontroller.text == '') {
        setState(() {
          buttonError = true;
          buttonErrorMessage = 'Enter unit type name';
        });
        return false;
      } else if (amountController.text == '') {
        setState(() {
          buttonError = true;
          buttonErrorMessage = 'Enter unit amount';
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

    int? _getDayNumber(String value) {
      final RegExp number = RegExp(r'[0-9]+');
      final RegExp ordinal = RegExp(r'st|nd|rd|th');
      final numberMatch = number.firstMatch(value)?.group(0);
      if (numberMatch != null) {
        final isOrdinalMatch = ordinal.hasMatch(value);
        final int day = int.parse(numberMatch);
        return isOrdinalMatch ? day : null;
      }
      return null;
    }

    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
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
                        Text('Enter unit type'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: bodyText,
                      onChanged: (value) {
                        setState(() {
                          propertyInputValidator();
                        });
                      },
                      controller: unitypecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Unit type',
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
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          propertyInputValidator();
                        });
                      },
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
                    const SizedBox(
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
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
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
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
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
                            items: [
                              'Monthly',
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
                          const SizedBox(
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Do you wish to send notifications to tenants?',
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
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
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
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                      visible: notification == Notification.yes,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Do you wish to send SMS or email notifications to tenants?',
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
                                  Checkbox(
                                    value: isSmsSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isSmsSelected = value!;
                                      });
                                    },
                                    activeColor: primaryDarkColor,
                                  ),
                                  Text(
                                    "Email",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isEmailSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isEmailSelected = value!;
                                      });
                                    },
                                    activeColor: primaryDarkColor,
                                  ),
                                  Text(
                                    "SMS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomRequestButton(
                        cookie:
                            'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                        authorization: 'Bearer ${userProvider.user?.token}',
                        buttonError: buttonError,
                        buttonErrorMessage: buttonErrorMessage,
                        url: '/mobile/unit_types/create',
                        method: 'POST',
                        buttonText: 'Proceed',
                        body: {
                          "name": unitypecontroller.text,
                          "amount": amountController.text,
                          "category": 2,
                          "type": 1,
                          "regular_invoicing_active": getOption().toString(),
                          "contribution_frequency": 1,
                          "month_day_monthly": _getDayNumber(selectedDay!) ?? 1,
                          "start_month_multiple": 1,
                          "sms_notification_email_notification":
                              isSmsSelected && isEmailSelected ? 1 : 0,
                          "sms_notifications_enabled": isSmsSelected ? 1 : 0,
                          "email_notifications_enabled":
                              isEmailSelected ? 1 : 0,
                        },
                        onSuccess: (res) {
                          print('here it is');
                          print(getOption().toString());
                          if (!buttonError) {
                            if (res['isSuccessful'] == true) {
                              print('here is my response');
                              print(res);
                              showToast(
                                context,
                                'Success!',
                                'Unit Type successfully created',
                                mintyGreen,
                              );
                            } else {
                              showToast(
                                context,
                                'Error!',
                                res['message'],
                                Colors.red,
                              );
                            }
                          } else {
                            showToast(
                              context,
                              'Error!',
                              "Please enter all fields",
                              Colors.red,
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController!;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: unitTypes.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> unitType = unitTypes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildUnitListTile(
                    unitType['type'],
                    unitType['Price'],
                  ),
                );
              },
            ),
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
                child: const Text('Proceed')),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (BuildContext innerContext) {
          return Align(
            alignment: const Alignment(1.0, 0.85),
            child: FloatingActionButton(
              backgroundColor: primaryDarkColor,
              onPressed: () {
                _showBottomSheet(context);
              },
              tooltip: 'Open Bottom Sheet',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  ListTile buildUnitListTile(String unit, String price) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
        side: BorderSide(color: primaryDarkColor.withOpacity(0.1)),
      ),
      leading: Container(
        decoration: BoxDecoration(
          color: primaryDarkColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.check,
          color: primaryDarkColor,
        ),
      ),
      title: Text('Unit type: '),
      subtitle: Text('Amount: KES '),
    );
  }
}
