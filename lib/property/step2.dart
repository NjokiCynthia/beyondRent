import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/property/step2.dart';
import 'package:x_rent/property/step3.dart';
import 'package:provider/provider.dart';

class StepPage2 extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;

  const StepPage2({
    super.key,
    this.fromPage,
    required this.currentPageIndex,
    required this.pageController,
  });

  @override
  _StepPage2State createState() => _StepPage2State();
}

class _StepPage2State extends State<StepPage2> {
  int _selectedIndex = 0;
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

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    propertyInputValidator();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    Text('Block.'),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        propertyInputValidator();
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
                    Text('No. of floors'),
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
                    Text('No. of units'),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        propertyInputValidator();
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
        // Expanded(child: Container()),
        Row(
          children: [
            Expanded(
              child: CustomRequestButton(
                cookie:
                    'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=oe8mu4ln2bs4t5n92ftedn4tqc6f3gue; identity=${userProvider.user?.phone}; remember_code=hRI1OErZyTwhcw63t98Wl.',
                authorization: 'Bearer ${userProvider.user?.token}',
                buttonError: buttonError,
                buttonErrorMessage: buttonErrorMessage,
                url: null,
                method: 'POST',
                buttonText: 'Skip',
                body: {
                  "property_id": propertyProvider.property?.id,
                  "house_numbers": ["B1", "B2", "B3", "B4"],
                  "house_types": [1, 1, 2],
                  "blocks": [1, 1, 1, 2],
                  "floor": [2, 2, 3, 3],
                  "tenant_id": [0, 0, 0, 0],
                  "contribution_id": [0, 0, 0, 0]
                },
                onSuccess: (res) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Dashboard()),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 10),
              child: CustomRequestButton(
                cookie:
                    'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=oe8mu4ln2bs4t5n92ftedn4tqc6f3gue; identity=${userProvider.user?.phone}; remember_code=hRI1OErZyTwhcw63t98Wl.',
                authorization: 'Bearer ${userProvider.user?.token}',
                buttonError: buttonError,
                buttonErrorMessage: buttonErrorMessage,
                url: '/mobile/units/create',
                method: 'POST',
                buttonText: 'Proceed',
                body: {
                  "property_id": propertyProvider.property?.id,
                  "house_numbers": ["B1", "B2", "B3", "B4"],
                  "house_types": [1, 1, 2],
                  "blocks": [1, 1, 1, 2],
                  "floor": [2, 2, 3, 3],
                  "tenant_id": [0, 0, 0, 0],
                  "contribution_id": [0, 0, 0, 0]
                },
                onSuccess: (res) {
                  print('res ++++++++++++++');
                  print(res);
                  if (res['isSuccessful'] == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Dashboard()),
                      ),
                    );
                  } else {
                    showToast(
                      context,
                      'Error!',
                      res['error'],
                      Colors.red,
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ],
    );
  }
}
