import 'package:flutter/material.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        body: _buildBody(),
      );

      Widget _buildBody() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
          ],
        ),
      );
}
