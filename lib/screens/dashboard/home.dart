import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Text(
                    'Sept ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black.withOpacity(0.2),
                    size: 20,
                  )
                ],
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
              const Text('Total rent for September'),
              Text(
                'Kes. 7,000',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              const ProgressBar(progress: 30),
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
                    'Kes, 7,000',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Kes, 64,000',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
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
              Text(
                'All',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
        const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
        const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
        const TransactionCard(name: 'Julia', date: '20th', amount: 2000),
      ],
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Column(
            children: [
              const DashboardAppbar(
                headerText: 'Hello',
                headerBody: 'Aarav Basu',
                icon: Icon(
                  Icons.notification_add,
                  color: Colors.black,
                  size: 20,
                ),
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
