import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/content/main_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'WT DC APP',
        theme: ThemeData(
          primaryColor: Colors.red,
          // Input Theme
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              //  when the TextFormField in focused
            ),
            border: OutlineInputBorder(),
          ),
        ),
        // Set Content as consumer of the provider
        home: Consumer<AuthProvider>(
          builder: (context, authState, child) {
            return ChangeNotifierProvider<ListProvider>(
              create: (context) => ListProvider(),
              child: MainContainer(
                authState: authState,
              ),
            );
          },
        ),
      ),
    );
  }
}
