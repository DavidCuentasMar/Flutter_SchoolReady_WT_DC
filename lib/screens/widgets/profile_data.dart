import 'package:consumo_web/models/person_model.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  final Person person;

  const ProfileData({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178.0,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        person.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Color(0xff444444),
                        ),
                      ),
                      Text(
                        person.username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18,
                          color: Color(0xffb5b8b7),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                person.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 10,
                                  color: Color(0xff444444),
                                ),
                              ),
                              Text(
                                person.phone,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  color: Color(0xff444444),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
