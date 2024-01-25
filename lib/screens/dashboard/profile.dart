import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_rent/constants/color_contants.dart';
import 'package:x_rent/providers/property_provider.dart';
import 'package:x_rent/screens/billing/add_supplementary_bill.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/screens/authentication/login.dart';
import 'package:x_rent/screens/dashboard/profile/communicate.dart';
import 'package:x_rent/screens/billing/add_rent.dart';
import 'package:x_rent/property/property.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey.withOpacity(0.1),
    ));
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final propertyProvider = Provider.of<PropertyProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -40),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/icons/user.png'),
                                  radius: 50,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  // '${propertyProvider.property?.propertyName ?? ''}',
                                  '${userProvider.user!.firstName} ${userProvider.user!.lastName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.phone,
                            color: primaryDarkColor,
                          ),
                        ),
                        title: Text(
                          userProvider.user!.phone,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: primaryDarkColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.location_city,
                            color: primaryDarkColor,
                          ),
                        ),
                        title: const Text(
                          'Nairobi',
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const AddRent(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.money_off,
                          color: primaryDarkColor,
                        ),
                      ),
                      subtitle: const Text(
                        'Add / Manage rent bills',
                      ),
                      title: const Text(
                        'Rent bill set up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const SupplementaryBill(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.money_off,
                          color: primaryDarkColor,
                        ),
                      ),
                      subtitle: const Text(
                        'Add / Manage supplementary bills',
                      ),
                      title: const Text(
                        'Bill Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const Communicate(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: primaryDarkColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.email,
                          color: primaryDarkColor,
                        ),
                      ),
                      title: const Text(
                        'Communicate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Communicate to tenants (SMS)',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),

                // GestureDetector(
                //   onTap: () {
                //     PersistentNavBarNavigator.pushNewScreen(
                //       context,
                //       screen: const Property(),
                //       withNavBar: false,
                //       pageTransitionAnimation:
                //           PageTransitionAnimation.cupertino,
                //     );
                //   },
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(
                //           10.0), // Adjust the radius as needed
                //     ),
                //     child: ListTile(
                //       leading: Container(
                //         decoration: BoxDecoration(
                //           color: primaryDarkColor.withOpacity(0.1),
                //           shape: BoxShape.circle,
                //         ),
                //         padding: const EdgeInsets.all(8),
                //         child: const Icon(
                //           Icons.house,
                //           color: primaryDarkColor,
                //         ),
                //       ),
                //       title: const Text(
                //         'Properties',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       subtitle: const Text('Add a new property'),
                //       trailing: const Icon(Icons.arrow_forward_ios),
                //     ),
                //   ),
                // ),

                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10.0),
                //   ),
                //   child: ListTile(
                //     leading: Container(
                //       decoration: BoxDecoration(
                //         color: primaryDarkColor.withOpacity(0.1),
                //         shape: BoxShape.circle,
                //       ),
                //       padding: const EdgeInsets.all(8),
                //       child:
                //           const Icon(Icons.language, color: primaryDarkColor),
                //     ),
                //     title: const Text(
                //       'Language',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     subtitle: const Text('Chosen Language: English'),
                //     trailing: const Icon(Icons.arrow_forward_ios),
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ), // To fill the remaining space
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20), // Adjust spacing from the bottom
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add your logout functionality here
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const Login(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      icon: const Icon(Icons.exit_to_app, color: Colors.red),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red.withOpacity(0.8)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
