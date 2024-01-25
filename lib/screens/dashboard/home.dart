import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/models/bank_model.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/transactions.dart';
import 'package:x_rent/screens/dashboard/withdrawals/list_withdrawals.dart';
import 'package:x_rent/screens/dashboard/withdrawals/withdrawals.dart';
import 'package:x_rent/screens/intro_screens/onboarding_page.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/screens/dashboard/propertyDetails.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/screens/dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool propertiesLoading = true;
  List userPropertyList = [];

  fetchPropertiesByUser(context) async {
    print('I am here to fetch my properties');
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final userPropertyListProvider = Provider.of<PropertyListProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;
    final userID = userProvider.user?.id;

    final postData = {
      'user_id': userID,
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await apiClient
        .post('/mobile/get_property_by_user', postData, headers: headers)
        .then((response) {
      print('Here is my properties');
      print(response);
      var responseStatus = response['response']['status'];
      if (responseStatus == 0) {
        setState(() {
          userPropertyList = response['response']['properties'];
        });
        for (var propertyData in userPropertyList) {
          Property property = Property(
            propertyName: propertyData['name'],
            propertyLocation: '',
            id: int.parse(propertyData['id']),
          );
          userPropertyListProvider.addProperty(property);
        }
      }
      setState(() {
        propertiesLoading = false;
      });
      return response;
    }).catchError((error) {
      // Handle the error
      setState(() {
        propertiesLoading = false;
      });
      return {
        "response": {
          "status": 4,
          "message": "Property not found",
          "time": 1693471190
        }
      };
    });
  }

  bool transactionListLoaded = false;
  List<Map<String, dynamic>> transactionsList = [];

  fetchTransactionsList() async {
    print('I am here to load transactions paid');
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;

    final postData = {"property_id": propertyProvider.property?.id};
    print('This is my property id while fetching transactions');
    print(propertyProvider.property?.id);

    // postData["property_id"] = propertyProvider.property?.id;

    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await apiClient.post(
        '/mobile/deposits/get_deposits_list',
        postData,
        headers: headers,
      );

      if (response != null && response['response'] != null) {
        var responseStatus = response['response']['status'];

        if (responseStatus == 1) {
          var deposits = response['response']['deposits'];
          if (deposits != null && deposits is List) {
            print('These are my transaction details below here >>>>>>>>>>>');
            print(deposits);

            setState(() {
              transactionsList = deposits.cast<Map<String, dynamic>>();
            });
          }
        }
      }
    } catch (e) {
      print('Error');
      print(e);
    }

    setState(() {
      transactionListLoaded = true;
    });
  }

  // String selectedBank = 'Select Bank';
  // String selectedBranch = '';

  // // List<String> banks = ['Select Bank', 'KCB', 'Equity', 'Cooperative Bank'];
  Map<String, List<String>> bankBranches = {
    'KCB': ['Select Branch', 'Branch1', 'Branch2', 'Branch3'],
    'Equity': ['Select Branch', 'BranchA', 'BranchB', 'BranchC'],
    'Cooperative Bank': ['Select Branch', 'BranchX', 'BranchY', 'BranchZ'],
  };
  String selectedBankAccount = 'Select Bank';
  String selectedBranchValue = '';
  String? selectedBankValue;
  bool fetchingBanks = false;
  List<String> bankModelsDropdownList = [];
  List<Banks> bankModels = [];
  Future<void> _fetchBanks(BuildContext context) async {
    print('I am here to fetch banks');
    try {
      setState(() {
        fetchingBanks = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final token = userProvider.user?.token;
      final userId = userProvider.user?.id;
      final propertyProvider = Provider.of<PropertyProvider>(
        context,
        listen: false,
      );

      final postData = {
        'user_id': userId?.toString() ?? '',
        'property_id': propertyProvider.property?.id.toString() ?? '',
      };

      final apiClient = ApiClient();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await apiClient.post(
        '/mobile/bank_accounts/get_property_recipients_bank_accounts_list',
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
        final data =
            List<Map<String, dynamic>>.from(response['response']['banks']);

        final tempBankModels = data.map((bankData) {
          return Banks(
            id: bankData['id'].toString(),
            accountNumber: bankData['account_number'].toString(),
            accountName: bankData['account_name'].toString(),
            bankBranch: bankData['bank_branch'].toString(),
            bankName: bankData['bank_name'].toString(),
          );
        }).toList();

        setState(() {
          bankModels = tempBankModels;
          selectedBankAccount =
              '${bankModels[0].bankName} (${bankModels[0].bankBranch}) ${bankModels[0].accountName} ${bankModels[0].accountNumber}';
          bankModelsDropdownList = tempBankModels
              .map((bankAccount) =>
                  '${bankModels[0].bankName} (${bankModels[0].bankBranch}) ${bankModels[0].accountName} ${bankModels[0].accountNumber}')
              .toList();
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

  bool rentInfoLoaded = false;
  Map<String, dynamic> rentInfo = {};

  fetchRentInfo() async {
    print('I am here trying to fetch the total rent info');

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
    };
    print('This is my property id here');
    print(
      propertyProvider.property?.id,
    );
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await apiClient.post(
        '/mobile/reports/rent_collected_per_month',
        postData,
        headers: headers,
      );

      var responseData = response['response'];
      if (responseData != null) {
        print('Rent Collected Details>>>>>>>>>>>');
        print(responseData);

        setState(() {
          rentInfo = {
            "property_id": responseData["property_id"].toString(),
            "from": responseData["from"],
            "to": responseData["to"],
            "amount_expected": responseData["amount_expected"]?.toString(),
            "amount_collected": responseData["amount_collected"]?.toString(),
            "amount_in_arrears": responseData["amount_in_arrears"]?.toString(),
            "current_balance": responseData["current_balance"]?.toString(),
          };
        });
      }
    } catch (e) {
      print('Error');
      print(e);
      print('Error in API call: $e');
    }
    setState(() {
      rentInfoLoaded = true;
    });
  }

  List trasactionList = [];

  bool monthRentLoaded = false;
  Map<String, dynamic> monthRent = {};

  fetchRentInfoForCurrentMonth() async {
    print('I am here trying to fetch rent info');

    // Get the current month
    final currentMonth = DateTime.now().month;

    print('Fetching rent info for current month: $currentMonth');

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
      "month": currentMonth.toString(),
    };
    print('This is my property id here');
    print(propertyProvider.property?.id);
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await apiClient.post(
        '/mobile/reports/rent_collected_per_month',
        postData,
        headers: headers,
      );

      var responseData = response['response'];
      if (responseData != null) {
        print('Rent Collected Details for the current month >>>>>>>>>>>');
        print(responseData);
        setState(() {
          monthRent = responseData;
        });
      }
    } catch (e) {
      print('Error');
      print(e);
      print('Error in API call: $e');
    }

    setState(() {
      monthRentLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBanks(context);
    fetchRentInfo();
    fetchRentInfoForCurrentMonth();

    fetchTransactionsList();
    fetchPropertiesByUser(context);
  }

  void showBottom() {
    TextEditingController amountController = TextEditingController();
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final userID = userProvider.user?.id;
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'CURRENT AVAILABLE BALANCE:',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'KES ${currencyFormat.format(double.parse(rentInfo['current_balance'] ?? '0.0'))}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.money_off,
                        color: primaryDarkColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Enter amount to withdraw'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: amountController,
                    style: bodyText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'ENTER AMOUNT',
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
                  const SizedBox(height: 10.0),
                  const Text(
                    'Select withdrawal purpose',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: selectedOption,
                    items: [
                      const DropdownMenuItem(
                        child: Text('Expense Payment'),
                        value: 'expense_payment',
                      ),
                      const DropdownMenuItem(
                        child: Text('Tenant Refund'),
                        value: 'tenant_refund',
                      ),
                      const DropdownMenuItem(
                        child: Text('Account Transfer'),
                        value: 'account_transfer',
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Select purpose',
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
                  const SizedBox(height: 20),
                  Text(
                    'Choose payment method',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryDarkColor),
                          onPressed: () {
                            final userProvider = Provider.of<UserProvider>(
                              context,
                              listen: false,
                            );
                            final phone = userProvider.user?.phone;
                            TextEditingController _phoneNumberController =
                                TextEditingController(text: phone);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: AlertDialog(
                                    insetPadding: const EdgeInsets.all(10),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Confirm phone number'),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: _phoneNumberController,
                                            style: bodyText,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'ENTER AMOUNT',
                                              labelStyle: MyTheme.darkTheme
                                                  .textTheme.bodyLarge!
                                                  .copyWith(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomRequestButton(
                                            cookie:
                                                'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                                            authorization:
                                                'Bearer ${userProvider.user?.token}',
                                            url:
                                                '/mobile/withdrawals/request_funds_transfer',
                                            method: 'POST',
                                            buttonText: 'CONFIRM',
                                            body: {
                                              "user_id": userID,
                                              'property_id': propertyProvider
                                                      .property?.id
                                                      .toString() ??
                                                  '',
                                              "amount": amountController.text,
                                              "recipient": "3",
                                              "withdrawal_for": 5,
                                              "phone": "",
                                              "expense_category_id": "",
                                              "bank_id": "9488",
                                              "account_number":
                                                  "01109123441200",
                                              "account_name":
                                                  "JAMES NJUGUNA NGURUI",
                                              "transfer_from": "bank-9429",
                                              "transfer_to": "bank-9488",
                                              "tenant_id": "",
                                              "contribution_id": ""
                                            },
                                            onSuccess: (res) {
                                              print(
                                                  '<<<<<<<<<<< res >>>>>>>>>>>>>>');
                                              print(res);
                                              if (res['isSuccessful'] == true) {
                                                if (res['data']['response']
                                                        ['status'] ==
                                                    1) {
                                                  showToast(
                                                    context,
                                                    'Success!',
                                                    'Your withdrawal request is successful!',
                                                    mintyGreen,
                                                  );
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    // Delay for 2 seconds (adjust as needed)
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                const ListWithdrawals())));
                                                  });
                                                }
                                                ;
                                              } else {
                                                showToast(
                                                  context,
                                                  'Error!',
                                                  res['data']['response']
                                                      ['message'],
                                                  Colors.red,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'SEND TO MOBILE',
                            // style: TextStyle(
                            //   fontSize: 10.0,
                            //   fontFamily: 'Roboto',
                            //   color: Colors.white,
                            //   fontWeight: FontWeight.bold,
                            //   letterSpacing: 1.0,
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text('Select preferred bank'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Select Bank',
                                          labelStyle: MyTheme
                                              .darkTheme.textTheme.bodyLarge!
                                              .copyWith(color: Colors.grey),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        value: selectedBankValue,
                                        items:
                                            bankModelsDropdownList.map((bank) {
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

                                      const SizedBox(height: 20),
                                      // DropdownButtonFormField<String>(
                                      //   decoration: InputDecoration(
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //     hintText: 'Select Branch',
                                      //     labelStyle: MyTheme
                                      //         .darkTheme.textTheme.bodyLarge!1
                                      //         .copyWith(color: Colors.grey),
                                      //     border: OutlineInputBorder(
                                      //       borderSide: const BorderSide(
                                      //         color: Colors.grey,
                                      //         width: 1.0,
                                      //       ),
                                      //       borderRadius: BorderRadius.circular(8.0),
                                      //     ),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //         color: Colors.grey.shade300,
                                      //         width: 2.0,
                                      //       ),
                                      //       borderRadius: BorderRadius.circular(8.0),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: const BorderSide(
                                      //         color: Colors.grey,
                                      //         width: 1.0,
                                      //       ),
                                      //       borderRadius: BorderRadius.circular(8.0),
                                      //     ),
                                      //   ),
                                      //   value: selectedBranchValue,
                                      //   items: selectedBankValue != 'Select Bank' &&
                                      //           bankBranches
                                      //               .containsKey(selectedBankValue)
                                      //       ? [
                                      //           'Select Branch',
                                      //           ...bankBranches[selectedBankValue]!
                                      //         ].map((branch) {
                                      //           return DropdownMenuItem<String>(
                                      //             value: branch,
                                      //             child: Text(branch),
                                      //           );
                                      //         }).toList()
                                      //       : [],
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       selectedBranchValue = value!;
                                      //     });
                                      //   },
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    primaryDarkColor),
                                            onPressed: () {
                                              showToast(
                                                context,
                                                'Success!',
                                                'Your withdrawal request is successful!',
                                                mintyGreen,
                                              );

                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            const ListWithdrawals())));
                                              });
                                            },
                                            child: const Text('CONFIRM')),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('SEND TO BANK'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    Widget rentWidget = Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rent',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Total rent for $currentMonth'),
              const Text('Withdrawable amount'),

              Text(
                // 'KES ${currencyFormat.format(rentInfo['amount_collected'] ?? 0)}',
                'KES ${currencyFormat.format(double.parse(rentInfo['current_balance'] ?? '0.0'))}',
                //'Ksh. 0',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              const ProgressBar(
                  // collectedAmount: rentInfo['amount_collected'],
                  // expectedAmount: rentInfo['amount_in_arrears'],
                  ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total rent collected',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Amount in arrears',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KES ${currencyFormat.format(double.parse(rentInfo['amount_collected'] ?? '0.0'))}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'KES ${currencyFormat.format(double.parse(rentInfo['amount_in_arrears'] ?? '0.0'))}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showBottom();
                      //showBottomModal(context, bottomContent);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryDarkColor),
                            color: primaryDarkColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Withdraw',
                                style: TextStyle(
                                    color: primaryDarkColor, fontSize: 14),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: primaryDarkColor,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const Withdrawals(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryDarkColor),
                            color: primaryDarkColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'View History',
                                style: TextStyle(
                                    color: primaryDarkColor, fontSize: 14),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: primaryDarkColor,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ],
    );
    Widget monthWidget = Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total rent collected this month'),
              Text(
                'KES ${currencyFormat.format(double.parse(monthRent['amount_collected']?.toString() ?? '0.0'))}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              const ProgressBar(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rent expected',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Amount in arrears',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KES ${currencyFormat.format(double.parse(monthRent?['amount_expected']?.toString() ?? '0.0'))}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'KES ${currencyFormat.format(double.parse(monthRent?['amount_in_arrears']?.toString() ?? '0.0'))}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: primaryDarkColor.withOpacity(0.1),
                    border: Border.all(color: primaryDarkColor),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Monthly Summary',
                        style: TextStyle(color: primaryDarkColor, fontSize: 14),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: primaryDarkColor,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    Widget transactionsWidget = Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                        withNavBar: false,
                        screen: const Transactions());
                  },
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: primaryDarkColor),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 15,
                        color: primaryDarkColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          transactionListLoaded == false
              ? Center(
                  child: SizedBox(
                      child: LinearProgressIndicator(
                    color: mintyGreen,
                    minHeight: 4,
                  )
                      // CircularProgressIndicator(
                      //   strokeWidth: 4,
                      //   color: mintyGreen,
                      // ),
                      ),
                )
              : transactionsList.isEmpty
                  ? const EmptyTransactions()
                  : Expanded(
                      child: ListView.builder(
                        // itemCount: transactionsList.length > 6
                        //     ? 6
                        //     : transactionsList.length,
                        itemCount: transactionsList.length,
                        itemBuilder: (context, index) {
                          var transaction = transactionsList[index];
                          return TransactionCard(
                            tenant: transaction['tenant'],
                            date: transaction['date'],
                            amount: transaction['amount'],
                            type: transaction['type'],
                            unit: transaction['unit'],
                            bill: transaction['bill'],
                            reconciliation: transaction['reconciliation'],
                            narrative: transaction['narative'],
                            id: transaction['id'],
                          );
                        },
                      ),
                    )
        ],
      ),
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    // Widget bankContent = Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(height: 20),
    //     Row(
    //       children: [
    //         Text(
    //           'Bank Name:',
    //           style: Theme.of(context).textTheme.bodySmall,
    //         ),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Text(
    //           bankModels.isNotEmpty ? bankModels[0]?.bankName ?? 'N/A' : 'N/A',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayLarge!
    //               .copyWith(fontSize: 16),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //     Row(
    //       children: [
    //         Text(
    //           'Bank Branch:',
    //           style: Theme.of(context).textTheme.bodySmall,
    //         ),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Text(
    //           bankModels.isNotEmpty
    //               ? bankModels[0]?.bankBranch ?? 'N/A'
    //               : 'N/A',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayLarge!
    //               .copyWith(fontSize: 16),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //     Row(
    //       children: [
    //         Text(
    //           'Account Name:',
    //           style: Theme.of(context).textTheme.bodySmall,
    //         ),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Text(
    //           bankModels.isNotEmpty
    //               ? bankModels[0]?.accountName ?? 'N/A'
    //               : 'N/A',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayLarge!
    //               .copyWith(fontSize: 16),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //     Row(
    //       children: [
    //         Text(
    //           'Account Number:',
    //           style: Theme.of(context).textTheme.bodySmall,
    //         ),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Text(
    //           bankModels.isNotEmpty
    //               ? bankModels[0]?.accountNumber ?? 'N/A'
    //               : 'N/A',
    //           style: Theme.of(context)
    //               .textTheme
    //               .displayLarge!
    //               .copyWith(fontSize: 16),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 20),
    //     Container(
    //       margin: const EdgeInsets.only(left: 10),
    //       child: CustomRequestButton(
    //         cookie:
    //             'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
    //         authorization: 'Bearer ${userProvider.user?.token}',
    //         // buttonError: buttonError,
    //         //buttonErrorMessage: buttonErrorMessage,
    //         url: '/mobile/withdrawals/request_funds_transfer',
    //         method: 'POST',
    //         buttonText: 'COnfirm',
    //         body: {
    //           "user_id": userProvider.user?.id,
    //           "property_id": propertyProvider.property?.id,
    //           "amount": 100,
    //           "recipient": "3",
    //           "withdrawal_for": 5,
    //           "phone": "",
    //           "expense_category_id": "",
    //           "bank_id": "9488",
    //           "account_number": "01109123441200",
    //           "account_name": "JAMES NJUGUNA NGURUI",
    //           "transfer_from": "bank-9429",
    //           "transfer_to": "bank-9488",
    //           "tenant_id": "",
    //           "contribution_id": "",
    //         },
    //         onSuccess: (res) {
    //           if (res['isSuccessful'] == false) {
    //             return showToast(
    //               context,
    //               'Error!',
    //               res['error'],
    //               Colors.red,
    //             );
    //           } else {
    //             // Handle success case
    //             // Do any additional processing or navigation
    //             showToast(
    //               context,
    //               'Success!',
    //               'Withdrawal Request successful',
    //               mintyGreen,
    //             );

    //             Future.delayed(const Duration(seconds: 2), () {
    //               // Delay for 2 seconds (adjust as needed)
    //               // Example navigation:
    //               PersistentNavBarNavigator.pushNewScreen(context,
    //                   withNavBar: false,
    //                   pageTransitionAnimation:
    //                       PageTransitionAnimation.cupertino,
    //                   screen: ListWithdrawals());
    //             });
    //           }
    //         },
    //       ),
    //     ),
    //   ],
    // );
    Widget modalContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a property',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: Consumer<PropertyListProvider>(
            builder: (context, userPropertyListProvider, _) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: userPropertyList.length,
                itemBuilder: (context, index) {
                  var currentPropertyID =
                      int.parse(userPropertyList[index]['id']);
                  var currentPropertyName = userPropertyList[index]['name'];
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: mintyGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final propertyProvider =
                              Provider.of<PropertyProvider>(
                            context,
                            listen: false,
                          );
                          propertyProvider.setProperty(
                            Property(
                              propertyName: currentPropertyName,
                              propertyLocation: '',
                              id: currentPropertyID,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const Dashboard()),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.house_rounded,
                                color: mintyGreen,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                userPropertyList[index]['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Add New Properties',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const AddProperty(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Row(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mintyGreen,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Add property',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Text(
                      '+',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container())
            ]),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 5),
              DashboardAppbar(
                headerText: 'Property',
                headerBody: propertyProvider.property?.propertyName ?? '',
                icon: Image.asset(
                  'assets/images/icons/exchange.png',
                  width: 20,
                ),
                callback: (value) {
                  showBottomModal(
                    context,
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: modalContent,
                    ),
                  );
                },
              ),
              Expanded(
                  child: ListView(
                children: [
                  rentWidget,
                  GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const PropertyDetails(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: monthWidget),
                  const SizedBox(height: 10),
                  transactionsWidget,
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
