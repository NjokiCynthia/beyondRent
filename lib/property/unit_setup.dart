import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

List unitsToSend = [];
List unitsForStep3 = [];

class AddUnits extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;

  const AddUnits({
    super.key,
    this.fromPage,
    required this.currentPageIndex,
    required this.pageController,
  });

  @override
  _AddUnitsState createState() => _AddUnitsState();
}

class _AddUnitsState extends State<AddUnits> {
  bool propertySaveLoading = false;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';

  final TextEditingController unitNoController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();
  final TextEditingController blockNoController = TextEditingController();

  // unit types
  bool studioActive = false;
  bool oneBedroom = false;
  bool twoBedroom = false;
  bool threeBedroom = false;
  bool fourBedroom = false;
  bool fiveBedroom = false;
  bool sixBedroom = false;
  bool sevenBedroom = false;

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all fields';

  List<String> createNumberArray(int n) {
    List<String> numberArray = [];
    for (int i = 1; i <= n; i++) {
      String numberString;
      if (blockNoController.text.isNotEmpty) {
        numberString = '${blockNoController.text}-$i';
        numberArray.add(numberString);
      } else {
        numberString = 'A-$i';
        numberArray.add(numberString);
      }
    }
    setState(() {
      unitsToSend = numberArray;
    });
    print(
        'unitsToSend ----------------------------------------------------------------');
    print(unitsToSend);
    return numberArray;
  }

  propertyInputValidator() async {
    if (blockNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter property block';
      });
      return false;
    } else if (floorNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter number of floors';
      });
      return false;
    } else if (unitNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter number of units';
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

  @override
  void initState() {
    super.initState();
    //propertyInputValidator();
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    PageController pageController = widget.pageController!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          if (buttonError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                buttonErrorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Block.'),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          print('done');
                          propertyInputValidator();
                          if (unitNoController.text.isNotEmpty) {
                            print('are we here');
                            createNumberArray(int.parse(unitNoController.text));
                          }
                        },
                        controller: blockNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter block',
                          labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
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
                      const Text('No. of floors'),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          propertyInputValidator();
                        },
                        controller: floorNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter number of floors',
                          labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
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
                      const Text('No. of units'),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          propertyInputValidator();
                          List<String> result = createNumberArray(
                            int.parse(value),
                          );
                        },
                        controller: unitNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter number of units',
                          labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
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
              SizedBox(width: 10),
              Text('Select type of units'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        studioActive = !studioActive;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: studioActive == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        'Studio',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: studioActive == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        oneBedroom = !oneBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: oneBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '1',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: oneBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        twoBedroom = !twoBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: twoBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '2',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: twoBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        threeBedroom = !threeBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: threeBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '3',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: threeBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        fourBedroom = !fourBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: fourBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '4',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: fourBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        fiveBedroom = !fiveBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: fiveBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '5',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: fiveBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sixBedroom = !sixBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: sixBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '6',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: sixBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sevenBedroom = !sevenBedroom;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: sevenBedroom == true
                              ? mintyGreen
                              : Colors.grey.withOpacity(0.2)),
                      child: Text(
                        '7',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: sevenBedroom == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: CustomRequestButton(
              cookie:
                  'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
              authorization: 'Bearer ${userProvider.user?.token}',
              buttonError: buttonError,
              buttonErrorMessage: buttonErrorMessage,
              url: '/mobile/units/batch_create',
              method: 'POST',
              buttonText: 'Proceed',
              body: {
                "property_id": propertyProvider.property?.id,
                "house_numbers": unitsToSend,
                "house_types": const [1, 2, 3, 4],
                "blocks": const [1, 1, 1, 2],
                "floor": const [1, 2, 3, 4, 5, 6],
                "tenant_id": const [0, 0, 0, 0],
                "contribution_id": const [0, 0, 0, 0]
              },
              onSuccess: (res) {
                if (!buttonError) {
                  print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
                  print(res);
                  if (res['isSuccessful'] == true) {
                    var response = res['data']['response']['status'];
                    if (response == 1) {
                      setState(() {
                        unitsForStep3 = res['data']['response']['units'];
                      });
                      pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      showToast(
                        context,
                        'Error!',
                        res['data']['response']['message'],
                        Colors.red,
                      );
                    }
                  } else {
                    showToast(
                      context,
                      'Error!',
                      "Error saving unit",
                      Colors.red,
                    );
                  }
                }
              },
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: CustomRequestButton(
          //         cookie:
          //             'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
          //         authorization: 'Bearer ${userProvider.user?.token}',
          //         buttonError: buttonError,
          //         buttonErrorMessage: buttonErrorMessage,
          //         url: null,
          //         method: 'POST',
          //         buttonText: 'Skip',
          //         body: {
          //           "property_id": propertyProvider.property?.id,
          //           "house_numbers": unitsToSend,
          //           "house_types": const [1, 1, 2],
          //           "blocks": const [1, 1, 1, 2],
          //           "floor": const [2, 2, 3, 3],
          //           "tenant_id": const [0, 0, 0, 0],
          //           "contribution_id": const [0, 0, 0, 0]
          //         },
          //         onSuccess: (res) {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: ((context) => const Dashboard()),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //     Expanded(
          //         child: Container(
          //       margin: const EdgeInsets.only(left: 10),
          //       child: CustomRequestButton(
          //         cookie:
          //             'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
          //         authorization: 'Bearer ${userProvider.user?.token}',
          //         buttonError: buttonError,
          //         buttonErrorMessage: buttonErrorMessage,
          //         url: '/mobile/units/batch_create',
          //         method: 'POST',
          //         buttonText: 'Proceed',
          //         body: {
          //           "property_id": propertyProvider.property?.id,
          //           "house_numbers": unitsToSend,
          //           "house_types": const [1, 2, 3, 4],
          //           "blocks": const [1, 1, 1, 2],
          //           "floor": const [1, 2, 3, 4, 5, 6],
          //           "tenant_id": const [0, 0, 0, 0],
          //           "contribution_id": const [0, 0, 0, 0]
          //         },
          //         onSuccess: (res) {
          //           print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
          //           print(res);
          //           if (res['isSuccessful'] == true) {
          //             var response = res['data']['response']['status'];
          //             if (response == 1) {
          //               setState(() {
          //                 unitsForStep3 = res['data']['response']['units'];
          //               });
          //               pageController.animateToPage(
          //                 2,
          //                 duration: const Duration(milliseconds: 300),
          //                 curve: Curves.easeInOut,
          //               );
          //             } else {
          //               showToast(
          //                 context,
          //                 'Error!',
          //                 res['data']['response']['message'],
          //                 Colors.red,
          //               );
          //             }
          //           } else {
          //             showToast(
          //               context,
          //               'Error!',
          //               "Error saving unit",
          //               Colors.red,
          //             );
          //           }
          //         },
          //       ),
          //     ))
          //   ],
          // ),
        ],
      ),
    );
  }
}
