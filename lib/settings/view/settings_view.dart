import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';


class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Obx(
              () => SwitchListTile(
            title: Text('Dark Mode'),
            value: themeController.isDarkMode.value,
            onChanged: (value) {
              themeController.toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
