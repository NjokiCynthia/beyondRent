import 'package:flutter/material.dart';
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
  DateTime selectedDate = DateTime.now();
  String currentMonth = '';
  List trasactionList = [];

  Future<void> _showDayPicker(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastSelectableDate =
        DateTime(currentDate.year - 1, currentDate.month);

    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastSelectableDate,
      lastDate: currentDate,
      initialDatePickerMode: DatePickerMode.day, // Change this to day
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: mintyGreen, // Change this to your desired color
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

  @override
  void initState() {
    super.initState();
    currentMonth = getMonthAbbreviation(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
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
                  _showDayPicker(context);
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
                const Text('Total rent for September'),
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
                      'Ksh, 0',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Ksh, 0',
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
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: userPropertyListProvider.properties.length,
            itemBuilder: (context, index) {
              Property property = userPropertyListProvider.properties[index];

              return GestureDetector(
                onTap: () {
                  print('Tapped');
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
