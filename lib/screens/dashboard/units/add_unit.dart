import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/dashboard/units.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddUnit extends StatefulWidget {
  const AddUnit({super.key});

  @override
  _AddUnitState createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  bool buttonError = true;
  String buttonErrorMessage = 'Enter all fields';
  int _selectedIndex = 0;
  bool propertySaveLoading = false;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';

  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();
  final TextEditingController blockNoController = TextEditingController();

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  propertyInputValidator() async {
    if (houseNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter house number';
      });
      return false;
    } else if (floorNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter floor number';
      });
      return false;
    } else if (blockNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter block number';
      });
      return false;
    } else {
      setState(() {
        buttonError = false;
        buttonErrorMessage = 'Enter all fields';
      });
      return true;
    }
  }

  addPropertyUnits() async {
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
      "house_number": houseNoController.text,
      "house_type": 1,
      "block": 1,
      "floor": floorNoController.text,
      "tenant_id": 0,
      "contribution_id": 0
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await apiClient.post(
        '/mobile/units/create',
        postData,
        headers: headers,
      );
      return response['response'];
    } catch (error) {
      // Handle the error
      return {"status": 7, "time": 1693485381, "message": "Error saving unit"};
    }
  }

  fetchPropertyUnits() async {
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final postData = {
      "property_id": propertyProvider.property?.id,
      "lower_limit": 0,
      "upper_limit": 10
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
          propertyUnitsList;
        }
      }).catchError((error) {
        // Handle the error
      });
    } catch (e) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    propertyInputValidator();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardAppbar(
                  backButton: true,
                  backButtonText: 'Add a unit',
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('House No.'),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: houseNoController,
                              style: bodyText,
                              onChanged: (value) {
                                propertyInputValidator();
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'House number',
                                labelStyle: MyTheme
                                    .darkTheme.textTheme.bodyLarge!
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Floor'),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: floorNoController,
                              onChanged: (value) {
                                propertyInputValidator();
                              },
                              style: bodyText,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Floor',
                                labelStyle: MyTheme
                                    .darkTheme.textTheme.bodyLarge!
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Block'),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: blockNoController,
                              onChanged: (value) {
                                propertyInputValidator();
                              },
                              style: bodyText,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Block number',
                                labelStyle: MyTheme
                                    .darkTheme.textTheme.bodyLarge!
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Icon(
                      Icons.king_bed_rounded,
                      color: Color.fromRGBO(13, 201, 150, 1),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('House type'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _selectItem(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? mintyGreen
                                  : Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                index == 0 ? 'Studio' : index.toString(),
                                style: TextStyle(
                                  color: _selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CustomRequestButton(
                          url: null,
                          method: 'POST',
                          buttonText: 'Cancel',
                          body: const {},
                          onSuccess: (res) {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CustomRequestButton(
                          cookie:
                              'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                          authorization: 'Bearer ${userProvider.user?.token}',
                          buttonError: buttonError,
                          buttonErrorMessage: buttonErrorMessage,
                          url: '/mobile/units/create',
                          method: 'POST',
                          buttonText: 'Proceed',
                          body: {
                            "property_id": propertyProvider.property?.id,
                            "house_number": houseNoController.text,
                            "house_type": 1,
                            "block": 1,
                            "floor": floorNoController.text,
                            "tenant_id": 0,
                            "contribution_id": 0
                          },
                          onSuccess: (res) {
                            if (res['isSuccessful'] == false) {
                              return showToast(
                                context,
                                'Error!',
                                res['error'],
                                Colors.red,
                              );
                            } else {
                              fetchPropertyUnits();

                              showToast(
                                context,
                                'Success!',
                                'Unit added successfully',
                                mintyGreen,
                              );

                              Future.delayed(const Duration(seconds: 2), () {
                                // Delay for 2 seconds (adjust as needed)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => Units()),
                                  ),
                                );
                              });

                              // Remove the return statement here

                              // You can optionally remove the return statement after Future.delayed,
                              // or use 'return;' to exit the function early.

                              // return; // Remove this line or replace it with 'return;'
                            }
                          },
                          // if (res['data']['response']['status'] != 1) {
                          //   return showToast(
                          //     context,
                          //     'Error!',
                          //     res['data']['message'] ??
                          //         'Error, please try again later.',
                          //     Colors.red,
                          //   );
                          // }
                          // var userData = res['data']['response']['user'];
                          // var accessToken =
                          //     res['data']['response']['access_token'];
                          // print('Access token: ' + accessToken);
                          // final userProvider = context.read<UserProvider>();
                          // userProvider.setUser(
                          //   User(
                          //     firstName: userData['first_name'],
                          //     lastName: userData['last_name'],
                          //     phone: userData['phone'],
                          //     email: userData['email'],
                          //     id: userData['id'],
                          //     token: accessToken,
                          //   ),
                          // );
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
