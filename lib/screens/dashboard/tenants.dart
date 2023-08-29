import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';

class Tenants extends StatefulWidget {
  const Tenants({Key? key}) : super(key: key);

  @override
  State<Tenants> createState() => _TenantsState();
}

class _TenantsState extends State<Tenants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              DashboardAppbar(
                headerText: 'Tenants',
                headerBody: 'Tenants who have paid: 43',
                leftHeader: 1,
                icon: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AddProperty()),
                    // );
                  },
                  child: const Icon(
                    Icons.group_add,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                callback: (value) {},
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: EmptyTenants(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
