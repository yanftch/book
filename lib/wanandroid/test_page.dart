import 'package:book/demo/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:book/styles.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: WidgetButton(),
    );
  }
}
