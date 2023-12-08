import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/constants/theme.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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

      var responseStatus = response['response']['status'];

      if (responseStatus == 1) {
        print('These are my transaction details below here >>>>>>>>>>>');
        print(response['response']['deposits']);

        setState(() {
          transactionsList = List<Map<String, dynamic>>.from(
            response['response']['deposits'],
          );
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }

    setState(() {
      transactionListLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchTransactionsList();
  }

  @override
  Widget build(BuildContext context) {
    Widget paymentModalContent = Column(
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
        // Align(
        //   alignment: Alignment.center,
        //   child: Text(
        //     'Filter Transactions',
        //     style: Theme.of(context).textTheme.bodyMedium,
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        const SizedBox(height: 20),
        Text(
          'Add a Payment',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons/home.png',
                      width: 30,
                    ),
                    Text(
                      'Mobile Money',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons/bank.png',
                      width: 30,
                    ),
                    Text(
                      'Bank Transfer',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              DashboardAppbar(
                headerText: 'Transactions',
                headerBody: '',
                leftHeader: 1,
                icon: Image.asset(
                  'assets/images/icons/filter.png',
                  width: 20,
                ),
                callback: (value) {
                  showBottomModal(
                    context,
                    modalContent,
                  );
                },
              ),
              Expanded(
                child: transactionListLoaded == false
                    ? Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: mintyGreen,
                          ),
                        ),
                      )
                    : transactionsList.isEmpty
                        ? const EmptyTransactions()
                        : ListView.builder(
                            itemCount: transactionsList.length,
                            itemBuilder: ((context, index) {
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
                            })),
              )
              // Container(
              //   margin: const EdgeInsets.only(top: 50),
              //   child: const Center(
              //     child: EmptyTransactions(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
