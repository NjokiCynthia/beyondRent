import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  bool propertiesLoading = true;
  List userPropertyList = [];

  fetchPropertiesByUser(context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;
    final userID = userProvider.user?.id;

    final postData = {
      'user_id': userID,
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
          'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=rp9tk80huscienrtaogk28hqsq9likdk; identity=254766444600; remember_code=FMdTpp.zfXw8n7qu2x9Sku'
    };
    await apiClient
        .post('/mobile/get_property_by_user', postData, headers: headers)
        .then((response) {
      var responseStatus = response['response']['status'];
      if (responseStatus == 0) {
        setState(() {
          userPropertyList = response['response']['properties'];
        });
      }
      setState(() {
        propertiesLoading = false;
      });
      return response;
    }).catchError((error) {
      // Handle the error
      print('error');
      print(error);
      setState(() {
        propertiesLoading = false;
      });
      return {
        "response": {
          "status": 4,
          "message": "Property not found",
          "time": 1693471190
        }
      };
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPropertiesByUser(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget propertyListView = ListView.builder(
      shrinkWrap: true,
      itemCount: userPropertyList.length,
      itemBuilder: (context, index) {
        print(userPropertyList[index]);
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: mintyGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Dashboard()),
                  ),
                );
              },
              child: Text(
                userPropertyList[index]['name'],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black.withOpacity(0.7), fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/icons/logo-green.png',
                      width: 40,
                    ),
                  ),
                  Text(
                    'XRent',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Choose one of your properties',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: propertiesLoading == true
                    ? Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: mintyGreen,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: userPropertyList.isEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/apartment.png',
                                            width: 250),
                                        Text(
                                          'Property list empty, hit the button below to add a property.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                : propertyListView,
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const AddProperty()),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                decoration: BoxDecoration(
                                  color: mintyGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: mintyGreen,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add property and tenant details',
                                      style: AppTextStyles.titleNormalBold
                                          .copyWith(
                                              color: mintyGreen, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
        // child: Container(
        //   margin: const EdgeInsets.only(left: 20, right: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 50),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(right: 10),
        //               child: Image.asset(
        //                 'assets/images/icons/logo-green.png',
        //                 width: 40,
        //               ),
        //             ),
        //             Text(
        //               'XRent',
        //               style: Theme.of(context)
        //                   .textTheme
        //                   .titleLarge!
        //                   .copyWith(color: Colors.black),
        //             )
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: propertiesLoading == true
        //             ? SizedBox(
        //                 child: CircularProgressIndicator(
        //                   strokeWidth: 4,
        //                   color: mintyGreen,
        //                 ),
        //               )
        //             : userPropertyList.isEmpty
        //                 ? Container(
        //                     margin: const EdgeInsets.only(left: 20, right: 20),
        //                     child: Column(
        //                       children: [
        //                         Image.asset('assets/images/apartment.png',
        //                             width: 250),
        //                         Text(
        //                           'Property list empty, hit the button below to add a property.',
        //                           style: Theme.of(context).textTheme.bodyMedium,
        //                           textAlign: TextAlign.center,
        //                         )
        //                       ],
        //                     ),
        //                   )
        //                 : propertyListView,
        //       ),
        //       const SizedBox(height: 30),
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: ((context) => const AddProperty()),
        //             ),
        //           );
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(bottom: 20),
        //           child: Container(
        //             padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //             decoration: BoxDecoration(
        //               color: mintyGreen.withOpacity(0.1),
        //               borderRadius: BorderRadius.circular(7),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Icon(
        //                   Icons.add,
        //                   color: mintyGreen,
        //                 ),
        //                 const SizedBox(
        //                   width: 5,
        //                 ),
        //                 Text(
        //                   'Add property and tenant details',
        //                   style: AppTextStyles.titleNormalBold
        //                       .copyWith(color: mintyGreen, fontSize: 13),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
