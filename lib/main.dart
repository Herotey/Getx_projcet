// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_projcet_test/secoundScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.amber, disabledColor: Colors.grey));

ThemeData _lightTheme = ThemeData(
    focusColor: Colors.amber,
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 234, 163, 21),
    buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromARGB(255, 222, 26, 26),
        disabledColor: Colors.grey));

class MyApp extends StatelessWidget {
  RxBool _isLightTheme = false.obs;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  _getThemeStauts() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  MyApp() {
    _getThemeStauts();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'State Management by GetX ',
              style: TextStyle(
                  color: _isLightTheme.value ? Colors.black : Colors.white),
            ),
            foregroundColor: _isLightTheme.value ? Colors.black : Colors.white,
            actions: [
              ObxValue(
                (data) => Switch(
                  value: _isLightTheme.value,
                  onChanged: (val) {
                    _isLightTheme.value = val;
                    Get.changeThemeMode(
                        _isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
                    _saveThemeStatus();
                  },
                ),
                false.obs,
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                    'Click on Switch to Change ${_isLightTheme.value ? 'Dark' : 'Light'} theme')),
                IconButton(
                  onPressed: () {
                    Get.to(SecoundPage(
                      lsit: _isLightTheme,
                    ));
                  },
                  icon: Icon(Icons.navigate_next_rounded),
                  color: _isLightTheme.value ? Colors.black : Colors.white,
                  iconSize: 50,
                )
              ],
            ),
          ),
        ));
  }
}
