import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/transactions.dart';
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
  bool transactionListLoaded = false;
  List<Map<String, dynamic>> transactionsList = [];

  fetchTransactionsList() async {
    print('I am here to load transactions');
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
        '/mobile/contributions/get_property_contributions',
        postData,
        headers: headers,
      );

      var responseStatus = response['response']['status'];

      if (responseStatus == 1) {
        print('These are my transaction details below here >>>>>>>>>>>');
        print(response['response']['contributions']);

        setState(() {
          transactionsList = List<Map<String, dynamic>>.from(
            response['response']['contributions'],
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
        '/mobile/reports/total_rent_collected',
        postData,
        headers: headers,
      );

      var responseData = response['response'];
      if (responseData != null) {
        print('Rent Collected Details>>>>>>>>>>>');

        print(responseData);

        // Adjust the response parsing based on your actual response structure
        setState(() {
          rentInfo = {
            "property_id": responseData["property_id"].toString(),
            "amount_collected": responseData["amount_collected"]?.toString(),
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
  @override
  void initState() {
    super.initState();

    fetchTransactionsList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userPropertyListProvider = Provider.of<PropertyListProvider>(
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
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const PropertyDetails(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        Text(
                          'View Summary',
                          style: const TextStyle(
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
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
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
              Text('Total rent collected'),

              Text(
                'KES ${currencyFormat.format(rentInfo['amount_collected'] ?? 0)}',
                // 'KES. ${rentInfo['amount_expected']}',
                //'Ksh. 0',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              ProgressBar(
                  // collectedAmount: rentInfo['amount_collected'],
                  // expectedAmount: rentInfo['amount_expected'],
                  ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount available',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Pending amount',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KES ${currencyFormat.format(rentInfo['amount_collected'] ?? 0)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'KES ${currencyFormat.format(rentInfo['amount_collected'] ?? 0)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
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
                        screen: Transactions());
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
                      Icon(
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
                              name: transaction['name'] ?? 'Tenant',
                              date: transaction['contribution_date'] ?? '',
                              amount: transaction['amount'] ?? 0,
                              type: transaction['type'] ?? "");
                        },
                      ),
                    )
        ],
      ),
    );
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
                itemCount: userPropertyListProvider.properties.length,
                itemBuilder: (context, index) {
                  Property property =
                      userPropertyListProvider.properties[index];

                  return GestureDetector(
                    onTap: () {
                      final propertyProvider = Provider.of<PropertyProvider>(
                        context,
                        listen: false,
                      );
                      propertyProvider.setProperty(
                        Property(
                          propertyName: userPropertyListProvider
                              .properties[index].propertyName,
                          propertyLocation: userPropertyListProvider
                              .properties[index].propertyLocation,
                          id: userPropertyListProvider.properties[index].id,
                        ),
                      );
                      print('Tapped');
                      print(userPropertyListProvider.properties[index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const Dashboard()),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.only(bottom: 10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    'assets/images/icons/home.png',
                                    width: 20,
                                  ),
                                ),
                                Text(
                                  property.propertyName,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'view',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
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
              const SizedBox(height: 20),
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
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: primaryDarkColor, width: 3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Withdraw',
                              style: TextStyle(color: primaryDarkColor),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: primaryDarkColor,
                              weight: 2,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
