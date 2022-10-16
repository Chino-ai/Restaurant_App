import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider/preferences_provider.dart';
import '../data/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String settingsTitle = 'Settings';
  static const routeName = '/setting_page';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: _buildList(context)
        );
      }
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Scheduling News'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isDailyRestoActive,
                        onChanged: (value) async {
                          scheduled.scheduleResto(value);
                          provider.enableDailyResto(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
