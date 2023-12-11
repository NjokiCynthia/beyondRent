import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/invoices/create_invoice.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class ListInvoices extends StatefulWidget {
  const ListInvoices({super.key});

  @override
  State<ListInvoices> createState() => _ListInvoicesState();
}

class _ListInvoicesState extends State<ListInvoices> {
  bool invoiceListLoaded = false;
  List invoiceList = [];

  fetchInvoices() async {
    print('I am here to fetch invoices');
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;

    final postData = {"property_id": propertyProvider.property?.id};
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await apiClient.post(
          '/mobile/invoices/get_property_invoices', postData,
          headers: headers);
      var responseStatus = response['response']['status'];
      if (responseStatus == 1) {
        print('These are my invoice details below here >>>>>>>>>>>');
        print(response['response']['invoices']);
        setState(() {
          invoiceList = response['response']['invoices'];
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }
    setState(() {
      invoiceListLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: primaryDarkColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Invoices sent',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    withNavBar: false,
                    screen: const CreateInvoice());
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: primaryDarkColor.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.add,
                      color: primaryDarkColor,
                    ),
                  )),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: invoiceListLoaded == false
                  ? Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: mintyGreen,
                        ),
                      ),
                    )
                  : invoiceList.isEmpty
                      ? const EmptyInvoices()
                      : ListView.builder(
                          itemCount: invoiceList.length,
                          itemBuilder: (context, index) {
                            var invoice = invoiceList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.fromBorderSide(BorderSide(
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color:
                                            primaryDarkColor.withOpacity(0.1)))
                                    // border: Border.all(
                                    //     color: primaryDarkColor.withOpacity(0.1)),
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${invoice['type']}',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(invoice['tenant']),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          invoice['invoice_date'],
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: primaryDarkColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 2,
                                                bottom: 2),
                                            child: Text(
                                              'KES ${currencyFormat.format(double.parse(invoice['amount_payable'].toString() ?? "0"))}',
                                              // 'KES ${invoice['amount_payable']}',
                                              style: const TextStyle(
                                                  color: primaryDarkColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Invoice due date',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          invoice['due_date'],
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))),
    );
  }
}
