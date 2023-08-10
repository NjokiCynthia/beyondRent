import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/utilities/constants.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    Widget modalContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
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
            Container(
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
              DashboardAppbar(
                headerText: 'Transactions',
                headerBody: 'Total records: 1000',
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
                child: ListView(
                  children: const [
                    SizedBox(height: 30),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                    TransactionCard(name: 'Julia', date: '20th', amount: 2000),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
