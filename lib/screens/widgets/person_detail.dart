import 'package:consumo_web/backend/courses.dart';
import 'package:consumo_web/backend/professors.dart';
import 'package:consumo_web/backend/students.dart';
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:consumo_web/screens/widgets/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PersonDetails extends StatefulWidget {
  final int personId;
  final User user;
  final int type;

  const PersonDetails(
      {Key key,
      @required this.personId,
      @required this.type,
      @required this.user})
      : super(key: key);

  @override
  _PersonDetailsState createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  Future<Person> futurePerson;

  @override
  void initState() {
    super.initState();
    futurePerson = widget.type == 0
        ? fetchProfessor(
            widget.user.username, widget.personId, widget.user.token)
        : fetchStudent(
            widget.user.username, widget.personId, widget.user.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
      future: futurePerson,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProfileData(
                    person: snapshot.data,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Course:",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<Course>(
                    future: fetchCourse(widget.user.username,
                        snapshot.data.courseId, widget.user.token),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          Course course = snapshot.data;
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      course.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                    _courseSubtitle(),
                                  ],
                                ),
                              ),
                              _coursePreview(course),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          Navigator.pop(context, 'Unauthorized');
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.ocean_green),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Navigator.pop(context, 'Unauthorized');
          }
        }
        // By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.ocean_green),
          ),
        );
      },
    );
  }

  Widget _courseSubtitle() {
    return widget.type == 0
        ? ListTile(
            title: Text(
              "Students",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          )
        : ListTile(
            title: Text(
              "Professor",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
  }

  Widget _coursePreview(Course course) {
    return widget.type == 0
        ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              itemBuilder: (_, index) {
                PersonData student = course.students[index];
                return Text(student.name + " ("+student.username+")");
              },
              itemCount: course.students.length,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:Text(course.professor.name + " ("+course.professor.username +")"),
          );
  }
}
