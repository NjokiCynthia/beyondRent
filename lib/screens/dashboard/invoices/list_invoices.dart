import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';

class ListInvoices extends StatefulWidget {
  const ListInvoices({super.key});

  @override
  State<ListInvoices> createState() => _ListInvoicesState();
}

class _ListInvoicesState extends State<ListInvoices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: primaryDarkColor,
        ),
        title: Text(
          'Invoices sent',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.fromBorderSide(BorderSide(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: primaryDarkColor.withOpacity(0.1)))
                            // border: Border.all(
                            //     color: primaryDarkColor.withOpacity(0.1)),
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#Invoice 155',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Tenant A'),
                                    Text('|'),
                                    Text('079021678'),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: primaryDarkColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 2, bottom: 2),
                                    child: Text(
                                      'rent invoice',
                                      style: TextStyle(
                                          color: primaryDarkColor,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'House 1',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'KES 20,000',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '21 Nov 2023',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  '2 days to go',
                                  style: TextStyle(
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
