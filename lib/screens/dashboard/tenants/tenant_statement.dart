import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class TenantStatement extends StatefulWidget {
  final int? tenantId;
  const TenantStatement({super.key, this.tenantId});

  @override
  State<TenantStatement> createState() => _TenantStatementState();
}

class _TenantStatementState extends State<TenantStatement> {
  bool depositListLoaded = false;
  List depositList = [];
  Map<String, dynamic>? tenantDetails;

  fetchDeposits(int tenantId) async {
    print('I am here to fetch deposits');
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;

    final postData = {
      "property_id": propertyProvider.property?.id,
      "tenants": [tenantId],
    };
    print('this is the tenant id i am using');
    print(tenantId);
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await apiClient.post(
        '/mobile/deposits/get_deposits_list',
        postData,
        headers: headers,
      );

      var responseStatus = response['response']['status'];
      if (responseStatus == 1) {
        print('These are my deposit details below here >>>>>>>>>>>');
        print(response['response']['deposits']);
        setState(() {
          depositList = response['response']['deposits'];
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }

    setState(() {
      depositListLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchDeposits(widget.tenantId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: primaryDarkColor,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'View Tenant Rent Deposits',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: depositListLoaded == false
                  ? Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: mintyGreen,
                        ),
                      ),
                    )
                  : depositList.isEmpty
                      ? const EmptyTransactions()
                      : Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(205, 228, 228, 1),
                                      Color.fromRGBO(241, 233, 223, 1)
                                    ],
                                  ),
                                ),
                                child: ListTile(
                                  leading: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color:
                                              primaryDarkColor.withOpacity(0.5),
                                        ),
                                      )),
                                  title: Text(
                                    depositList.isNotEmpty
                                        ? '${depositList.first['tenant']}'
                                        : 'No Tenant Name',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${depositList.first['unit']['name']}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${depositList.first['unit']['house_number']}')
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: depositList.length,
                                    itemBuilder: (context, index) {
                                      var deposit = depositList[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.fromBorderSide(
                                                  BorderSide(
                                                      strokeAlign: BorderSide
                                                          .strokeAlignOutside,
                                                      color: primaryDarkColor
                                                          .withOpacity(0.1)))
                                              // border: Border.all(
                                              //     color: primaryDarkColor.withOpacity(0.1)),
                                              ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${deposit['date']}',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: primaryDarkColor
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Text(
                                                        'KES ${currencyFormat.format(double.parse(deposit['amount'].toString() ?? "0"))}',
                                                        style: const TextStyle(
                                                            color:
                                                                primaryDarkColor,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${deposit['bill']['name']}',
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                ' Reconciliation status: ${deposit['reconciliation']}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ))),
    );
  }
}
