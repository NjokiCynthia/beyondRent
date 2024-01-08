import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:x_rent/screens/dashboard.dart';
import 'package:x_rent/property/add_property.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/providers/property_provider.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  bool propertiesLoading = true;
  List userPropertyList = [];

  fetchPropertiesByUser(context) async {
    print('I am here to fetch my properties');
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final userPropertyListProvider = Provider.of<PropertyListProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;
    final userID = userProvider.user?.id;

    final postData = {
      'user_id': userID,
    };
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await apiClient
        .post('/mobile/get_property_by_user', postData, headers: headers)
        .then((response) {
      print('Here is my properties');
      print(response);
      var responseStatus = response['response']['status'];
      if (responseStatus == 0) {
        setState(() {
          userPropertyList = response['response']['properties'];
        });
        for (var propertyData in userPropertyList) {
          Property property = Property(
            propertyName: propertyData['name'],
            propertyLocation: '',
            id: int.parse(propertyData['id']),
          );
          userPropertyListProvider.addProperty(property);
        }
      }
      setState(() {
        propertiesLoading = false;
      });
      return response;
    }).catchError((error) {
      // Handle the error
      setState(() {
        propertiesLoading = false;
      });
      return {
        "response": {
          "status": 4,
          "message": "Property not found",
          "time": 1693471190
        }
      };
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPropertiesByUser(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(247, 247, 247, 1),
    ));
    Widget propertyListView = ListView.builder(
      shrinkWrap: true,
      itemCount: userPropertyList.length,
      itemBuilder: (context, index) {
        var currentPropertyID = int.parse(userPropertyList[index]['id']);
        var currentPropertyName = userPropertyList[index]['name'];
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: mintyGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: GestureDetector(
              onTap: () async {
                final propertyProvider = Provider.of<PropertyProvider>(
                  context,
                  listen: false,
                );
                propertyProvider.setProperty(
                  Property(
                    propertyName: currentPropertyName,
                    propertyLocation: '',
                    id: currentPropertyID,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Dashboard()),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.house_rounded,
                      color: mintyGreen,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      userPropertyList[index]['name'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black.withOpacity(0.7), fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/icons/logo3.png',
                      width: 40,
                    ),
                  ),
                  Text(
                    'BeyondRent',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              userPropertyList.isEmpty
                  ? 'Add properties to display in the list'
                  : 'Choose one of your properties',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Text(
            //   'Choose one of your properties',
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: propertiesLoading == true
                    ? Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: mintyGreen,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: userPropertyList.isEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/apartment.png',
                                            width: 250),
                                        Text(
                                          'Property list empty, hit the button below to add a property.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                : propertyListView,
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const AddProperty()),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                          .copyWith(
                                              color: mintyGreen, fontSize: 13),
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
          ],
        ),
      ),
    );
  }
}
