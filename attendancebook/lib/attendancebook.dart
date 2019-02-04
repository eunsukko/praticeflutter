import 'package:flutter/material.dart';

// 새로운 Attendancebook page 를 만들었을때 
class AttendancebookState extends State<Attendancebook> {
  int teamId;

  AttendancebookState(this.teamId);

  @override
  void initState() {
    var jsonData = '{"Team":{"Name":"2019년도 1셀","MemberIds":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"MemberValidPeriods":[{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"}],"Positions":[[0],[1]]},"People":[{"Name":"이사라","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김윤호","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정윤선","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"천도현","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"조병민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"고은석","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"이재성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"박효철","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김정민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정가람","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김건형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"최휘성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김혜인","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"백혜수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"심규영","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노태형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노이삭","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"구현모","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}]}';
    // 
  }

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
            appBar: AppBar(
              title: Text("$teamId" + "...!!"),
            ),
            // body: ListView(children: divided),
            );
    }
}

// for attendancebook
class Attendancebook extends StatefulWidget {
  int teamId;

  Attendancebook (this.teamId);

  @override
  AttendancebookState createState() => new AttendancebookState(teamId);
}