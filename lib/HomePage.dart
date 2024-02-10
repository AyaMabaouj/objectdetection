import 'package:detectionobject/SafeDrive.dart';
import 'package:detectionobject/SafeHome.dart';
import 'package:detectionobject/SettingsPage.dart';
import 'package:detectionobject/widgets/SafeWalk.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // List des options
    List<String> options = ['SafeDrive', 'SafeHome', 'SafeWalk', 'Settings']; // Ajout de 'Settings' à la liste

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Mettre ici la logique pour ouvrir l'écran de configuration
              // Par exemple, naviguer vers une nouvelle page de configuration
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes dans la grille
                  crossAxisSpacing: 16.0, // Espace horizontal entre les éléments
                  mainAxisSpacing: 16.0, // Espace vertical entre les éléments
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  // Retourne un widget pour chaque élément
                  return buildOptionCard(options[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionCard(String option) {
    IconData iconData;

    // Sélectionne l'icône en fonction de l'option
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
      case 'Settings': // Icône pour l'option Settings
        iconData = Icons.settings;
        break;
      default:
        iconData = Icons.error;
    }

    return Card(
      elevation: 4.0,
       child: InkWell(
      onTap: () {
        if (option == 'SafeHome') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SafeHome()),
          );
        }
        else if (option == 'SafeDrive') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SafeDrive()),
          );
        }
         else if (option == 'SafeWalk') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SafeWalk()),
          );
        }
         else if (option == 'Settings') {
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
            textAlign: TextAlign.center, // Centrer le texte
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),);
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
