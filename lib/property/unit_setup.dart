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

  propertyInputValidator() async {
    if (blockNoController.text == '' && blockUnitsNoController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter the number of blocks and units';
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

  int? _selectedOption = 1;

  int _selectedNaming = 1;
  String? selectedItem;

  String? selectedUnit;

  String unitPreference = '1';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 20.0),
            const Text('How are your units based?'),
            const SizedBox(height: 10),
            Row(children: [
              Radio(
                value: 2,
                activeColor: primaryDarkColor,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              const Text('Floors'),
              const SizedBox(width: 20.0),
              Radio(
                value: 1,
                activeColor: primaryDarkColor,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              const Text('Blocks'),
            ]),
            const SizedBox(height: 10.0),
            const Text('What is the prefix as you name your units?'),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      activeColor: primaryDarkColor,
                      groupValue: _selectedNaming,
                      onChanged: (value) {
                        setState(() {
                          _selectedNaming = value!;
                        });
                      },
                    ),
                    Text(_selectedOption == 1
                        ? 'Blocks (eg, D1)'
                        : 'Alphabet (eg.D1)'),
                  ],
                ),
                const SizedBox(width: 20.0),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      activeColor: primaryDarkColor,
                      groupValue: _selectedNaming,
                      onChanged: (value) {
                        setState(() {
                          _selectedNaming = value!;
                        });
                      },
                    ),
                    Text(_selectedOption == 1
                        ? ' House No (eg, 1D)'
                        : 'Floors (eg.1D)'),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            Visibility(
              visible: _selectedOption == 1,
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
                  const SizedBox(
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
              visible: _selectedOption == 2,
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
                  const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            CustomRequestButton(
              cookie:
                  'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
              authorization: 'Bearer ${userProvider.user?.token}',
              //buttonError: buttonError,
              buttonErrorMessage: buttonErrorMessage,
              url: '/mobile/units/generate_units',
              method: 'POST',
              buttonText: 'Proceed',
              body: {
                "property_id": propertyProvider.property?.id,

                "number_of_floors":
                    _selectedOption == 1 ? "" : floorNoController.text,
                "unit_based_on": _selectedOption!,
                //"unit_based_on": 2, // 1 for block 2 for floor
                "number_of_blocks":
                    _selectedOption == 2 ? "" : blockNoController.text,
                "number_of_units_per_block":
                    _selectedOption == 2 ? "" : blockUnitsNoController.text,
                "number_of_units_per_floor":
                    _selectedOption == 1 ? "" : unitNoController.text,
                "floor_naming_options": _selectedNaming.toString(),
                "block_naming_options": _selectedNaming.toString(),
              },
              onSuccess: (res) {
                // Clear text controllers
                floorNoController.clear();
                blockNoController.clear();
                blockUnitsNoController.clear();
                unitNoController.clear();

                print('<<<<<<<<<<< res >>>>>>>>>>>>>>');
                print(res);
                if (res['isSuccessful'] == true) {
                  var responseData = res['data']['response'];
                  if (responseData['status'] == 1) {
                    print('Here is my response while generating units');
                    var generatedUnits = responseData['data'];
                    print(generatedUnits);
                    showToast(
                      context,
                      'Success!',
                      res['data']['response']['message'],
                      mintyGreen,
                    );

                    pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    showToast(
                      context,
                      'Error!',
                      responseData['message'],
                      Colors.red,
                    );
                  }
                } else {
                  showToast(
                    context,
                    'Error!',
                    "Error saving units",
                    Colors.red,
                  );
                }
              },
            ),
          ],
        ),
      ),

      //height: 400,
    );
  }
}
