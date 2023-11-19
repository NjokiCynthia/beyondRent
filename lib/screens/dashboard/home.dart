import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/screens/dashboard/propertyDetails.dart';
import 'package:month_year_picker/month_year_picker.dart';
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
  DateTime selectedDate = DateTime.now();
  String currentMonth = '';
  List trasactionList = [];
  num currentYear = 2023;

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

  void showMonthPickerModal(BuildContext context) {
    showDialog(
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
                                margin: const EdgeInsets.only(
                                  right: 5,
                                  left: 5,
                                ),
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
  }

  @override
  void initState() {
    super.initState();
    currentMonth = getMonthAbbreviation(selectedDate);
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
                onTap: () async {
                  // _showDayPicker(context);
                  showMonthPickerModal(context);
                },
                child: Row(
                  children: [
                    Text(
                      currentMonth,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black.withOpacity(0.2),
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
                const Text('Total rent for November'),
                Text(
                  'Ksh. 0',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                const ProgressBar(progress: 0),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Collected',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Pending',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ksh. 0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Ksh. 0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
    Widget transactionsWidget = Column(
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
                onTap: () {},
                child: Text(
                  'All',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        trasactionList.isEmpty
            ? const EmptyTransactions()
            : const TransactionCard(
                name: 'Liam',
                date: '22nd, Mar 2023',
                amount: 20000,
              ),
      ],
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
            maxHeight: 200, // Set your desired max height here
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
                  const SizedBox(height: 30),
                  rentWidget,
                  const SizedBox(height: 30),
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
