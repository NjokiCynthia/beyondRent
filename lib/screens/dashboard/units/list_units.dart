import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/utilities/data_caching.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/screens/dashboard/units/add_unit.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:x_rent/screens/dashboard/units/unit_details.dart';

class Units extends StatefulWidget {
  const Units({Key? key}) : super(key: key);

  @override
  State<Units> createState() => _UnitsState();
}

class _UnitsState extends State<Units> {
  bool unitDetailsLoading = true;
  Map<String, dynamic> responseData = {};
  bool unitsFetched = false;

  fetchUnitDetails() async {
    print('I am here to fetch unit details');
    setState(() {
      unitDetailsLoading = true;
    });

    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final postData = {
      "property_id": propertyProvider.property?.id,
    };

    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await apiClient.post(
          '/mobile/units/get_units_information', postData,
          headers: headers);

      responseData = response['response'];

      var status = responseData['status'];
      print('here is my response for unit details');
      print(response);

      if (status == 1) {
        var units = responseData['units'];

        setState(() {
          propertyUnitsList = units;
          // Update other UI elements with the new data
          // For example, you can access other values like this:
          var totalUnits = responseData['total_units'];
          var totalVacantUnits = responseData['total_vacant_units'];
          // Update UI elements with totalUnits and totalVacantUnits
        });
      } else {
        // Handle other status cases if needed
      }
    } catch (e) {
      // Handle the error
      // You might want to log or display an error message
    } finally {
      setState(() {
        unitDetailsLoading = false;
      });
    }
  }

  bool unitsLoading = true;

  fetchPropertyUnits() async {
    print('I am here to fetch property units');
    setState(() {
      unitsLoading = true;
    });
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final postData = {
      "property_id": propertyProvider.property?.id,
      // "lower_limit": 0,
      // "upper_limit": 20
    };

    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      await apiClient
          .post('/mobile/units/get_all', postData, headers: headers)
          .then((response) {
        var status = response['response']['status'];
        if (status == 1) {
          var units = response['response']['units'];
          print('here is my response for units list');
          print(response);
          setState(() {
            propertyUnitsList = units;
          });
        }
      }).catchError((error) {
        // Handle the error
        return;
      });
      setState(() {
        unitsLoading = false;
      });
    } catch (e) {
      setState(() {
        unitsLoading = false;
      });
    }
  }

  Future<void> _refreshUnits(BuildContext context) async {
    // Fetch units data here
    await fetchPropertyUnits();
  }

  @override
  void initState() {
    super.initState();
    fetchUnitDetails();

    fetchPropertyUnits();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              DashboardAppbar(
                headerText: 'Units',
                headerBody: '',
                leftHeader: 1,
                icon: GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const AddUnit(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    ).then(
                      (_) => setState(() {
                        fetchPropertyUnits();
                      }),
                    );
                  },
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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Add Unit',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                callback: (value) {},
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                        top: false,
                        child: Container(
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
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          // margin: const EdgeInsets.only(
                          //   top: 40,
                          //   bottom: 20,
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  'Total number of units',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  '${responseData['total_units'] ?? '0'}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              const SizedBox(height: 10),
                              //const ProgressBar(progress: 0),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Occupied units',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    'Vacant units',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${responseData['total_occupied_units'] ?? '0'}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    '${responseData['total_vacant_units'] ?? '0'}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Total number of tenants:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                  ),
                                  Text(
                                    ' ${responseData['total_tenants'] ?? '0'}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              // Text(
                              //   'Total number of tenants: ${responseData['total_tenants'] ?? '0'}',
                              //   style: Theme.of(context).textTheme.bodyLarge,
                              // ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        )),
                    const SizedBox(height: 10),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _refreshUnits(context),
                        child: unitsLoading == true
                            ? Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: mintyGreen,
                                  ),
                                ),
                              )
                            : propertyUnitsList.isEmpty
                                ? const Center(
                                    child: EmptyUnits(),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: propertyUnitsList.length,
                                    itemBuilder: (context, index) {
                                      return UnitWidget(
                                        id: num.parse(
                                            propertyUnitsList[index]['id']),
                                        unitNo: propertyUnitsList[index]
                                            ['house_number'],
                                        name: propertyUnitsList[index]
                                            ['house_number'],
                                        tenant: propertyUnitsList[index]
                                            ['tenant_id'],
                                        callback: (value) {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: UnitDetails(
                                                unitID: value['id'],
                                                unitNo: value['unitNo'],
                                                tenantID: value['tenant']),
                                            withNavBar: false,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          ).then(
                                            (_) => setState(() {
                                              fetchPropertyUnits();
                                            }),
                                          );
                                        },
                                      );
                                    },
                                  ),
                      ),
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
