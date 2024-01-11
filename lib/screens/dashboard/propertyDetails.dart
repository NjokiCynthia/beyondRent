import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/models/invoice.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/invoices.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:intl/intl.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  String currentMonth = '';
  num currentYear = 2024;
  DateTime selectedDate = DateTime.now();

  Future<void> _showDayPicker(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastSelectableDate =
        DateTime(currentDate.year - 1, currentDate.month);

    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastSelectableDate,
      lastDate: currentDate,
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: mintyGreen,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedDate = selected;
        currentMonth = getMonthAbbreviation(selected);
      });
    }
  }

  String getMonthAbbreviation(DateTime date) {
    String abbreviation = DateFormat.MMM().format(date);
    return abbreviation;
  }

  BoxDecoration inactiveMonthDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    border: Border.all(
      width: 2,
      color: Colors.black.withOpacity(0.2),
    ),
  );
  BoxDecoration activeMonthDecoration = BoxDecoration(
    color: mintyGreen,
    borderRadius: BorderRadius.circular(4),
  );

  Future<void> showMonthPickerModal(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: mintyGreen,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          setState(() {
                            currentYear = currentYear - 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          )),
                          child: Text(
                            '<',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      Text(
                        '$currentYear',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('tapped');
                          setState(() {
                            currentYear = currentYear + 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          )),
                          child: Text(
                            '>',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$currentYear',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Jan';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Jan'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: const Text(
                                  'JAN',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Feb';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Feb'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: const Text(
                                  'FEB',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Mar';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Mar'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: const Text(
                                  'MAR',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Apr';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Apr'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'APR',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'May';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'May'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'MAY',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Jun';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Jun'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'JUN',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Jul';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Jul'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'JUL',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Aug';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Aug'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'AUG',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Sep';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Sep'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'SEP',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Oct';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Oct'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'OCT',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Nov';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Nov'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'NOV',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = 'Dec';
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: currentMonth == 'Dec'
                                    ? activeMonthDecoration
                                    : inactiveMonthDecoration,
                                child: Text(
                                  'DEC',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (currentMonth != null) {
      setState(() {
        currentMonth = currentMonth;
      });

      // Call the fetchRentInfo function with the selected month
      await fetchRentInfo(monthToNumber(currentMonth));
      await fetchTransactionsList(monthToNumber(currentMonth));
      await fetchPendingInfo(monthToNumber(currentMonth));
    }
  }

  bool transactionListLoaded = false;
  List<Map<String, dynamic>> transactionsList = [];
  fetchTransactionsList(int selectedMonth) async {
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

    print('This is my property id while fetching transactions');

    print(propertyProvider.property?.id);
    print('This is the month i am fetching transactions for');
    print(selectedMonth.toString());

    final postData = {
      "property_id": propertyProvider.property?.id,
      "month": selectedMonth.toString(),
      "tenants": []
    };
    print(postData);

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

  bool rentInfoLoaded = false;
  Map<String, dynamic> rentInfo = {};

  fetchRentInfo(int selectedMonth) async {
    print('I am here trying to fetch rent info');
    print('Fetching rent info for month $selectedMonth');
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
      "month": selectedMonth.toString(),
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
        print('Rent Collected Details for the selected month >>>>>>>>>>>');
        print(responseData);
        setState(() {
          rentInfo = responseData;
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

  bool pendingInfoLoaded = false;
  Map<String, dynamic> pendingInfo = {};
  List<PendingInvoice> invoices = [];

  fetchPendingInfo(int selectedMonth) async {
    print('I am here trying to fetch pending rent info');
    print('Fetching pending info for month $selectedMonth');
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
      "month": selectedMonth.toString(),
      "tenant_ids": []
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
        '/mobile/invoices/get_property_invoices_pending_payment',
        postData,
        headers: headers,
      );

      var responseData = response['response'];
      if (responseData != null && responseData['status'] == 1) {
        print('Pending Collected Details for the selected month >>>>>>>>>>>');
        print(responseData);
        setState(() {
          pendingInfo = {
            'total_amount_payable': responseData['total_amount_payable'],
            'total_amount_paid': responseData['total_amount_paid'],
            'total_counts': responseData['total_counts'],
            'total_pending_amount': responseData['total_pending_amount'],
            'invoices': responseData['invoices'],
          };

          invoices = (responseData['invoices'] as List)
              .map((invoiceData) => PendingInvoice(
                  id: invoiceData['id'],
                  invoiceDate: invoiceData['invoice_date'],
                  month: invoiceData['month'],
                  dueDate: invoiceData['due_date'],
                  tenant: invoiceData['tenant'],
                  type: invoiceData['type'],
                  amountPayable: invoiceData['amount_payable'],
                  // amountPaid: invoiceData['amount_paid'],
                  pendingAmount: invoiceData['pending_amount']))
              .toList();
        });
      } else {
        print('API request failed with status: ${responseData['status']}');
      }
    } catch (e) {
      print('Error');
      print(e);
      print('Error in API call: $e');
    }
    setState(() {
      pendingInfoLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    currentMonth = getMonthAbbreviation(DateTime.now());
    fetchRentInfo(DateTime.now().month);
    fetchPendingInfo(DateTime.now().month);
    fetchTransactionsList(DateTime.now().month);
  }

  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget propertySummary = Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      margin: const EdgeInsets.only(
        top: 40,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rent Summary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Rent for $currentMonth',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          //const ProgressBar(progress: 0),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Collected',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black.withOpacity(0.5)),
              ),
              Text(
                'Pending',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KES ${currencyFormat.format(rentInfo['amount_collected'] ?? 0)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'KES ${currencyFormat.format(rentInfo['amount_in_arrears'] ?? 0)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Total rent expected: KES ${currencyFormat.format(rentInfo['amount_expected'] ?? 0)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
    Widget propertyDetails = Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Update _selectedTabIndex to 0 when 'Collected' is tapped
                  setState(() {
                    _selectedTabIndex = 0;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      Text(
                        'Collected',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: _selectedTabIndex == 0
                                  ? mintyGreen
                                  : Colors.black.withOpacity(0.5),
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0
                              ? mintyGreen.withOpacity(0.1)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          transactionsList.length.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: _selectedTabIndex == 0
                                        ? mintyGreen
                                        : Colors.black.withOpacity(0.5),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Update _selectedTabIndex to 1 when 'Pending' is tapped
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      Text(
                        'Pending',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: _selectedTabIndex == 1
                                  ? Colors.red.withOpacity(0.7)
                                  : Colors.black.withOpacity(0.5),
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1
                              ? Color.fromARGB(255, 248, 164, 151)
                                  .withOpacity(0.1)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          invoices.length.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: _selectedTabIndex == 1
                                        ? Colors.red
                                        //   primaryDarkColor.withOpacity(0.7)
                                        : Colors.black.withOpacity(0.5),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 7,
            width: 40,
            decoration: BoxDecoration(
              color: _selectedTabIndex == 0 ? mintyGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 30),
          _selectedTabIndex == 0
              ? transactionListLoaded == false
                  ? Center(
                      child: SizedBox(
                          child: LinearProgressIndicator(
                        color: mintyGreen,
                        minHeight: 4,
                      )),
                    )
                  : transactionsList.isEmpty
                      ? const EmptyTransactions()
                      : Expanded(
                          child: ListView.builder(
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
              : invoices.isEmpty
                  ? const EmptyTransactions()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: invoices.length,
                        itemBuilder: (context, index) {
                          var invoice = invoices[index];
                          return InvoicesCard(invoice: invoice);
                        },
                      ),
                    )
        ]));

    Widget customeInvoiceContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Title',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: bodyText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Title',
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
                'Enter Message',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: bodyText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Message',
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
            ]),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Send',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
        ),
      ],
    );
    Widget modalContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send Invoices',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: mintyGreen,
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                'Send invoice to tenants with pending payments',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Custom Invoices',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            showBottomModal(
              context,
              customeInvoiceContent,
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: mintyGreen,
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                'Send custom invoice to tenants',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set transparent background for the Scaffold
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(161, 204, 204, 1),
              Color.fromRGBO(229, 210, 185, 1)
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/images/icons/left-arrow.png',
                            width: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          showMonthPickerModal(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    currentMonth,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // callback!('');
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            'assets/images/icons/info.png',
                            width: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                  // DashboardAppbar(
                  //   propertyNav: true,
                  //   callback: (value) {
                  //     value == 'date'
                  //         ? _showDayPicker(context)
                  //         : showBottomModal(
                  //             context,
                  //             Container(
                  //               padding: const EdgeInsets.all(20),
                  //               margin: const EdgeInsets.only(bottom: 30),
                  //               child: modalContent,
                  //             ),
                  //           );
                  //   },
                  // ),
                  ),
              Expanded(
                child: Column(
                  children: [
                    propertySummary,
                    Expanded(
                      child: Center(child: propertyDetails),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int monthToNumber(String monthAbbreviation) {
    switch (monthAbbreviation) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Aug':
        return 8;
      case 'Sep':
        return 9;
      case 'Oct':
        return 10;
      case 'Nov':
        return 11;
      case 'Dec':
        return 12;
      default:
        return 1;
    }
  }
}
