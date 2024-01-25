import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/models/bank_list.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
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

  String selectedBankAccount = 'Select Bank';
  String selectedBranchValue = '';
  String? selectedBankValue;
  bool fetchingBanks = false;
  List<String> bankModelsDropdownList = [];
  List<Banks> bankModels = [];
  Future<void> _fetchBanks(BuildContext context) async {
    print('I am here to fetch all banks');
    try {
      setState(() {
        fetchingBanks = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user?.token;

      final propertyProvider = Provider.of<PropertyProvider>(
        context,
        listen: false,
      );

      final postData = {
        'property_id': propertyProvider.property?.id.toString() ?? '',
      };

      final apiClient = ApiClient();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await apiClient.post(
        '/mobile/banks/get_bank_options',
        postData,
        headers: headers,
      );

      print('Banks Response: $response');

      setState(() {
        bankModels = [];
        bankModelsDropdownList = [];
      });

      if (response['response']['status'] == 1 &&
          response['response']['banks'] != null) {
        final banksList = BanksList.fromJson(response['response']);

        setState(() {
          bankModels = banksList.banks ?? [];
          selectedBankAccount = '${bankModels[0].name}';
          bankModelsDropdownList =
              bankModels.map((bank) => bank.name ?? '').toList();
        });
      } else {
        print('No or invalid banks found in the response');
        // Handle the case when 'status' is not 1 or 'banks' is null
      }
    } catch (error) {
      print('Error fetching banks: $error');
      // Handle the error
    } finally {
      setState(() {
        fetchingBanks = false;
      });
    }
  }

  List<String> bankBranchesDropdownList = [];

  Future<void> _fetchBankBranches(BuildContext context, String bankId) async {
    try {
      // Assuming you have the user token and property id
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user?.token;

      final propertyProvider = Provider.of<PropertyProvider>(
        context,
        listen: false,
      );

      final postData = {
        'property_id': propertyProvider.property?.id.toString() ?? '',
        'bank_id': bankId,
      };

      final apiClient = ApiClient();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await apiClient.post(
        '/mobile/bank_branches/get_bank_branches_options',
        postData,
        headers: headers,
      );

      print('Bank Branches Response: $response');

      setState(() {
        bankBranchesDropdownList = [];
      });

      if (response['response']['status'] == 1 &&
          response['response']['bank_branches'] != null) {
        final bankBranches = response['response']['bank_branches'];

        setState(() {
          bankBranchesDropdownList = bankBranches
              .map<String>((branch) => branch['name'].toString())
              .toList();
          selectedBranchValue = bankBranchesDropdownList.isNotEmpty
              ? bankBranchesDropdownList[0]
              : '';
        });
      } else {
        print('No or invalid bank branches found in the response');
        // Handle the case when 'status' is not 1 or 'bank_branches' is null
      }
    } catch (error) {
      print('Error fetching bank branches: $error');
      // Handle the error
    }
  }

  Map<String, List<Map<String, dynamic>>> bankBranches = {};

  @override
  void initState() {
    super.initState();
    _fetchBanks(context);
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
                hintText: 'Select Bank',
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
              value: selectedBankValue,
              items: bankModelsDropdownList.map((bank) {
                return DropdownMenuItem<String>(
                  value: bank,
                  child: Text(bank),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBankValue = value;
                });
              },
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
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select Branch',
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
              value: selectedBranchValue,
              items: selectedBankValue != 'Select Bank' &&
                      bankBranches.containsKey(selectedBankValue)
                  ? [
                      DropdownMenuItem<String>(
                        value: 'Select Branch',
                        child: Text('Select Branch'),
                      ),
                      ...(bankBranches[selectedBankValue]
                              as List<Map<String, dynamic>>)
                          .map<DropdownMenuItem<String>>((branch) {
                        return DropdownMenuItem<String>(
                          value: branch['name'].toString(),
                          child: Text(branch['name'].toString()),
                        );
                      }).toList()
                    ]
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedBranchValue = value!;
                });
              },
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
              //url: '/mobile/units/batch_create',
              method: 'POST',
              buttonText: 'Proceed',
              body: {},
              onSuccess: (res) {
                if (!buttonError) {
                  print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
                  print(res);
                  if (res['isSuccessful'] == true) {
                    var response = res['data']['response']['status'];
                    if (response == 1) {
                      showToast(
                        context,
                        'Success!',
                        'Account details added successfully',
                        mintyGreen,
                      );

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const Dashboard()),
                          ),
                        );
                      });
                      pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
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
