import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class StepPage2 extends StatefulWidget {
  final int currentPageIndex;
  final PageController pageController;

  const StepPage2(
      {super.key,
      required this.currentPageIndex,
      required this.pageController});

  @override
  _StepPage2State createState() => _StepPage2State();
}

class _StepPage2State extends State<StepPage2> {
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
    print(houseNoController.text);
    print(floorNoController.text);
    print(blockNoController.text);
    if (houseNoController.text == '') {
      showToast(
        context,
        'Error!',
        'Enter house number',
        Colors.red,
      );
      return false;
    } else if (floorNoController.text == '') {
      showToast(
        context,
        'Error!',
        'Enter floor number',
        Colors.red,
      );
      return false;
    } else if (blockNoController.text == '') {
      showToast(
        context,
        'Error!',
        'Enter block number',
        Colors.red,
      );
      return false;
    }
    return true;
  }

  addPropertyDetails() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      Text('House No.'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: houseNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'House number',
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
                      Text('Floor'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: floorNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Floor',
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
                      Text('Block'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: blockNoController,
                        style: bodyText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Block number',
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
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mintyGreen),
              onPressed: () async {
                setState(() {
                  propertySaveLoading = true;
                });
                await propertyInputValidator().then((value) {
                  if (value == true) {
                    addPropertyDetails().then((value) {
                      propertyPageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  }
                });
                setState(() {
                  propertySaveLoading = false;
                });
              },
              child: Text(propertySaveLoading == true ? 'Saving' : 'Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}