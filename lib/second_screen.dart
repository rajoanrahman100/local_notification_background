import 'package:flutter/material.dart';

class SecondScreem extends StatelessWidget {

  String? payload;

  SecondScreem({this.payload});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Bar"),
      ),
    );
  }
}
