import 'package:flutter/material.dart';
import 'package:x_rent/utilities/constants.dart';
import 'package:x_rent/utilities/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              SizedBox(
                height: 80,
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
                          child: const Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.jpg'),
                                radius: 50,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Cynthia Njoki',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Color.fromRGBO(13, 201, 150, 1),
                      ),
                      title: Text(
                        '+254797181989',
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.email,
                          color: Color.fromRGBO(13, 201, 150, 1)),
                      title: Text('njoki@example.com'),
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.location_city,
                        color: Color.fromRGBO(13, 201, 150, 1),
                      ),
                      title: Text('Nairobi'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Adjust the spacing
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                ),
                elevation: 4,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(13, 201, 150, 1).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
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
                  subtitle: const Text('Never miss the rent due date'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(
                height: 30, // Adjust spacing between card and reminders card
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(13, 201, 150, 1).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
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
              const Spacer(), // To fill the remaining space
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20), // Adjust spacing from the bottom
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your logout functionality here
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
    );
  }
}
