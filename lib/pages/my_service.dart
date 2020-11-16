import 'package:flutter/material.dart';
import 'package:ungsingal/pages/map.dart';
import 'package:ungsingal/pages/test_signal.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  
  Widget currentWidget = ShowMap();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),body: currentWidget,
    );
  }
}
