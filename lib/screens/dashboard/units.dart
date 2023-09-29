import 'package:flutter/material.dart';
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
  bool unitsLoading = true;

  fetchPropertyUnits() async {
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
      "lower_limit": 0,
      "upper_limit": 20
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

  @override
  void initState() {
    super.initState();
    fetchPropertyUnits();
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              Expanded(
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
                                id: num.parse(propertyUnitsList[index]['id']),
                                unitNo: propertyUnitsList[index]
                                    ['house_number'],
                                name: propertyUnitsList[index]['house_number'],
                                tenant: propertyUnitsList[index]['tenant_id'],
                                callback: (value) {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: UnitDetails(
                                        unitID: value['id'],
                                        unitNo: value['unitNo'],
                                        tenantID: value['tenant']),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
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
            ],
          ),
        ),
      ),
    );
  }
}
