import 'package:flutter/material.dart';
import 'package:generalshop/customer/user.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:generalshop/screens/utilities/screen_utilities.dart';
import 'package:generalshop/screens/utilities/screen_config.dart';
import 'package:generalshop/api/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();

  var _formKey = GlobalKey<FormState>();
  bool _loading = false;

  ScreenConfig screenConfig;
  WidgetSize widgetSize;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: Transform.translate(
          offset: Offset(0, -70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .display3
                          .copyWith(fontSize: 32.0)),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text('Login to continue to your account',
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            fontSize: 18.0,
                            color: ScreenUtilties.darkerGreyText,
                          )),
                ],
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    child: _loginForm(context),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: widgetSize.buttonHeight,
                margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34)),
                  color: ScreenUtilties.mainBlue,
                  child: (_loading)
                      ? Container(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.subhead.copyWith(
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                       _loading = true ; 
                      });
                      _loginUser();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, 0),
                    child: Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            fontSize: 18.0,
                            color: ScreenUtilties.darkerGreyText,
                          ),
                    ),
                  ),
                  FlatButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      // TODO : Send Them To Sign Up Screen
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(fontSize: 24.0),
            ),
            style: TextStyle(fontSize: 24.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Email Is Required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 24.0),
            ),
            style: TextStyle(fontSize: 24.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password Is Required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User user = await authentication.login(email, password);
    if (user.user_id != null) {
      setState(() {
       _loading = false; 
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {

      setState(() {
       _loading = false; 
      });
    }
  }
}
