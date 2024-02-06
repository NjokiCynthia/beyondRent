import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/screens/dashboard/tenant/tenant_details.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/data_caching.dart';
import 'package:x_rent/utilities/widgets.dart';

class ListTenants extends StatefulWidget {
  const ListTenants({super.key});

  @override
  State<ListTenants> createState() => _ListTenantsState();
}

class _ListTenantsState extends State<ListTenants> {
  bool tenantListLoading = true;
  List selectedTenants = [2];
  // Key for caching the tenant list
  static const String CACHE_KEY_TENANT_LIST = 'cachedTenantList';

  fetchTenantsList() async {
    print('Fetching tenant list');
    if (_mounted) {
      setState(() {
        tenantListLoading = true;
      });
    }
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
    try {
      // Check if cached data exists for property units
      final cachedData =
          await DataCacheManager.loadDataFromCache(CACHE_KEY_TENANT_LIST);

      if (cachedData != null && _mounted) {
        // Data exists in cache, load it
        setState(() {
          tenantsList = cachedData as List;
        });
      } else {
        // No cached data, fetch from API
        final apiClient = ApiClient();
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        final response = await apiClient
            .post('/mobile/tenants/get_all', postData, headers: headers);

        var status = response['response']['status'];
        if (status == 1) {
          print('These are my tenants below here >>>>>>>>>>>');
          print(response['response']['tenants']);
          var tenants = response['response']['tenants'];
          // Cache the fetched data

          await DataCacheManager.saveDataToCache(
              CACHE_KEY_TENANT_LIST, tenants);
          if (_mounted) {
            setState(() {
              tenantsList = tenants;
            });
          }
          print('this are my tenants fetched from the api');
          print(response['response']['tenants']);
        }
      }
    } catch (e) {
      if (_mounted) {
        setState(() {
          tenantListLoading = false;
        });
      }
    } finally {
      if (_mounted) {
        setState(() {
          tenantListLoading = false;
        });
      }
    }
  }

  bool _mounted = false;
  bool tenantsFetched = false;
  @override
  void initState() {
    super.initState();
    _mounted = true;
    if (!tenantsFetched) {
      fetchTenantsList();
      tenantsFetched = true;
    }
  }

  @override
  void dispose() {
    // Clear the cached data when the widget is disposed
    DataCacheManager.clearCache(CACHE_KEY_TENANT_LIST);
    _mounted = false;
    super.dispose();
  }

  Future<void> onRefresh() async {
    // Explicitly refresh data from API
    await fetchTenantsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor.withOpacity(0.02),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Navigate back to the home screen
            Navigator.popUntil(context, (route) => true);
            bottomNavigationController.jumpToTab(0);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 114, 198, 117),
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
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
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
                  child: Row(children: [
                    Text(
                      'Total Tenants: ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '           ${tenantsList.length}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RefreshIndicator(
                      onRefresh: onRefresh,
                      child: tenantListLoading == true
                          ? Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: mintyGreen,
                                ),
                              ),
                            )
                          : (tenantsList.isEmpty
                              ? Center(child: const EmptyTenants())
                              : ListView.builder(
                                  itemCount: tenantsList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              final selectedTenantId =
                                                  int.parse(
                                                      tenantsList[index]['id']);
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${tenantsList[index]['first_name']} ${tenantsList[index]['last_name']}',
                                                  ),
                                                  Text(
                                                    '${tenantsList[index]['phone']}',
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
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            '${tenantsList[index]['house_number']}'),
                                                      ],
                                                    ),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color:
                                                                primaryDarkColor
                                                                    .withOpacity(
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
                                  }))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
