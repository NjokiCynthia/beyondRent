// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/tenant/tenant_details.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class ListTenants extends StatefulWidget {
  const ListTenants({super.key});

  @override
  State<ListTenants> createState() => _ListTenantsState();
}

class _ListTenantsState extends State<ListTenants> {
  bool tenantListLoaded = true;

  List selectedTenants = [2];

  Future<void> fetchTenantsList() async {
    print('i am here to fetch tenant list');
    setState(() {
      tenantListLoaded = true;
    });
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
      var response = await apiClient.post('/mobile/tenants/get_all', postData,
          headers: headers);
      if (response != null && response['response'] != null) {
        var responseStatus = response['response']['status'];
        print('this are my tenants list below here >>>>>>>>>>>');
        print(response);
        if (responseStatus == 1) {
          var tenants = response['response']['tenants'];
          if (tenants != null) {
            setState(() {
              tenantList = tenants;
            });
          }
        }
      }
    } catch (e) {
      print('Error');
      print(e);
    }
    setState(() {
      tenantListLoaded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTenantsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withValues(alpha: 0.02),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Navigate back to the home screen
            Navigator.popUntil(context, (route) => true);
            bottomNavigationController.jumpToTab(0);
          },
          child: const Icon(Icons.arrow_back_ios, color: primaryDarkColor),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tenants List',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: const EdgeInsets.all(20),
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Total Number of Tenants',
                    ),
                    Text(
                      '${tenantList.length}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                        // tenantListLoaded
                        //     ? Center(
                        //         child: CircularProgressIndicator(
                        //           strokeWidth: 4,
                        //           color: mintyGreen,
                        //         ),
                        //       )
                        //     :
                        tenantList.isEmpty
                            ? const Center(child: EmptyTenants())
                            : ListView.builder(
                                itemCount: tenantList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            final selectedTenantId = int.parse(
                                                tenantList[index]['id']);
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              withNavBar: false,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                              screen: ViewTenant(
                                                  tenantId: selectedTenantId),
                                            );
                                          },
                                          child: ListTile(
                                            leading: Container(
                                                decoration: BoxDecoration(
                                                    color: primaryDarkColor
                                                        .withValues(alpha: 0.1),
                                                    shape: BoxShape.circle),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: primaryDarkColor,
                                                  ),
                                                )),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${tenantList[index]['first_name']} ${tenantList[index]['last_name']}',
                                                ),
                                                Text(
                                                  '${tenantList[index]['phone']}',
                                                )
                                              ],
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'House Number:',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          '${tenantList[index]['house_number']}'),
                                                    ],
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color:
                                                              primaryDarkColor
                                                                  .withValues(
                                                                      alpha:
                                                                          0.1)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Text(
                                                          'View rent statement',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryDarkColor,
                                                              fontSize: 12),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: Color.fromARGB(
                                              255, 219, 218, 218),
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  );
                                })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
