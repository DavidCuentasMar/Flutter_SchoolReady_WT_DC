import 'package:consumo_web/backend/auth.dart' as backend;
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  final AuthProvider authProvider;
  final switchWidget;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SignIn(
      {Key key,
      @required this.authProvider,
      @required this.switchWidget,
      @required this.scaffoldKey})
      : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool remember = true;
  Widget buttonChild = Text(
    "SUBMIT",
    style: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: TextFormField(
                    controller: this.controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'E-mail cannot be empty';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: TextFormField(
                    controller: this.controllerPassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Pasword cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password length must be grather than 6 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Checkbox(
                    value: remember,
                    onChanged: (bool value) {
                      setState(() {
                        remember = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: MaterialButton(
                    color: Colors.red,
                    height: 46.0,
                    child: buttonChild,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // login request
                        _futureBuilder();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: MaterialButton(
                      color: Colors.red,
                      height: 46.0,
                      child: Text(
                        "CREATE USER",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      onPressed: widget.switchWidget),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Get Future Builder
  _futureBuilder() {
    setState(() {
      // Change Text for FutureBuilder
      buttonChild = FutureBuilder<User>(
        // Future: HTTP Request
        future: backend.login(
          controllerEmail.text,
          controllerPassword.text,
        ),
        builder: (context, snapshot) {
          // Succesful request: bind data
          if (snapshot.hasData) {
            User user = snapshot.data;
            if(remember){
            _writePreferences(user);
            }
            // Add callback for the end of build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.authProvider
                  .connect(user.name, user.email, user.username, user.token);
              Navigator.pop(context);
            });
            return Text(
              "SUBMIT",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            // Add callback for the end of build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(snapshot.error.toString()),
                ),
              );
            });
            return Text(
              "SUBMIT",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            );
          }
          // By default, show a loading spinner.
          return SizedBox(
            height: 24.0,
            width: 24.0,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
      );
    });
  }

// Write user data after login
  _writePreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.token);
    prefs.setString('name', user.name);
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
  }
}
