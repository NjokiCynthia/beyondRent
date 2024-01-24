import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SupplementaryBill extends StatefulWidget {
  const SupplementaryBill({super.key});

  @override
  _SupplementaryBillState createState() => _SupplementaryBillState();
}

class _SupplementaryBillState extends State<SupplementaryBill> {
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

  @override
  void initState() {
    super.initState();
    propertyInputValidator();
  }

  String billName = '';
  String billOption = 'Varying';
  String amount = '';
  List<Map<String, dynamic>> bills = [];
  Future<void> _showAddUtilitiesBottomSheet(BuildContext context) async {
    final TextEditingController billNameController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss the keyboard
          },
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Enter the bill name'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: billNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: ' eg, water',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
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
                        onChanged: (value) {
                          setState(() {
                            billName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text('Select the Bill Option: '),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Select option',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
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
                        value: billOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            billOption = newValue!;
                          });
                        },
                        items: <String>['Varying', 'Fixed']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      if (billOption == 'Varying')
                        const Text('Specify the bill amount'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter bill amount',
                          labelStyle:
                              MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
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
                        onChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: primaryDarkColor),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Check the values and act accordingly
                              print(
                                  'Bill Name: $billName, Bill Option: $billOption');

                              if (billOption == 'Varying') {
                                print('Amount: $amount');
                              }

                              // Add the bill to the list
                              setState(() {
                                bills.add({
                                  'billName': billName,
                                  'billOption': billOption,
                                  'amount': amount,
                                });
                              });

                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryDarkColor),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const DashboardAppbar(
                        backButton: true,
                        backButtonText: 'Add Supplementary Bills',
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (bills.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: bills.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> bill = bills[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: buildUtilityListTile(
                                    bill['billName'],
                                    bill['billOption'],
                                    bill['amount'],
                                  ),
                                );
                              },
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/illustrations/transaction.png'),
                                    const Text(
                                      'No supplementary bills at the moment.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () => _showAddUtilitiesBottomSheet(context),

                            //onTap: _showAddUtilitiesBottomSheet(context),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: primaryDarkColor,
                                ),
                                Text(
                                  'Add utilities',
                                  style: TextStyle(color: primaryDarkColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomRequestButton(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildUtilityListTile(
      String billName, String billOption, String amount) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust the value as needed
        side: BorderSide(color: primaryDarkColor.withOpacity(0.1)),
      ),
      leading: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(13, 201, 150, 1).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.check,
          color: Color.fromRGBO(13, 201, 150, 1),
        ),
      ),
      title: Text('Utility: $billName'),
      subtitle: billOption == 'Varying' ? Text('Amount: KES $amount') : null,
    );
  }
}
