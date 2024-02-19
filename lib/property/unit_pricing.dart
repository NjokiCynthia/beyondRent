import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';


class UnitPricing extends StatefulWidget {
  final String? fromPage;
  final int? currentPageIndex;
  final PageController? pageController;
  const UnitPricing(
      {super.key, this.fromPage, this.currentPageIndex, this.pageController});

  @override
  State<UnitPricing> createState() => _UnitPricingState();
}

class _UnitPricingState extends State<UnitPricing> {
  String? selectedUnitType;

  Future<void> _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Assign unit types to the houses'),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: selectedUnitType,
                items: [
                  'Bedsitter',
                  '1-bedroom',
                  '2-bedroom',
                  '3-bedroom',
                  '4-bedroom',
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedUnitType = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Select unit type',
                  labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
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
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(width: 1.0, color: primaryDarkColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: primaryDarkColor),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  final List<String> unitTypes = [
    'Bedsitter',
    '1-bedroom',
    '2-bedroom',
    '3-bedroom',
    '4-bedroom'
  ];
  final Random random = Random();

  String getRandomUnitType() {
    return unitTypes[random.nextInt(unitTypes.length)];
  }

  int getPriceForUnitType(String unitType) {
    switch (unitType) {
      case 'Bedsitter':
        return 10000;
      case '1-bedroom':
        return 11000;
      case '2-bedroom':
        return 12000;
      case '3-bedroom':
        return 13000;
      case '4-bedroom':
        return 14000;
      default:
        return 0; // Default price if unit type is not recognized
    }
  }

  final List<String> unitLetters = ['A', 'B'];
  List<bool> _selectedItems = List.filled(10, false);

  @override
  Widget build(BuildContext context) {
   
    PageController pageController = widget.pageController!;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  String unitNumber =
                      '${unitLetters[index % 2]}${(index ~/ 2) + 1}';
                  String unitType = getRandomUnitType();
                  int unitPrice = getPriceForUnitType(unitType);
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CheckboxListTile(
                            activeColor: primaryDarkColor,
                            dense: true,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'House number',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    ),
                                    Text(
                                      unitNumber,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      unitType,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5),
                                    ),
                                    Text(
                                      'KES ${unitPrice}',
                                      // 'KES 10,000',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            value: _selectedItems[index],
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedItems[index] = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          //if (_selectedItems.contains(true))
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    pageController.animateToPage(
                      4,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Proceed')))
        ],
      ),
      floatingActionButton: _selectedItems.contains(true)
          ? Align(
              alignment: const Alignment(1.0, 0.85),
              child: FloatingActionButton(
                backgroundColor: primaryDarkColor,
                onPressed: () {
                  _showBottomSheet(context);
                },
                tooltip: 'Open Alert',
                child: const Icon(Icons.arrow_circle_up_sharp),
              ),
            )
          : null,
    );
  }
}
