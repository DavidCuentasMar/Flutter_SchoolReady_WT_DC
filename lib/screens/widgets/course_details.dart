import 'package:consumo_web/backend/courses.dart';
import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  final int courseId;
  final User user;

  CourseDetails({Key key, @required this.courseId, @required this.user})
      : super(key: key);

  _CourseDetailsState courseDetailsState = _CourseDetailsState();

  @override
  _CourseDetailsState createState() => courseDetailsState;
}

class _CourseDetailsState extends State<CourseDetails> {
  Future<Course> futureCourse;
  Course course;

  @override
  void initState() {
    super.initState();
    futureCourse =
        fetchCourse(widget.user.username, widget.courseId, widget.user.token);
  }

  void addStudent(PersonData student) {
    if (course != null) {
      setState(() {
        course.addStudent(student);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Course>(
      future: futureCourse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            course = snapshot.data;
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Course Name",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Course ID: ${widget.courseId}",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Professor",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        course.professor.name,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Students",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 1.0),
                    itemBuilder: (_, index) {
                      PersonData student = course.students[index];
                      return Center(
                        child: Text(
                          student.name,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    itemCount: course.students.length,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Navigator.pop(context, 'Unauthorized');
          }
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        );
      },
    );
  }
}
