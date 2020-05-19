import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/screens/auth/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final AuthProvider authState;

  const LandingPage({Key key, @required this.authState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome BRO",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.red,
          height: 50,
          child: Text(
            "Sign In, BRO",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Auth(
                  authProvider: this.authState,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
