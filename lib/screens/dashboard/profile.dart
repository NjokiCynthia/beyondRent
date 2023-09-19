import 'package:flutter/material.dart';
import 'package:x_rent/utilities/widgets.dart';
import 'package:provider/provider.dart';
import 'package:x_rent/screens/authentication/login.dart';
import 'package:x_rent/screens/dashboard/profile/communicate.dart';
import 'package:x_rent/screens/billing/add_rent.dart';
import 'package:x_rent/property/property.dart';
import 'package:x_rent/providers/user_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DashboardAppbar(
                  headerText: 'My Profile',
                  headerBody: 'Last updated two weeks ago',
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  elevation: 4,
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
                            color: const Color.fromRGBO(13, 201, 150, 1)
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.phone,
                            color: Color.fromRGBO(13, 201, 150, 1),
                          ),
                        ),
                        title: Text(
                          userProvider.user!.phone,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(13, 201, 150, 1)
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.location_city,
                            color: Color.fromRGBO(13, 201, 150, 1),
                          ),
                        ),
                        title: const Text(
                          'Nairobi',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10), // Adjust the spacing
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
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(13, 201, 150, 1)
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.house,
                          color: Color.fromRGBO(13, 201, 150, 1),
                        ),
                      ),
                      subtitle: const Text(
                        'Add / Manage rent bills',
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
                const SizedBox(
                  height: 10, // Adjust spacing between card and reminders card
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
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(13, 201, 150, 1)
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.house,
                          color: Color.fromRGBO(13, 201, 150, 1),
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
                const SizedBox(
                  height: 10, // Adjust spacing between card and reminders card
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const Property(),
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
                    elevation: 4,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(13, 201, 150, 1)
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.house,
                          color: Color.fromRGBO(13, 201, 150, 1),
                        ),
                      ),
                      title: const Text(
                        'Properties',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('Add a new property'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10, // Adjust spacing between card and reminders card
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(13, 201, 150, 1)
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.notifications,
                        color: Color.fromRGBO(13, 201, 150, 1),
                      ),
                    ),
                    title: const Text(
                      'Reminders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('Send out rent reminders'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                const SizedBox(
                  height: 10, // Adjust spacing between card and reminders card
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(13, 201, 150, 1)
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.language,
                        color: Color.fromRGBO(13, 201, 150, 1),
                      ),
                    ),
                    title: const Text(
                      'Language',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('Chosen Language: English'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                        elevation: 4,
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
