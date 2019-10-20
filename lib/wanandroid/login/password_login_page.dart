import 'package:book/framework.dart' show isIOS;
import 'package:book/utils/sp_util.dart';
import 'package:book/utils/t.dart';
import 'package:book/widgets.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../styles.dart';

/// 密码登录页面
///
class PasswordLoginPage extends StatefulWidget {
  PasswordLoginPage({Key key}) : super(key: key);

  @override
  _PasswordLoginPageState createState() => _PasswordLoginPageState();
}

class _PasswordLoginPageState extends State<PasswordLoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  bool _isClick = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardAction(
              focusNode: _nodePhone,
              closeWidget:
                  Padding(padding: EdgeInsets.all(5.0), child: Text("close"))),
          KeyboardAction(
              focusNode: _nodePassword,
              closeWidget:
                  Padding(padding: EdgeInsets.all(5.0), child: Text("close")))
        ]);
  }

  @override
  void initState() {
    super.initState();

    /// 监听输入改变
    _phoneController.addListener(_verify);
    _passwordController.addListener(_verify);

    setState(() => _phoneController.text = SpUtil.getString('login_phone'));
  }

  void _verify() {
    String name = _phoneController.text;
    String password = _passwordController.text;
    if (name.isEmpty || name.length < 11) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    if (password.isEmpty || password.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }

    setState(() {
      _isClick = true;
    });
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(leading: CloseButton(), actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: FlatButton(
              child: Text(
                "快捷登录",
                style: Styles.textDark14,
              ),
              onPressed: () {
                T.show("todo");
              },
              highlightColor: Colors.black26,
              shape: StadiumBorder(),
            ),
          )
        ]),
        body: isIOS
            ? FormKeyboardActions(child: _buildBodyView())
            : SingleChildScrollView(child: _buildBodyView()));
  }

  Widget _buildBodyView() {
    return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Password Login", style: Styles.textBoldDark26),
              SizedBox(height: 26.0),
              CustomTextField(
                  focusNode: _nodePhone,
                  controller: _phoneController,
                  maxLength: 11,
                  nextFocusNode: _nodePassword,
                  keyboardType: TextInputType.phone,
                  hintText: "Please enter your account"),
              SizedBox(height: 10.0),
              CustomTextField(
                  focusNode: _nodePassword,
                  config: _buildConfig(context),
                  isInputPwd: true,
                  controller: _passwordController,
                  maxLength: 16,
                  hintText: "Please enter your password"),
              SizedBox(height: 25.0),
              Button(
                  onPressed: _isClick ? _login : null,
                  text: "Login",
                  borderRadius: 0),
              SizedBox(height: 16.0),
              Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: Padding(
                          child:
                              Text('Forgot Password', style: Styles.textGrey14),
                          padding: EdgeInsets.all(10)),
                      onTap: () {
                        T.show("todo");
                      })),
              SizedBox(height: 6.0),
              Container(
                  alignment: Alignment.center,
                  child: InkWell(
                      child: Padding(
                          child: Text('No account? Go and register',
                              style: Styles.textBlue16),
                          padding: EdgeInsets.all(10)),
                      onTap: () {
                        T.show("todo");
                      }))
            ]));
  }

  void _login() async {
    SpUtil.putString('login_phone', _phoneController.text);

    Navigator.pop(context);
  }
}
