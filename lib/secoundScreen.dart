import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SecoundPage extends StatelessWidget {
  final RxBool lsit;
  const SecoundPage({super.key, required this.lsit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Secoud page',
          style: TextStyle(color: lsit.value ? Colors.black : Colors.white),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Testing Dark Mode",
            style: TextStyle(
                fontSize: 30, color: lsit.value ? Colors.black : Colors.white),
          )
        ],
      )),
    );
  }
}
