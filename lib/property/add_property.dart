import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/property/step2.dart';
import 'package:x_rent/property/step3.dart';
import 'package:provider/provider.dart';

int _selectedIndex = 0;
List unitList = [];
int _currentPageIndex = 0;

class AddUnitsModalContent extends StatefulWidget {
  const AddUnitsModalContent({super.key});

  @override
  State<AddUnitsModalContent> createState() => _AddUnitsModalContentState();
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
  PageController propertyPageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      StepPage1(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      ),
      StepPage2(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      ),
      StepPage3(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
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
                'Add Property and Units',
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
                  _buildStepIndicator(2),
                  const SizedBox(width: 8),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: propertyPageController,
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
  const StepPage1({
    super.key,
    required this.currentPageIndex,
    required this.pageController,
  });

  @override
  State<StepPage1> createState() => _StepPage1State();
}

class _StepPage1State extends State<StepPage1> {
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyLocationController =
      TextEditingController();

  bool buttonError = true;
  String buttonErrorMessage = 'Enter all fields';

  bool propertySaveLoading = false;

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  propertyInputValidator() async {
    if (propertyNameController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter property name';
      });
      return false;
    } else if (propertyLocationController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter property location';
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

  addNewProperty() async {
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    final token = userProvider.user?.token;

    final postData = {
      "property_name": propertyNameController.text,
      "location": propertyLocationController.text,
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Cookie':
          'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=oe8mu4ln2bs4t5n92ftedn4tqc6f3gue; identity=${userProvider.user?.phone}; remember_code=hRI1OErZyTwhcw63t98Wl.'
    };
    await apiClient
        .post('/mobile/create_property', postData, headers: headers)
        .then((response) {
      var propertyReturned = response['response']['user_groups'][0];

      if (response['response']['status'] == 1) {
        propertyProvider.setProperty(
          Property(
            propertyName: propertyReturned['name'],
            propertyLocation: '',
            id: propertyReturned['id'],
          ),
        );
        return true;
      }
      return false;
    }).catchError((error) {
      // Handle the error
      return false;
    });
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
            controller: propertyNameController,
            onChanged: (value) {
              propertyInputValidator();
            },
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
              Icon(
                Icons.location_on,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Property Location'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              propertyInputValidator();
            },
            controller: propertyLocationController,
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Property Location',
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
          const SizedBox(height: 24),
          CustomRequestButton(
            cookie:
                'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=tef1t2q70l8nkdmqr5d983mfkfg54fac; identity=254721882678; remember_code=vOFnAK1LX8aLxVdAVbxQ0O',
            authorization: 'Bearer ${userProvider.user?.token}',
            buttonError: buttonError,
            buttonErrorMessage: buttonErrorMessage,
            url: '/mobile/create_property',
            method: 'POST',
            buttonText: 'Proceed',
            body: {
              "property_name": propertyNameController.text,
              "location": propertyLocationController.text,
            },
            onSuccess: (res) {
              if (res['isSuccessful'] == true) {
                var propertyReturned =
                    res['data']['response']['user_groups'][0];

                if (res['data']['response']['status'] == 1) {
                  propertyProvider.setProperty(
                    Property(
                      propertyName: propertyReturned['name'],
                      propertyLocation: '',
                      id: propertyReturned['id'],
                    ),
                  );
                  // Add the property to list of properties
                  final userPropertyListProvider =
                      Provider.of<PropertyListProvider>(
                    context,
                    listen: false,
                  );
                  Property property = Property(
                    propertyName: propertyReturned['name'],
                    propertyLocation: '',
                    id: propertyReturned['id'],
                  );
                  userPropertyListProvider.addProperty(property);

                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
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
        ],
      ),
    );
  }
}
