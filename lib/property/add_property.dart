import 'package:flutter/material.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/property/account_setup.dart';
import 'package:x_rent/property/unit_pricing.dart';
import 'package:x_rent/property/unit_type_setup.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/property/unit_setup.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.king_bed_rounded,
                  color: primaryDarkColor,
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
                  color: primaryDarkColor,
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
                  color: primaryDarkColor,
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
      UnitTypes(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      ),
      AddUnits(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      ),
      UnitPricing(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      ),
      AccountSetup(
        currentPageIndex: _currentPageIndex,
        pageController: propertyPageController,
      )
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Add Property, Units and Account Details',
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
                  _buildStepIndicator(3),
                  const SizedBox(width: 8),
                  _buildStepIndicator(4),
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
                  physics: _currentPageIndex == 0 || _currentPageIndex == 1
                      //||
                      // _currentPageIndex == 2 ||
                      // _currentPageIndex == 3
                      ? const NeverScrollableScrollPhysics()
                      : const PageScrollPhysics(),
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

enum AccountSettlementOption { yes, no }

class _StepPage1State extends State<StepPage1> {
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyLocationController =
      TextEditingController();
  final TextEditingController propertyDescriptionController =
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
      // } else if (propertyDescriptionController.text == '') {
      //   setState(() {
      //     buttonError = true;
      //     buttonErrorMessage = 'Enter property description';
      //   });
      //   return false;
    } else if (propertyDescriptionController.text == '') {
      setState(() {
        buttonError = true;
        buttonErrorMessage = 'Enter the nature of property';
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

  int getNatureValue() {
    if (_selectedValue == 'Commercial') {
      return 1;
    } else if (_selectedValue == 'Residential') {
      return 2;
    } else {
      return 1;
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
          'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou'
    };
    await apiClient
        .post('/mobile/create_property', postData, headers: headers)
        .then((response) {
      var propertyReturned = response['response']['user_groups'][0];

      if (response['response']['status'] == 1) {
        print('here is my response');
        print(response);
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

  String? _selectedValue;
  bool accountSettlement = true;
  bool accountSettlementNo = false;

  AccountSettlementOption? selectedOption;
  int getAccountSettlementOptionValue() {
    if (selectedOption == AccountSettlementOption.yes) {
      return 1;
    } else if (selectedOption == AccountSettlementOption.no) {
      return 2;
    } else {
      return -1; // Default or error value
    }
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
          const Row(
            children: [
              Icon(
                Icons.home,
                color: primaryDarkColor,
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
                color: primaryDarkColor,
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
          const Row(
            children: [
              Icon(
                Icons.edit_document,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Property Description'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: (value) {
              propertyInputValidator();
            },
            controller: propertyDescriptionController,
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Property Description',
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
          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(
                Icons.house_siding_outlined,
                color: primaryDarkColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Select the nature of property'),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
            items: const [
              DropdownMenuItem(
                value: 'Commercial',
                child: Text('Commercial'),
              ),
              DropdownMenuItem(
                value: 'Residential',
                child: Text('Residential'),
              ),
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Select nature',
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

          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Do you wish to enable automatic account settlement once a tenant pays rent?',
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Radio(
                    value: AccountSettlementOption.yes,
                    groupValue: selectedOption,
                    onChanged: (AccountSettlementOption? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    activeColor: primaryDarkColor,
                  ),
                  Text(
                    "Yes",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: AccountSettlementOption.no,
                    groupValue: selectedOption,
                    onChanged: (AccountSettlementOption? value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    activeColor: primaryDarkColor,
                  ),
                  Text(
                    "No",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ],
          ),
          CustomRequestButton(
              cookie:
                  'CALLING_CODE=254; COUNTRY_CODE=KE; ci_session=t8bor7oiaqf8chjib5sl3ujo73d6mm5p; identity=254721882678; remember_code=aNU%2FwbBOfORTkMSIyi60ou',
              authorization: 'Bearer ${userProvider.user?.token}',
              buttonError: buttonError,
              buttonErrorMessage: buttonErrorMessage,
              url: '/mobile/create_property',
              method: 'POST',
              buttonText: 'Proceed',
              body: {
                "property_name": propertyNameController.text,
                "location": propertyLocationController.text,
                "description": propertyDescriptionController.text,
                "nature_of_property": getNatureValue().toString(),
                // nature_of_property = array(
                //     1 => 'Commercial',
                //     2 => 'Residential',
                // );
                "enable_automatic_account_settlement":
                    getAccountSettlementOptionValue().toString(),
                // or 0
              },
              onSuccess: (res) {
                if (!buttonError) {
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
                      showToast(
                        context,
                        'Success!',
                        res['data']['response']['message'],
                        mintyGreen,
                      );

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
                      res['data']['response']['message'],
                      Colors.red,
                    );
                  }
                } else {
                  showToast(
                    context,
                    'Error!',
                    "Please enter all fields",
                    Colors.red,
                  );
                }
              }),
        ],
      ),
    );
  }
}
