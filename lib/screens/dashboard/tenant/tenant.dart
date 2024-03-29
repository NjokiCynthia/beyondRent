import 'package:flutter/material.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:intl/intl.dart';

class TenantDetails extends StatefulWidget {
  const TenantDetails({Key? key}) : super(key: key);

  @override
  State<TenantDetails> createState() => _TenantDetailsState();
}

class _TenantDetailsState extends State<TenantDetails> {
  DateTime selectedDate = DateTime.now();
  String currentMonth = '';

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
            'Cynthia Njoki',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'History',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Row(
            children: [],
          ),
          Container(
            height: 7,
            width: 40,
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 30),
          const EmptyTransactions(),
        ],
      ),
    );
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
                child: const DashboardAppbar(
                  backButton: true,
                  backButtonText: 'Tenant Details',
                ),
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
}
