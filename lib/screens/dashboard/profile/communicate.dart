// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:x_rent/constants/theme.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Communicate extends StatefulWidget {
  const Communicate({super.key});

  @override
  CommunicateState createState() {
    return CommunicateState();
  }
}

class CommunicateState extends State<Communicate> {
  bool tenantListLoaded = false;
  List tenantList = [];
  List selectedTenants = [2];

  Future<void> fetchTenants() async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    final token = userProvider.user?.token;

    final postData = {"property_id": propertyProvider.property?.id};
    final apiClient = ApiClient();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await apiClient.post('/mobile/tenants/get_all', postData,
          headers: headers);
      var responseStatus = response['response']['status'];
      if (responseStatus == 1) {
        setState(() {
          tenantList = response['response']['tenants'];
        });
      }
    } catch (e) {
      print('Error');
      print(e);
    }
    setState(() {
      tenantListLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTenants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardAppbar(
                backButton: true,
                backButtonText: 'Communicate',
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Enter Title',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: bodyText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Title',
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
              Text(
                'Enter Message',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              TextFormField(
                minLines: 3, // Set this
                maxLines: 6,
                style: bodyText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Message',
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
              Text(
                'Select tenants below',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              tenantListLoaded == false
                  ? Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: mintyGreen,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: tenantList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedTenants.contains(index)) {
                                selectedTenants.remove(index);
                              } else {
                                selectedTenants.add(index);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selectedTenants.contains(index)
                                  ? mintyGreen.withValues(alpha: 0.2)
                                  : Colors.grey.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '${tenantList[index]['first_name']} ${tenantList[index]['last_name']}',
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 50),
              CustomRequestButton(
                url: null,
                method: 'POST',
                buttonText: 'Send',
                body: const {},
                onSuccess: (res) {
                  Navigator.pop(context);
                  showToast(
                    'Success!',
                    'Message sent successfully',
                    mintyGreen,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
