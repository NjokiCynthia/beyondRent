import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';

class Invoice {
  final String title;
  final double amount;
  final String timeline;
  final String status;
  final Color statusColor;

  Invoice({
    required this.title,
    required this.amount,
    required this.timeline,
    required this.status,
    required this.statusColor,
  });
}

class InvoicesScreen extends StatelessWidget {
  final List<Invoice> invoices = [
    Invoice(
      title: 'Invoice 001',
      amount: 500.0,
      timeline: '3/8/2020 to 4/9/2020',
      status: 'Pending',
      statusColor: Colors.red,
    ),
  ];
  InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const DashboardAppbar(
                headerText: 'Invoices',
                headerBody: 'Manage your invoices',
                icon: Icon(
                  Icons.inventory,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Expanded(child: InvoiceList(invoice: invoices[0], itemCount: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceList extends StatelessWidget {
  final Invoice invoice;
  final int itemCount;

  const InvoiceList({super.key, required this.invoice, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            InvoiceCard(invoice: invoice),
            const SizedBox(height: 10.0), // Adding spacing between cards
          ],
        );
      },
    );
  }
}
