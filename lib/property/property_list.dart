import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:x_rent/utilities/constants.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  List userPropertyList = [];

  @override
  Widget build(BuildContext context) {
    Widget propertyListView = Column(
      children: [
        Text(
          'Choose one of your properties',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const Dashboard()),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            margin: const EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: mintyGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.house_outlined,
                  color: mintyGreen,
                  size: 40,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elgon Court',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black.withOpacity(0.7), fontSize: 20),
                    ),
                    Text(
                      '27 tenants',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black.withOpacity(0.6), fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const Dashboard()),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: mintyGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.house_outlined,
                  color: mintyGreen,
                  size: 40,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tsavo Aprt',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black.withOpacity(0.7), fontSize: 20),
                    ),
                    Text(
                      '55 tenants',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black.withOpacity(0.6), fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/images/icons/logo-green.png',
                        width: 40,
                      ),
                    ),
                    Text(
                      'XRent',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
              userPropertyList.isEmpty
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Image.asset('assets/images/apartment.png',
                              width: 250),
                          Text(
                            'Property list empty, hit the button below to add a property.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  : propertyListView,
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AddProperty())),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: mintyGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: mintyGreen,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Add property and tenant details',
                          style: AppTextStyles.titleNormalBold
                              .copyWith(color: mintyGreen, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
