import 'package:detectionobject/Pages/userProfil.dart';
import 'package:detectionobject/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:detectionobject/SafeDrive.dart';
import 'package:detectionobject/SafeHome.dart';
import 'package:detectionobject/SettingsPage.dart';
import 'package:detectionobject/widgets/SafeWalk.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> options = ['SafeDrive', 'SafeHome', 'SafeWalk', 'Settings'];
    final User currentUser = User(name: 'Aya Mabaouj', email: 'mabaoujaya@gmail.com', phoneNumber: '56416068');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Naviguer vers la page de profil utilisateur
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage(user: currentUser)),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue, // Background color under Welcome message
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to My Smart Assistant',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/welcome.gif',
                  width: 500,
                  height: 200,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                return buildOptionCard(options[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionCard(String option) {
    IconData iconData;

    switch (option) {
      case 'SafeDrive':
        iconData = Icons.directions_car;
        break;
      case 'SafeHome':
        iconData = Icons.home;
        break;
      case 'SafeWalk':
        iconData = Icons.directions_walk;
        break;
      case 'Settings':
        iconData = Icons.settings;
        break;
      default:
        iconData = Icons.error;
    }

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          if (option == 'SafeHome') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SafeHome()),
            );
          } else if (option == 'SafeDrive') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SafeDrive()),
            );
          } else if (option == 'SafeWalk') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SafeWalk()),
            );
          } else if (option == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 64.0,
              color: Colors.blue,
            ),
            SizedBox(height: 16.0),
            Text(
              option,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
