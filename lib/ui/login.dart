import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:ui_design/widgets/loading.dart';
import 'package:ui_design/utils/auth.dart';
import 'package:ui_design/utils/validator.dart';

class Login extends StatefulWidget {
  final currentUser;

  Login({this.currentUser});

  _Login createState() => _Login();
}

class _Login extends State<Login> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;

  String email;
  String password;

  void Submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pushNamed(context, '/adminHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Image.asset(
        'assets/ma.png',
        width: 277,
        height: 88,
        fit: BoxFit.contain,
      ),
    );

    final title = Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "تسجيل الدخول",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final email = Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          textCapitalization: TextCapitalization.words,
          controller: _email,
          validator: Validator.validateEmail,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            labelText: "البريد الإلكتروني",
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.email,
                color: Theme.of(context).primaryColor,
              ), // icon is 48px widget.
            ), // icon is 48px widget.
            hintText: 'البريد الإلكتروني',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ));

    final password = Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textAlign: TextAlign.right,
          autofocus: false,
          obscureText: true,
          controller: _password,
          validator: Validator.validatePassword,
          decoration: InputDecoration(
            labelText: "كلمة المرور",
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ), // icon is 48px widget.
            ), // icon is 48px widget.
            hintText: 'كلمة المرور',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          ),
        ));

    final login = Container(
      padding: EdgeInsets.only(top: 35),
      child: ButtonTheme(
        minWidth: 220.0,
        height: 55.0,
        child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Theme.of(context).primaryColor,
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            onPressed: () {
              _emailLogin(
                  email: _email.text,
                  password: _password.text,
                  context: context);
            }),
      ),
    );

    final forgot = ButtonTheme(
        minWidth: 10.0,
        height: 10.0,
        child: FlatButton(
            child: Text(
              "نسيت كلمة السر ؟",
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, '/forgot');
            }));

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          logo,
        ],
      ),
      body: LoadingScreen(
          child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        title,
                        email,
                        SizedBox(
                          height: 24,
                        ),
                        password,
                        SizedBox(
                          height: 12,
                        ),
                        //LoginButton
                        login,
                        forgot,
                      ],
                    ),
                  ),
                )),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signIn(email, password)
            .then((uid) => Navigator.of(context).pop());
        Navigator.pushNamed(context, '/Home');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign In Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Login Error",
          message: exception,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
