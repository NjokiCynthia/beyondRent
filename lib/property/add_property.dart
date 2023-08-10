import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/add_tenant.dart';
import 'package:x_rent/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Rent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddProperty(),
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

  const StepPage1({super.key, required this.currentPageIndex, required this.pageController});

  @override
  _StepPage1State createState() => _StepPage1State();
}

class _StepPage1State extends State<StepPage1> {
  int _selectedIndex = 0;
  final String _selectedPaymentOption = '';

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = widget.pageController;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(Icons.home),
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
          const Row(
            children: [
              Icon(Icons.numbers),
              SizedBox(
                width: 10,
              ),
              Text('Number of blocks'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: bodyText,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Number of blocks',
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
          const Row(
            children: [
              Icon(Icons.king_bed_rounded),
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
            height: 48,
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
          const Row(
            children: [
              Icon(Icons.money_off),
              SizedBox(
                width: 10,
              ),
              Text('Price of the unit'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(Icons.payment),
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
                onChanged: (value) {},
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
                setState(() {
                });
              },
              child: const Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}
