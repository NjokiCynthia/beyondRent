import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DashboardAppbar(
                headerText: 'My Profile',
                headerBody: 'Last updated two weeks ago',
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              SizedBox(
                height: 20, // Adjust spacing between header and card
              ), // Adjust the spacing
              Card(
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -30),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
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
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('+254797181989'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('njoki@example.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text('Nairobi'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Adjust the spacing
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  title: Text(
                    'Reminders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Never miss the rent due date'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(
                height: 30, // Adjust spacing between card and reminders card
              ),

              Card(
                elevation: 4,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.language,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  title: Text(
                    'Language',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Chosen Language: English'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Spacer(), // To fill the remaining space
              Padding(
                padding: EdgeInsets.only(
                    bottom: 20), // Adjust spacing from the bottom
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your logout functionality here
                    },
                    icon: Icon(Icons.exit_to_app, color: Colors.red),
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
