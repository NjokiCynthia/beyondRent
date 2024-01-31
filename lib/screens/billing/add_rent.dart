import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddRent extends StatefulWidget {
  const AddRent({super.key});

  @override
  _AddRentState createState() => _AddRentState();
}

class _AddRentState extends State<AddRent> {
  bool arrearsContributionBool = false;
  bool displayContributionBool = false;
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all fields';
  bool propertySaveLoading = false;

  String selectedValue = 'F1';

  final TextEditingController contributionNameController =
      TextEditingController();
  final TextEditingController contributionAmountController =
      TextEditingController();
  final TextEditingController blockNoController = TextEditingController();

  propertyInputValidator() async {
    if (contributionNameController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter the rent amount';
      });
      return false;
    } else if (contributionAmountController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter contribution amount';
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

  addRentBill() async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;

    final postData = {
      "property_id": propertyProvider.property?.id,
      "contribution_id": 0
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await apiClient.post(
        '/mobile/units/create',
        postData,
        headers: headers,
      );
      return response['response'];
    } catch (error) {
      // Handle the error
      return {"status": 7, "time": 1693485381, "message": "Error saving unit"};
    }
  }

  List<String> frequencyOptions = [
    'Daily',
    'Weekly',
    'Monthly',
    'Fortnightly',
    'Bimonthly',
    'Quarterly',
    'Biannually',
    'Annually',
  ];
  String? selectedFrequency;
  TextEditingController customFrequencyController = TextEditingController();

  Future<void> _showAddCustomFrequencyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            controller: customFrequencyController,
            decoration: const InputDecoration(
              labelText: 'Custom Frequency',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String customFrequencyText =
                    customFrequencyController.text.trim();
                if (customFrequencyText.isNotEmpty) {
                  int? customFrequency = int.tryParse(customFrequencyText);
                  if (customFrequency != null && customFrequency > 0) {
                    setState(() {
                      String formattedFrequency = 'Every $customFrequency';
                      frequencyOptions.add(formattedFrequency);
                      selectedFrequency = formattedFrequency;
                    });
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  String? selectedDayOfWeek;
  int? selectedDayOfMonth;
  String? selectedDayOfWeekMonthly;
  String? selectedDayOfWeekFortnightly;
  int? selectedWeekNumberFortnightly;
  String? selectedDayOfWeekBimonthly;
  int? selectedDayOfMonthBimonthly;
  String? selectedStartingMonthBimonthly;

  @override
  void initState() {
    super.initState();
    propertyInputValidator();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardAppbar(
                  backButton: true,
                  backButtonText: 'Add Rent Bill',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Rent Amount'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: contributionNameController,
                  style: bodyText,
                  onChanged: (value) {
                    propertyInputValidator();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'KES 20,000',
                    labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
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
                const SizedBox(height: 10),
                const Text(
                    'Select Preferred day of the week to invoice tenants.'),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: selectedDayOfWeek,
                  items: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
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
                      selectedDayOfWeek = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Select day of the week',
                    labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
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
                const Text('Select unit to set rent'),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: <String>[
                      'F1',
                      'F2',
                      'F3',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                    'Do you want to invoice previous rent during monthly invoicing?'),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: primaryDarkColor,
                      value: arrearsContributionBool,
                      onChanged: (bool? value) {
                        setState(() {
                          arrearsContributionBool = value!;
                        });
                      },
                    ),
                    Expanded(
                        child: Text(
                      'Disable arrears during invoicing',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomRequestButton(
                  cookie:
                      'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                  authorization: 'Bearer ${userProvider.user?.token}',
                  buttonError: buttonError,
                  buttonErrorMessage: buttonErrorMessage,
                  url: '/mobile/units/create',
                  method: 'POST',
                  buttonText: 'Save Changes',
                  body: {
                    "property_id": propertyProvider.property?.id,
                  },
                  onSuccess: (res) {
                    print(res);
                    // if (res['isSuccessful'] == false) {
                    //   return showToast(
                    //     context,
                    //     'Error!',
                    //     res['error'],
                    //     Colors.red,
                    //   );
                    // } else {

                    //   return showToast(
                    //     context,
                    //     'Success!',
                    //     'Rent Bill added successfully',
                    //     mintyGreen,
                    //   );
                    // }
                  },
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         margin: const EdgeInsets.only(left: 10),
                //         child: CustomRequestButton(
                //           url: null,
                //           method: 'POST',
                //           buttonText: 'Cancel',
                //           body: const {},
                //           onSuccess: (res) {
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child:
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
