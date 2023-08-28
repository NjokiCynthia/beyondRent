import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/property/add_tenant.dart';

int _selectedIndex = 0;
List unitList = [];

// This widget represents the modal content and its state
class AddUnitsModalContent extends StatefulWidget {
  const AddUnitsModalContent({super.key});

  @override
  _AddUnitsModalContentState createState() => _AddUnitsModalContentState();
}

class _AddUnitsModalContentState extends State<AddUnitsModalContent> {
  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.king_bed_rounded,
                  color: Color.fromRGBO(13, 201, 150, 1),
                ),
                SizedBox(width: 10),
                Text('Bedrooms'),
              ],
            ),
            const SizedBox(height: 10),
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
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.money_off,
                  color: Color.fromRGBO(13, 201, 150, 1),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Price of unit'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: bodyText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Price of the unit',
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
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.numbers,
                  color: Color.fromRGBO(13, 201, 150, 1),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Number of similar units'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: bodyText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Number of units',
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  unitList.add({
                    'bedrooms': 1,
                    'price': 2000,
                    'units': 10,
                  });
                });
                print('unitList');
                print(unitList);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mintyGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Complete',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      StepPage1(
        currentPageIndex: _currentPageIndex,
        pageController: _pageController,
      ),
      StepPage2(
        currentPageIndex: _currentPageIndex,
        pageController: _pageController,
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Add Property and Tenants',
                style: AppTextStyles.smallHeaderSlightlyBold,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStepIndicator(0),
                  const SizedBox(width: 8),
                  _buildStepIndicator(1),
                  const SizedBox(width: 8),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int stepIndex) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: _currentPageIndex >= stepIndex
              ? mintyGreen
              : mintyGreen.withOpacity(0.2),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class StepPage1 extends StatefulWidget {
  final int currentPageIndex;
  final PageController pageController;

  const StepPage1(
      {super.key,
      required this.currentPageIndex,
      required this.pageController});

  @override
  _StepPage1State createState() => _StepPage1State();
}

class _StepPage1State extends State<StepPage1> {
  String _selectedPaymentOption;

  _StepPage1State() : _selectedPaymentOption = 'mpesa';

  bool _modalState = false;

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController;

    Widget addUnitsModal = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter property name',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: bodyText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Property Name',
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
          height: 10,
        ),
        const Row(
          children: [
            Icon(Icons.king_bed_rounded,
                color: Color.fromRGBO(13, 201, 150, 1), size: 15),
            SizedBox(
              width: 10,
            ),
            Text('Bedrooms'),
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
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.home,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Property name'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Property Name',
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
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.numbers,
                    color: Color.fromRGBO(13, 201, 150, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Add property units'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(unitList.length, (index) {
                  int bedrooms = unitList[index]['bedrooms'];
                  int price = unitList[index]['price'];
                  int units = unitList[index]['units'];

                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: mintyGreen,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    width: MediaQuery.of(context).size.width / 2 -
                        50, // Two items per row
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bedrooms: $bedrooms',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'Price: $price',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'Units: $units',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showBottomModal(
                    context,
                    const AddUnitsModalContent(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: mintyGreen,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          '+',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      Text(
                        'Add unit',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(
                Icons.payment,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Payment options'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio(
                value: 'mpesa',
                groupValue: _selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentOption = value!;
                  });
                },
              ),
              const Text(
                'M-Pesa',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mintyGreen),
              onPressed: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {});
              },
              child: const Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}
