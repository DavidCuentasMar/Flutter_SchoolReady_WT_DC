import 'package:consumo_web/models/course_data.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/content/details_container.dart';
import 'package:consumo_web/screens/widgets/course_details.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:consumo_web/screens/widgets/person_detail.dart';
import 'package:flutter/material.dart';

class ContentList extends StatefulWidget {
  final scaffoldKey;
  final ListProvider model;
  final User user;
  final Function unauthorizedProtocol;

  const ContentList(
      {Key key,
      this.scaffoldKey,
      @required this.model,
      @required this.user,
      @required this.unauthorizedProtocol})
      : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  Widget _listView(ListProvider model) {
    switch (model.view) {
      case 1:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            PersonData professor = model.professors[index];
            return ListItem(
              title: professor.name + " ("+professor.username+")",
              content: professor.email,
              onPressed: () async {
                // TODO navigate and fetch professor
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                      content: PersonDetails(
                          personId: professor.id, type: 0, user: widget.user),
                      title: 'Professor',
                      unauthorizedProtocol: widget.unauthorizedProtocol,
                    ),
                  ),
                );
                if (result == 'Unauthorized') {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      widget.unauthorizedProtocol();
                    },
                  );
                }
              },
            );
          },
          itemCount: model.professors.length,
        );
      case 2:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            PersonData student = model.students[index];
            return ListItem(
              title: student.name + ' ('+student.username+')',
              content: student.email,
              onPressed: () async {
                // TODO Navigate and fetch student
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                      content: PersonDetails(
                          personId: student.id, type: 1, user: widget.user),
                      title: 'Student',
                      unauthorizedProtocol: widget.unauthorizedProtocol,
                    ),
                  ),
                );
                if (result == 'Unauthorized') {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      widget.unauthorizedProtocol();
                    },
                  );
                }
              },
            );
          },
          itemCount: model.students.length,
          addAutomaticKeepAlives: false,
        );
      default:
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemBuilder: (_, index) {
            CourseData course = model.courses[index];
            return ListItem(
              title: course.name,
              content: '\n'+course.professorName + ' and ' +
                  course.students.toString() + ' Students',
              onPressed: () async {
                // TODO navigate and fetch course
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                      content:
                          CourseDetails(courseId: course.id, user: widget.user),
                      title: 'Course Details',
                      unauthorizedProtocol: widget.unauthorizedProtocol,
                    ),
                  ),
                );
                if (result == 'Unauthorized') {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      widget.unauthorizedProtocol();
                    },
                  );
                }
              },
            );
          },
          itemCount: model.courses.length,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _listView(widget.model);
  }
}
