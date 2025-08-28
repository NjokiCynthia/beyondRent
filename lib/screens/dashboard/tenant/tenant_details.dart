// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ViewTenant extends StatefulWidget {
  final int? tenantId;
  const ViewTenant({super.key, this.tenantId});

  @override
  State<ViewTenant> createState() => _ViewTenantState();
}

class _ViewTenantState extends State<ViewTenant> {
  bool tenantInfoLoading = true;
  Map tenantDetails = {};
  Map unitDetails = {};
  String? tenantName;
  Future<void> fetchTenantDetails(int tenantId) async {
    print('i AM HERE TO FETCH TENANT DETAILS......');
    setState(() {
      tenantInfoLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );

    final postData = {
      "property_id": propertyProvider.property?.id,
      "tenant_ids": [tenantId]
    };
    print('This is what I am sending while fetching');
    print(postData);
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await apiClient.post(
        '/mobile/invoices/get_property_invoices',
        postData,
        headers: headers,
      );
      print('API Response:');
      print(response);
      if (response['response']['status'] == 1) {
        print('This is my tenant invoice details>>>>>>>>>>>');

        print(response['response']);

        setState(() {
          print('............................');
          var responseData = response['response'];
          tenantDetails = {
            'total_amount_payable': responseData['total_amount_payable'],
            'total_amount_paid': responseData['total_amount_paid'],
            'invoices': responseData['invoices'],
          };
        });
      }
    } catch (e) {
      print('e');
      print(e);
    }
    setState(() {
      tenantInfoLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchTenantDetails(widget.tenantId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    Widget propertySummary = Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tenantInfoLoading == true
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    Text(
                      tenantDetails['invoices'].isNotEmpty
                          ? tenantDetails['invoices'][0]['tenant'].toString()
                          : "None",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount payable:',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Amount paid:',
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Pending amount:',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KES ${currencyFormat.format(double.parse(tenantDetails['total_amount_payable'].toString()))}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'KES ${currencyFormat.format(double.parse(tenantDetails['total_amount_paid'].toString()))}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 251, 239, 239),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 2, bottom: 2),
                                child: Text(
                                  'KES ${currencyFormat.format(double.parse((tenantDetails['total_amount_payable'] - tenantDetails['total_amount_paid']).toString()))}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Colors.red, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 10),
        ],
      ),
    );

    Widget invoiceItem(Map invoice) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.fromBorderSide(BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: primaryDarkColor.withValues(alpha: 0.1))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${invoice['invoice_date'] ?? "No date"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${invoice['type']}',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount invoiced',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    'Amount paid',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: primaryDarkColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 2),
                      child: Text(
                        'KES ${currencyFormat.format(double.parse(invoice['amount_payable'].toString()))}',
                        style: const TextStyle(
                            color: primaryDarkColor, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: primaryDarkColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 2),
                      child: Text(
                        'KES ${currencyFormat.format(double.parse(invoice['amount_paid'].toString()))}',
                        style: const TextStyle(
                            color: primaryDarkColor, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

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
            'Summary',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            height: 7,
            width: 50,
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          tenantInfoLoading == true
              ? const Center(
                  child: LinearProgressIndicator(
                    color: primaryDarkColor,
                  ),
                )
              : Flexible(
                  child: tenantDetails['invoices'] != null &&
                          tenantDetails['invoices'].isNotEmpty
                      ? ListView.builder(
                          itemCount: tenantDetails['invoices'].length,
                          itemBuilder: (context, index) {
                            var invoice = tenantDetails['invoices'][index];
                            return invoiceItem(invoice);
                          },
                        )
                      : const Center(child: EmptyTransactions()),
                ),
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
