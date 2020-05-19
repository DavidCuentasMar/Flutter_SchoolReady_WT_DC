import 'package:consumo_web/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final scaffoldKey;
  final name;
  final email;
  final coursesOnTap;
  final professorsOnTap;
  final studentsOnTap;
  final onReset;
  final onLogOff;

  const CustomDrawer(
      {Key key,
      @required this.scaffoldKey,
      @required this.name,
      @required this.email,
      @required this.coursesOnTap,
      @required this.professorsOnTap,
      @required this.studentsOnTap,
      @required this.onReset,
      @required this.onLogOff})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            this.name,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppColors.tundora,
                            ),
                          ),
                          Text(
                            this.email,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              color: AppColors.edward,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.tundora,
                    ),
                    onPressed: () {
                      this.scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            ListTile(
                title: Text(
                  "Courses",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.tundora,
                  ),
                ),
                dense: true,
                onTap: this.coursesOnTap),
            ListTile(
                title: Text(
                  "Professors",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.tundora,
                  ),
                ),
                dense: true,
                onTap: this.professorsOnTap),
            ListTile(
                title: Text(
                  "Students",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.tundora,
                  ),
                ),
                dense: true,
                onTap: this.studentsOnTap),
            Spacer(),
            ListTile(
                title: Text(
                  "Reset DB",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.tundora,
                  ),
                ),
                dense: true,
                onTap: this.onReset),
            ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.tundora,
                  ),
                ),
                dense: true,
                onTap: this.onLogOff),
          ],
        ),
      ),
    );
  }
}
