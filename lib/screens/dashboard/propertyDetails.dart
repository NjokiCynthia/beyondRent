import 'package:flutter/material.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:intl/intl.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  void initState() {
    super.initState();
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
            'Rent Summary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Rent for September 2022',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          const ProgressBar(progress: 30),
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
                'Kes, 7,000',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Kes, 64,000',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Total rent: Kes, 7,000',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text(
                      'Collected',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: mintyGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '25',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: mintyGreen),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Collected',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '25',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black.withOpacity(0.7)),
                    ),
                  ),
                ],
              )
            ],
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
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
          const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
        ],
      ),
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
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: DashboardAppbar(
                  propertyNav: true,
                  callback: (value) {},
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    propertySummary,
                    propertyDetails,
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
