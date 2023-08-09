import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const DashboardAppbar(
                headerText: 'Tenants',
                headerBody: 'Tenants who have paid: 80',
                leftHeader: 1,
                icon: Icon(
                  Icons.group_add,
                  color: Colors.black,
                  size: 20,
                ),
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
