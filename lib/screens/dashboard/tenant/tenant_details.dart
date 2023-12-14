import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/dashboard/tenant/update_tenant.dart';
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
  fetchTenantDetails(int tenantId) async {
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
    print('This is what i am sending while fetching');
    print(postData);
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await apiClient.post(
          '/mobile/invoices/get_property_invoices', postData,
          headers: headers);
      print('API Response:');
      print(response);
      if (response['response']['status'] == 1) {
        print('This is my tenant invoice details>>>>>>>>>>>');

        print(response['response']);

        setState(() {
          print('............................');
          tenantDetails = response['response'];
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
        top: 40,
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
                      '${tenantDetails['invoices'][0]['tenant'] ?? "None"}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Amount payable:',
                          style: TextStyle(color: primaryDarkColor),
                        ),
                        Text(
                          'KES ${currencyFormat.format(double.parse(tenantDetails['total_amount_payable'].toString() ?? "0"))}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Amount paid:',
                          style: TextStyle(color: primaryDarkColor),
                        ),
                        Text(
                          'KES ${currencyFormat.format(double.parse(tenantDetails['total_amount_paid'].toString() ?? "0"))}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                color: primaryDarkColor.withOpacity(0.1))),
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
                    //'',
                    '${invoice?['invoice_date'] ?? "No date"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: primaryDarkColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 2),
                      child: Text(
                        'KES ${currencyFormat.format(double.parse(invoice['amount_payable'].toString() ?? "0"))}',
                        style: const TextStyle(
                            color: primaryDarkColor, fontSize: 14),
                      ),
                    ),
                  ),
                  // Text(
                  //   'KES ${currencyFormat.format(double.parse(withdrawal['amount'].toString() ?? "0"))}',
                  // ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '',
                //'${invoice['type']}',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                height: 5,
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
            width: 40,
            decoration: BoxDecoration(
              color: mintyGreen,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: tenantDetails['invoices'] != null
                ? ListView.builder(
                    itemCount: tenantDetails['invoices'].length,
                    itemBuilder: (context, index) {
                      var invoice = tenantDetails['invoices'][index];
                      return invoiceItem(invoice);
                    },
                  )
                : Center(child: EmptyTransactions()),
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
                child: DashboardAppbar(
                  backButton: true,
                  backButtonText: 'Tenant Details',
                  action: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        color: mintyGreen,
                        borderRadius: BorderRadius.circular(7),
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
                        children: [
                          Text(
                            'Tenant',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white, fontSize: 14),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
