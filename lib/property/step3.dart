import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/property/add_property.dart';

class StepPage3 extends StatefulWidget {
  final int currentPageIndex;
  final PageController pageController;

  const StepPage3(
      {super.key,
      required this.currentPageIndex,
      required this.pageController});

  @override
  _StepPage3State createState() => _StepPage3State();
}

class _StepPage3State extends State<StepPage3> {
  int _selectedIndex = 0;

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
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
              Icon(
                Icons.person_2,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Tenant name'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Tenant Name',
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
                Icons.email,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Enter Tenant email address'),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: bodyText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email address',
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
                Icons.phone,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Phone Number'),
            ],
          ),
          const SizedBox(height: 10),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {},
            onInputValidated: (bool value) {},
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 10,
            ),
            textStyle: bodyText,
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: number,
            textAlignVertical: TextAlignVertical.top,
            textFieldController: controller,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            maxLength: 10,
            inputBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Phone number',
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
            onSaved: (PhoneNumber number) {},
          ),
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.holiday_village,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Block occupied by tenant'),
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
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              Icon(
                Icons.king_bed_rounded,
                color: Color.fromRGBO(13, 201, 150, 1),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Unit occupied by tenant'),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Dashboard()),
                  ),
                );
                pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Confirm'),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mintyGreen),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Dashboard()),
                  ),
                );
                pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('Skip'),
            ),
          ),
        ],
      ),
    );
  }
}
