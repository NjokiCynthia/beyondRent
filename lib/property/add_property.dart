import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/add_tenant.dart';
import 'package:x_rent/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X Rent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddProperty(),
    );
  }
}

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
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
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Text(
                  'Add Property and Tenants',
                  style: AppTextStyles.smallHeaderSlightlyBold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStepIndicator(0),
                    SizedBox(width: 8),
                    _buildStepIndicator(1),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: _pages,
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

  StepPage1({required this.currentPageIndex, required this.pageController});

  @override
  _StepPage1State createState() => _StepPage1State();
}

class _StepPage1State extends State<StepPage1> {
  int _selectedIndex = 0;
  String _selectedPaymentOption = '';

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _currentPageIndex = widget.currentPageIndex;
    PageController _pageController = widget.pageController;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Icon(Icons.home),
              SizedBox(
                width: 10,
              ),
              Text('Enter Property name'),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Property Name',
              labelStyle: MyTheme.darkTheme.textTheme.bodyLarge!
                  .copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(
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
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Icon(Icons.numbers),
              SizedBox(
                width: 10,
              ),
              Text('Number of blocks'),
            ],
          ),
          SizedBox(
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
                borderSide: BorderSide(
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
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Icon(Icons.king_bed_rounded),
              SizedBox(
                width: 10,
              ),
              Text('Bedrooms'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
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
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
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
          SizedBox(height: 24),
          Row(
            children: [
              Icon(Icons.money_off),
              SizedBox(
                width: 10,
              ),
              Text('Price of the unit'),
            ],
          ),
          SizedBox(
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
                borderSide: BorderSide(
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
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Icon(Icons.payment),
              SizedBox(
                width: 10,
              ),
              Text('Payment options'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio(
                value: 'mpesa',
                groupValue: _selectedPaymentOption,
                onChanged: (value) {},
              ),
              Text(
                'M-Pesa',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mintyGreen),
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  _currentPageIndex = 1;
                });
              },
              child: Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}
