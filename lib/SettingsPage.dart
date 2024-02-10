import 'package:detectionobject/notifications/visualNotif.dart';
import 'package:flutter/material.dart';

import 'notifications/NotificationSonore .dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

enum NotificationType { sound, visual }

class _SettingsPageState extends State<SettingsPage> {
  bool _enableNotifications = false;
  NotificationType _notificationType = NotificationType.sound;
  List<String> _selectedObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres de l\'application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Activer les notifications'),
              value: _enableNotifications,
              onChanged: (value) {
                setState(() {
                  _enableNotifications = value;
                });
              },
            ),
            Visibility(
              visible: _enableNotifications,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<NotificationType>(
                    title: Text('Notification sonore'),
                    value: NotificationType.sound,
                    groupValue: _notificationType,
                    onChanged: (NotificationType? value) {
                      _handleNotificationTypeChange(value);
                    },
                  ),
                  RadioListTile<NotificationType>(
                    title: Text('Notification visuelle'),
                    value: NotificationType.visual,
                    groupValue: _notificationType,
                    onChanged: (NotificationType? value) {
                      setState(() {
                        _notificationType = value!;
                        VisualNotif.show(context);
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Types d\'objets à détecter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Humain'),
              value: _selectedObjects.contains('Humain'),
              onChanged: (value) {
                setState(() {
                  if (value!)
                    _selectedObjects.add('Humain');
                  else
                    _selectedObjects.remove('Humain');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Animal'),
              value: _selectedObjects.contains('Animal'),
              onChanged: (value) {
                setState(() {
                  if (value!)
                    _selectedObjects.add('Animal');
                  else
                    _selectedObjects.remove('Animal');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Inanimé'),
              value: _selectedObjects.contains('Inanimé'),
              onChanged: (value) {
                setState(() {
                  if (value!)
                    _selectedObjects.add('Inanimé');
                  else
                    _selectedObjects.remove('Inanimé');
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enregistrer les paramètres
                // Cette fonctionnalité serait implémentée ici
                // Par exemple : _saveSettings()
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Paramètres enregistrés')),
                );
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNotificationTypeChange(NotificationType? value) async {
    setState(() {
      _notificationType = value!;
    });

    if (_notificationType == NotificationType.sound) {
      await _showSoundNotification();
    }
  }

  Future<void> _showSoundNotification() async {
    await NotificationSonore.init();
    await NotificationSonore.showNotification(
      id: 0,
      title: 'Alert',
      body: 'faite APttention!',
    );
  }
}
