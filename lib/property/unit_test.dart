import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
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
  final TextEditingController blockUnitsNoController = TextEditingController();

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

  int _currentStep = 0;

  List<String> createNumberArray({
    required int blocks,
    required String blockIdentifier,
    required int unitsPerBlock,
    required bool useBlockAsPrefix,
    required bool useHouseNoAsPrefix,
  }) {
    List<String> numberArray = [];
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    if (blockIdentifier.isEmpty || blocks <= 0 || unitsPerBlock <= 0) {
      // Handle the case where block identifier is empty or invalid blocks/units
      return numberArray;
    }

    for (int block = 1; block <= blocks; block++) {
      for (int unit = 1; unit <= unitsPerBlock; unit++) {
        String blockString = '';
        if (useBlockAsPrefix) {
          // Block as prefix (e.g., A1)
          blockString = '${alphabet[block - 1]}${unit}';
        } else if (useHouseNoAsPrefix) {
          // House number as prefix (e.g., 1A)
          blockString = '${unit}${alphabet[block - 1]}';
        } else {
          // Default to block as prefix
          blockString = '${alphabet[block - 1]}${unit}';
        }

        numberArray.add(blockString);
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
    } else if (blockUnitsNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter number of units per block';
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
  }

  bool _selectedOption = false;
  bool _selectedNaming = false;
  String? selectedItem;
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
    return Scaffold(
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue:
            _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
        onStepCancel:
            _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
        steps: [
          Step(
            title: const Text('Unit Details'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  // if (buttonError)
                  //   Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       buttonErrorMessage,
                  //       style: const TextStyle(
                  //         color: Colors.red,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ),
                  const Text('How are your units based?'),
                  const SizedBox(height: 10),
                  Row(children: [
                    Radio(
                      value: true,
                      activeColor: primaryDarkColor,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value as bool;
                        });
                      },
                    ),
                    Text('Floors'),
                    SizedBox(width: 20.0),
                    Radio(
                      value: false,
                      activeColor: primaryDarkColor,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value as bool;
                        });
                      },
                    ),
                    Text('Blocks'),
                  ]),
                  SizedBox(height: 10.0),
                  const Text('How do you name your units?'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Prefix:'),
                      SizedBox(width: 20.0),
                      Radio(
                        value: true,
                        activeColor: primaryDarkColor,
                        groupValue: _selectedNaming,
                        onChanged: (value) {
                          setState(() {
                            _selectedNaming = value as bool;
                          });
                        },
                      ),
                      Text(_selectedOption ? 'Alphabets' : 'Blocks(eg, A1)'),
                      SizedBox(width: 20.0),
                      Radio(
                        value: false,
                        activeColor: primaryDarkColor,
                        groupValue: _selectedNaming,
                        onChanged: (value) {
                          setState(() {
                            _selectedNaming = value as bool;
                          });
                        },
                      ),
                      Text(_selectedOption ? 'Floors' : 'House No.'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Visibility(
                    visible: !_selectedOption,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('How many blocks do you have?'),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            print('done');

                            propertyInputValidator();
                          },
                          controller: blockNoController,
                          keyboardType: TextInputType.text,
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
                        SizedBox(
                          height: 20,
                        ),
                        const Text('How many units exist in each block?'),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            propertyInputValidator();
                          },
                          controller: blockUnitsNoController,
                          keyboardType: TextInputType.text,
                          style: bodyText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Enter number of units per block',
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
                  Visibility(
                    visible: _selectedOption,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Enter the number of floors'),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            propertyInputValidator();
                          },
                          controller: floorNoController,
                          keyboardType: TextInputType.number,
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
                        SizedBox(
                          height: 20,
                        ),
                        const Text('Number of units per floor'),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            propertyInputValidator();
                          },
                          keyboardType: TextInputType.number,
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Call createNumberArray here
                      createNumberArray(
                        blocks: int.parse(blockNoController.text),
                        blockIdentifier: 'A',
                        unitsPerBlock: int.parse(blockUnitsNoController.text),
                        useBlockAsPrefix: _selectedNaming,
                        useHouseNoAsPrefix: !_selectedNaming,
                      );
                    },
                    child: Text('Proceed'),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: CustomRequestButton(
                  //     cookie:
                  //         'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
                  //     authorization: 'Bearer ${userProvider.user?.token}',
                  //     buttonError: buttonError,
                  //     buttonErrorMessage: buttonErrorMessage,
                  //     url: '/mobile/units/batch_create',
                  //     method: 'POST',
                  //     buttonText: 'Proceed',
                  //     body: {
                  //       "property_id": propertyProvider.property?.id,
                  //       "house_numbers": unitsToSend,
                  //       "house_types": const [1, 2, 3, 4],
                  //       "blocks": const [1, 1, 1, 2],
                  //       "floor": const [1, 2, 3, 4, 5, 6],
                  //       "tenant_id": const [0, 0, 0, 0],
                  //       "contribution_id": const [0, 0, 0, 0]
                  //     },
                  //     onSuccess: (res) {
                  //       if (!buttonError) {
                  //         print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
                  //         print(res);
                  //         if (res['isSuccessful'] == true) {
                  //           var response = res['data']['response']['status'];
                  //           if (response == 1) {
                  //             setState(() {
                  //               unitsForStep3 = res['data']['response']['units'];
                  //             });
                  //             showToast(
                  //               context,
                  //               'Success!',
                  //               'Unit added successfully',
                  //               mintyGreen,
                  //             );

                  //             pageController.animateToPage(
                  //               2,
                  //               duration: const Duration(milliseconds: 300),
                  //               curve: Curves.easeInOut,
                  //             );
                  //             // Future.delayed(const Duration(seconds: 2), () {
                  //             //   Navigator.push(
                  //             //     context,
                  //             //     MaterialPageRoute(
                  //             //       builder: ((context) => const Dashboard()),
                  //             //     ),
                  //             //   );
                  //             // });
                  //             // pageController.animateToPage(
                  //             //   0,
                  //             //   duration: const Duration(milliseconds: 300),
                  //             //   curve: Curves.easeInOut,
                  //             // );
                  //           } else {
                  //             showToast(
                  //               context,
                  //               'Error!',
                  //               res['data']['response']['message'],
                  //               Colors.red,
                  //             );
                  //           }
                  //         } else {
                  //           showToast(
                  //             context,
                  //             'Error!',
                  //             "Error saving unit",
                  //             Colors.red,
                  //           );
                  //         }
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            state: _currentStep == 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text('Price set'),
            content: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'enter price'),
            ),
            state: _currentStep == 1 ? StepState.editing : StepState.complete,
            isActive: _currentStep == 1,
          ),
        ],
      ),
    );
  }
}
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
