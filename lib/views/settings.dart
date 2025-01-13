import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onPressed: (BuildContext context) {
                  // Navigate to Profile Page
                },
              ),
              SettingsTile(
                leading: Icon(Icons.lock),
                title: Text('Privacy'),
                onPressed: (BuildContext context) {
                  // Navigate to Privacy Page
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('General'),
            tiles: <SettingsTile>[
              // Use SettingsTile with a Switch widget directly
              SettingsTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              SettingsTile(
                leading: Icon(Icons.language),
                title: Text('Language'),
                // Remove subtitle
                onPressed: (BuildContext context) {
                  // Change language
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Support'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.help),
                title: Text('Help & Feedback'),
                onPressed: (BuildContext context) {
                  // Navigate to Help Page
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.security),
                title: Text('Change Password'),
                onPressed: (BuildContext context) {
                  // Navigate to Change Password Page
                },
              ),
              SettingsTile(
                leading: Icon(Icons.fingerprint),
                title: Text('Fingerprint Authentication'),
                onPressed: (BuildContext context) {
                  // Navigate to Fingerprint Authentication Page
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('About'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.info),
                title: Text('App Version'),
                // Remove subtitle
                onPressed: (BuildContext context) {
                  // Handle App Version tap
                },
              ),
              SettingsTile(
                leading: Icon(Icons.verified_user),
                title: Text('License Agreement'),
                onPressed: (BuildContext context) {
                  // Navigate to License Agreement Page
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
