import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/constants/theme.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            margin: EdgeInsets.only(bottom: 50),
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
              onTap: () {
                // Navigator.pop(context);
                // showBottomModal(
                //   context,
                //   paymentModalContent,
                // );
              },
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
                    TransactionCard(
                      name: 'Liam',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Ethan',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Ava',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Julia',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Julia',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Olivia',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Liam',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Ava',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Julia',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Julia',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Liam',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Ethan',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
                    TransactionCard(
                      name: 'Ava',
                      date: '20th, Feb 2023',
                      amount: 2000,
                    ),
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
