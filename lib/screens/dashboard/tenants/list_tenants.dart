import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/home.dart';
import 'package:x_rent/screens/dashboard/tenant/tenant.dart';
import 'package:x_rent/screens/dashboard/tenant/tenant_details.dart';
import 'package:x_rent/screens/dashboard/tenants/tenant_statement.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class ListTenants extends StatefulWidget {
  const ListTenants({super.key});

  @override
  State<ListTenants> createState() => _ListTenantsState();
}

class _ListTenantsState extends State<ListTenants> {
  bool tenantListLoaded = false;
  List tenantList = [];
  List selectedTenants = [2];

  fetchTenantsList() async {
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
      var responseStatus = response['response']['status'];
      if (responseStatus == 1) {
        print('These are my tenant details below here >>>>>>>>>>>');
        print(response['response']['tenants']);
        setState(() {
          tenantList = response['response']['tenants'];
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }
    setState(() {
      tenantListLoaded = true;
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
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()), // Replace HomeScreen with your actual home page
            );
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 114, 198, 117), // You can change the color as needed
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tenants List',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
  child: Column(
    children: [
      // Add a new SafeArea here
      SafeArea(
        top: false,
        child: Container(
           width: MediaQuery.of(context).size.width, // Set width to fill the screen
          height: 150,
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
          // Change this color as needed
           child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Total Tenants:            ${tenantList.length}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ),
      Expanded(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: tenantListLoaded == false
                ? Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: mintyGreen,
                      ),
                    ),
                  )
                : tenantList.isEmpty
                    ? const EmptyTenants()
                    : ListView.builder(
                        itemCount: tenantList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final selectedTenantId =
                                        int.parse(tenantList[index]['id']);
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                      screen: ViewTenant(
                                          tenantId: selectedTenantId),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Container(
                                        decoration: BoxDecoration(
                                            color: primaryDarkColor
                                                .withOpacity(0.1),
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
                                          MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'House Number:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  '${tenantList[index]['house_number']}'),
                                            ],
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: primaryDarkColor
                                                      .withOpacity(0.1)),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 2,
                                                    bottom: 2),
                                                child: Text(
                                                  'View rent statement',
                                                  style: TextStyle(
                                                      color: primaryDarkColor,
                                                      fontSize: 12),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Color.fromARGB(255, 219, 218, 218),
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
