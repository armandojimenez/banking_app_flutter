import 'dart:ui';

import 'package:coop_cards_poc/models/base_model.dart';
import 'package:coop_cards_poc/pages/enrollment.dart';
import 'package:coop_cards_poc/pages/home.dart';
import 'package:coop_cards_poc/pages/security_code.dart';
import 'package:coop_cards_poc/pages/settings.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.mainColor,
      body: Stack(
        children: <Widget>[
          getBackgroundImg(),
          getLoginForm(context),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(
                      isLoggedIn: false,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Align getLoginForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .98,
                      height: MediaQuery.of(context).size.height * .60,
                      decoration: new BoxDecoration(
                        border: Border.all(
                            color: Consts.mainColor.withOpacity(.4), width: 3),
                        color: Colors.grey.shade200.withOpacity(0.8),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(22.0),
                          topRight: const Radius.circular(22.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            getCoopLogo(),
                            getWelcomeUser(),
                            Expanded(
                              child: LoginForm(),
                              flex: 12,
                            ),
                            getSignUp(context)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded getSignUp(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('no_account'),
            style: TextStyle(fontSize: 16),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.green,
              onTap: () {
                if (widget != null)
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => new Enrollment()));
              },
              child: Text(
                AppLocalizations.of(context).tr('sign_up'),
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded getWelcomeUser() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).tr('welcome') + ", Armando",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {},
            splashColor: Colors.green,
            highlightColor: Colors.green,
            hoverColor: Colors.green,
            child: Text(
              AppLocalizations.of(context).tr('not_you'),
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  Expanded getCoopLogo() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Image.asset(
          'assets/images/coop_logo.png',
          width: 300,
        ),
      ),
    );
  }

  Container getBackgroundImg() {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/door.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getUsernameTextField(),
              SizedBox(
                height: 15,
              ),
              getPasswordTextField(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Text(
                  AppLocalizations.of(context).tr('forgot_password'),
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 70,
                  child: RaisedButton(
                    disabledColor: Consts.mainColor,
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              var goToSecurityScreen =
                                  !Provider.of<BaseModel>(context)
                                      .wasAuthWithSecurityCode();

                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => goToSecurityScreen
                                          ? new PinCodeVerificationScreen(
                                              '939-241-2976')
                                          : new MyHomePage()));
                            }
                          },
                    color: Consts.mainColor,
                    elevation: 6,

                    child: !_isLoading
                        ? Text(
                            AppLocalizations.of(context).tr('login'),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        : SpinKitThreeBounce(
                            color: Colors.white,
                            size: 25,
                          ),
                    // increaseHeightBy: 25,
                    // increaseWidthBy: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField getPasswordTextField() {
    return TextFormField(
      enabled: !_isLoading,
      initialValue: 'test1234',
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          prefixIcon: Icon(Icons.security),
          labelText: AppLocalizations.of(context).tr('password')),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      obscureText: !_showPassword,
    );
  }

  TextFormField getUsernameTextField() {
    return TextFormField(
      enabled: !_isLoading,
      initialValue: 'armandojimenez',
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
          labelText: AppLocalizations.of(context).tr('username')),
      validator: (value) {
        if (value.isEmpty) return 'Please enter your username';

        return null;
      },
    );
  }
}
