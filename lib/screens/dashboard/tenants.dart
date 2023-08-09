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
              const DashboardAppbar(
                headerText: 'Tenants',
                headerBody: 'Tenants who have paid: 80',
                leftHeader: 1,
                icon: Icon(
                  Icons.group_add,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Expanded(
                child: ListView(
                  children: const [
                    SizedBox(height: 30),
                    TenantWidget(),
                    TenantWidget(),
                    TenantWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
