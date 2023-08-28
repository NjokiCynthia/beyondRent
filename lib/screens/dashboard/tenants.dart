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
              Expanded(
                child: ListView(
                  children: const [
                    SizedBox(height: 30),
                    TenantWidget(
                      name: 'Liam',
                      date: '22nd, Mar 2023',
                      amount: 20000,
                    ),
                    TenantWidget(
                      name: 'Sophia',
                      date: '24th, Mar 2023',
                      amount: 32000,
                    ),
                    TenantWidget(
                      name: 'Ethan',
                      date: '26th, Mar 2023',
                      amount: 25000,
                    ),
                    TenantWidget(
                      name: 'Ava',
                      date: '28th, Mar 2023',
                      amount: 30000,
                    ),
                    TenantWidget(
                      name: 'Emma',
                      date: '28th, Mar 2023',
                      amount: 25000,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
