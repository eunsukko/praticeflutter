// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// import '../../gallery/demo.dart';

// var jsonData = '{"Team":{"Name":"2019년도 1셀","MemberIds":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"MemberValidPeriods":[{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"}],"Positions":[[0],[1]]},"People":[{"Name":"이사라","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김윤호","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정윤선","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"천도현","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"조병민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"고은석","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"이재성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"박효철","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김정민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정가람","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김건형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"최휘성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김혜인","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"백혜수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"심규영","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노태형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노이삭","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"구현모","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}]}';
var jsonData = '{"Team":{"Name":"2019년도 1셀","MemberIds":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"MemberValidPeriods":[{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"}],"Positions":[[0],[1]]},"Eventlist":["금철","대예배","5부예배","셀모임"],"People":[{"Name":"이사라","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김윤호","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정윤선","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"천도현","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"조병민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"고은석","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"이재성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"박효철","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김정민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정가람","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김건형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"최휘성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김혜인","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"백혜수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"심규영","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노태형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노이삭","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"구현모","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}]}';

// init attendancebook 
// 


// A function that will convert a response body into a List<Photo>
// List<Photo> parsePhotos(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
// }

// Future<List<Photo>> fetchPhotos(http.Client client) async {
//   final response =
//       await client.get('https://jsonplaceholder.typicode.com/photos');

//   return parsePhotos(response.body);
// }

class Person {
  
  String name;
  Map<String, bool> attendance;

  bool selected = false;

  Person(this.name, this.attendance);

  // var jsonData = '{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}'
  factory Person.fromJson(Map<String, dynamic> jsonData) {
    final name = jsonData['Name'] as String;
    final attendance = Map<String, bool>();

    jsonData['Attendance'].forEach((k, v) => attendance[k] = v as bool);

    return Person(name, attendance);
  }

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Attendance' : attendance,
  };
}

List<Person> parsePeople(String jsonString) {
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

  return parsed.map<Person>((jsonPerson) => Person.fromJson(jsonPerson)).toList();
}

class Team {
  String name;
  List<int> memberIds;

  Team(this.name, this.memberIds);

  factory Team.fromJson(Map<String, dynamic> jsonData) {
    return Team(
      jsonData['Name'] as String, 
      jsonData['MemberIds'].cast<int>().toList(),
      );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'MemberIds': memberIds,
  };
}

class Attendancebook {
  Team team;
  List<String> eventlist;
  List<Person> people;

  Attendancebook(this.team, this.eventlist, this.people);

  factory Attendancebook.fromJson(Map<String, dynamic>jsonData) {
    final jsonPeople = jsonData['People'].cast<Map<String, dynamic>>();
    return Attendancebook(
      Team.fromJson(jsonData['Team']),
      jsonData['Eventlist'].cast<String>().toList(), // 에고.. 어떻게 해야지... 복잡한 구조를 깨끗하게.. 가져올까??
      jsonPeople.map<Person>((jsonPerson) => Person.fromJson(jsonPerson)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Team': team,
    'Eventlist': eventlist,
    'People': people,
  };
}

class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.protein, this.sodium, this.calcium, this.iron);
  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;

  bool selected = false;

  Map<String, bool> values = {
    'val1': false,
    'val2': false,
  };
}

class PeopleDataSource extends DataTableSource {
  List<Person> _people;
  List<String> _events;

  PeopleDataSource(this._people, this._events);

  void _sort<T>(Comparable<T> getField(Person p), bool ascending) {
    _people.sort((Person a, Person b) {
      if (!ascending) {
        final Person c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _people.length)
      return null;
    Person person = _people[index];

    var _curCells = <DataCell>[
        DataCell(Text('${person.name}')),
    ];
    _curCells.addAll(_events.map((String key) {
      return DataCell(Checkbox(
        value: person.attendance[key],
        onChanged: (bool value) {
          person.attendance[key] = value;
          notifyListeners();
        },
       ));
    }));

    return DataRow.byIndex(
      index: index,
      cells: _curCells,
    );
  }

  @override
  int get rowCount => _people.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Person person in _people)
      person.selected = checked;
    _selectedCount = checked ? _people.length : 0;
    notifyListeners();
  }
}

// class DessertDataSource extends DataTableSource {
//   final List<Dessert> _desserts = <Dessert>[
//     Dessert('Frozen yogurt',                        159,  6.0,  24,  4.0,  87, 14,  1),
//     Dessert('Ice cream sandwich',                   237,  9.0,  37,  4.3, 129,  8,  1),
//     Dessert('Eclair',                               262, 16.0,  24,  6.0, 337,  6,  7),
//     Dessert('Cupcake',                              305,  3.7,  67,  4.3, 413,  3,  8),
//     Dessert('Gingerbread',                          356, 16.0,  49,  3.9, 327,  7, 16),
//     Dessert('Jelly bean',                           375,  0.0,  94,  0.0,  50,  0,  0),
//     Dessert('Lollipop',                             392,  0.2,  98,  0.0,  38,  0,  2),
//     Dessert('Honeycomb',                            408,  3.2,  87,  6.5, 562,  0, 45),
//     Dessert('Donut',                                452, 25.0,  51,  4.9, 326,  2, 22),
//     Dessert('KitKat',                               518, 26.0,  65,  7.0,  54, 12,  6),

//     Dessert('Frozen yogurt with sugar',             168,  6.0,  26,  4.0,  87, 14,  1),
//     Dessert('Ice cream sandwich with sugar',        246,  9.0,  39,  4.3, 129,  8,  1),
//     Dessert('Eclair with sugar',                    271, 16.0,  26,  6.0, 337,  6,  7),
//     Dessert('Cupcake with sugar',                   314,  3.7,  69,  4.3, 413,  3,  8),
//     Dessert('Gingerbread with sugar',               345, 16.0,  51,  3.9, 327,  7, 16),
//     Dessert('Jelly bean with sugar',                364,  0.0,  96,  0.0,  50,  0,  0),
//     Dessert('Lollipop with sugar',                  401,  0.2, 100,  0.0,  38,  0,  2),
//     Dessert('Honeycomb with sugar',                 417,  3.2,  89,  6.5, 562,  0, 45),
//     Dessert('Donut with sugar',                     461, 25.0,  53,  4.9, 326,  2, 22),
//     Dessert('KitKat with sugar',                    527, 26.0,  67,  7.0,  54, 12,  6),

//     Dessert('Frozen yogurt with honey',             223,  6.0,  36,  4.0,  87, 14,  1),
//     Dessert('Ice cream sandwich with honey',        301,  9.0,  49,  4.3, 129,  8,  1),
//     Dessert('Eclair with honey',                    326, 16.0,  36,  6.0, 337,  6,  7),
//     Dessert('Cupcake with honey',                   369,  3.7,  79,  4.3, 413,  3,  8),
//     Dessert('Gingerbread with honey',               420, 16.0,  61,  3.9, 327,  7, 16),
//     Dessert('Jelly bean with honey',                439,  0.0, 106,  0.0,  50,  0,  0),
//     Dessert('Lollipop with honey',                  456,  0.2, 110,  0.0,  38,  0,  2),
//     Dessert('Honeycomb with honey',                 472,  3.2,  99,  6.5, 562,  0, 45),
//     Dessert('Donut with honey',                     516, 25.0,  63,  4.9, 326,  2, 22),
//     Dessert('KitKat with honey',                    582, 26.0,  77,  7.0,  54, 12,  6),

//     Dessert('Frozen yogurt with milk',              262,  8.4,  36, 12.0, 194, 44,  1),
//     Dessert('Ice cream sandwich with milk',         339, 11.4,  49, 12.3, 236, 38,  1),
//     Dessert('Eclair with milk',                     365, 18.4,  36, 14.0, 444, 36,  7),
//     Dessert('Cupcake with milk',                    408,  6.1,  79, 12.3, 520, 33,  8),
//     Dessert('Gingerbread with milk',                459, 18.4,  61, 11.9, 434, 37, 16),
//     Dessert('Jelly bean with milk',                 478,  2.4, 106,  8.0, 157, 30,  0),
//     Dessert('Lollipop with milk',                   495,  2.6, 110,  8.0, 145, 30,  2),
//     Dessert('Honeycomb with milk',                  511,  5.6,  99, 14.5, 669, 30, 45),
//     Dessert('Donut with milk',                      555, 27.4,  63, 12.9, 433, 32, 22),
//     Dessert('KitKat with milk',                     621, 28.4,  77, 15.0, 161, 42,  6),

//     Dessert('Coconut slice and frozen yogurt',      318, 21.0,  31,  5.5,  96, 14,  7),
//     Dessert('Coconut slice and ice cream sandwich', 396, 24.0,  44,  5.8, 138,  8,  7),
//     Dessert('Coconut slice and eclair',             421, 31.0,  31,  7.5, 346,  6, 13),
//     Dessert('Coconut slice and cupcake',            464, 18.7,  74,  5.8, 422,  3, 14),
//     Dessert('Coconut slice and gingerbread',        515, 31.0,  56,  5.4, 316,  7, 22),
//     Dessert('Coconut slice and jelly bean',         534, 15.0, 101,  1.5,  59,  0,  6),
//     Dessert('Coconut slice and lollipop',           551, 15.2, 105,  1.5,  47,  0,  8),
//     Dessert('Coconut slice and honeycomb',          567, 18.2,  94,  8.0, 571,  0, 51),
//     Dessert('Coconut slice and donut',              611, 40.0,  58,  6.4, 335,  2, 28),
//     Dessert('Coconut slice and KitKat',             677, 41.0,  72,  8.5,  63, 12, 12),
//   ];

//   void _sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
//     _desserts.sort((Dessert a, Dessert b) {
//       if (!ascending) {
//         final Dessert c = a;
//         a = b;
//         b = c;
//       }
//       final Comparable<T> aValue = getField(a);
//       final Comparable<T> bValue = getField(b);
//       return Comparable.compare(aValue, bValue);
//     });
//     notifyListeners();
//   }

//   int _selectedCount = 0;

//   @override
//   DataRow getRow(int index) {
//     assert(index >= 0);
//     if (index >= _desserts.length)
//       return null;
//     Dessert dessert = _desserts[index];

//     var _curCells = <DataCell>[
//         DataCell(Text('${dessert.name}')),
//     ];
//     _curCells.addAll(dessert.values.keys.map((String key) {
//       return DataCell(Checkbox(
//         value: dessert.values[key],
//         onChanged: (bool value) {
//           dessert.values[key] = value;
//           notifyListeners();
//         },
//        ));
//     }));

//     return DataRow.byIndex(
//       index: index,
//       // selected: dessert.selected,
//       // onSelectChanged: (bool value) {
//       //   if (dessert.selected != value) {
//       //     _selectedCount += value ? 1 : -1;
//       //     assert(_selectedCount >= 0);
//       //     dessert.selected = value;
//       //     notifyListeners();
//       //   }
//       // },
//       cells: _curCells,
//       // cells: <DataCell>[
//       //   DataCell(Text('${dessert.name}')),
//       //   DataCell(Checkbox()),
//       //   // DataCell(Text('${dessert.calories}')),
//       //   // DataCell(Text('${dessert.fat.toStringAsFixed(1)}')),
//       //   // DataCell(Text('${dessert.carbs}')),
//       //   // DataCell(Text('${dessert.protein.toStringAsFixed(1)}')),
//       //   // DataCell(Text('${dessert.sodium}')),
//       //   // DataCell(Text('${dessert.calcium}%')),
//       //   // DataCell(Text('${dessert.iron}%')),
//       // ]
//     );
//   }

//   @override
//   int get rowCount => _desserts.length;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => _selectedCount;

//   void _selectAll(bool checked) {
//     for (Dessert dessert in _desserts)
//       dessert.selected = checked;
//     _selectedCount = checked ? _desserts.length : 0;
//     notifyListeners();
//   }
// }

// Future<List<Phot> fetchPhotos(http.Client client) async {
//   final response =
//       await client.get('https://jsonplaceholder.typicode.com/photos');

//   // Use the compute function to run parsePhotos in a separate isolate
//   return compute(parsePhotos, response.body);
// }

Attendancebook parseAttendancebook(String responseBody) {
  final parsed = json.decode(responseBody) as Map<String, dynamic>;

  return Attendancebook.fromJson(parsed);
}

Future<Attendancebook> fetchAttendancebook(http.Client client) async {
  // var response = await client.get('https://jsonplaceholder.typicode.com/photos');

  // return compute(parseAttendancebook, response.body);

  final responseBody = '{"Team":{"Name":"2019년도 1셀","MemberIds":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"MemberValidPeriods":[{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"}],"Positions":[[0],[1]]},"Eventlist":["금철","대예배","5부예배","셀모임"],"People":[{"Name":"이사라","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김윤호","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정윤선","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"천도현","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"조병민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"고은석","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"이재성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"박효철","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김정민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정가람","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김건형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"최휘성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김혜인","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"백혜수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"심규영","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노태형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노이삭","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"구현모","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}]}';

  return compute(parseAttendancebook ,responseBody);
}

class AttendanceBookPage extends StatelessWidget {
  final String title;

  AttendanceBookPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("called only one times");

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<Attendancebook>(
        future: fetchAttendancebook(http.Client()),
        builder: (context, snapshot) {
          print("builder called\n");
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? AttendancebookDataTable(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}


class AttendancebookDataTable extends StatefulWidget {
  Attendancebook attendancebook;
  AttendancebookDataTable(this.attendancebook);

  @override
  _AttendancebookDataTable createState() => _AttendancebookDataTable(attendancebook);
}

class _AttendancebookDataTable extends State<AttendancebookDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  Attendancebook attendancebook;
  PeopleDataSource _peopleDataSource;
  // data source 를 업데이트하기
  // 연결 지어주기

  _AttendancebookDataTable(this.attendancebook) {
    _peopleDataSource = PeopleDataSource(this.attendancebook.people, this.attendancebook.eventlist);
  }

  void _sort<T>(Comparable<T> getField(Person p), int columnIndex, bool ascending) {
    _peopleDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final team = attendancebook.team;
    final teamName = team.name;

    var curColumns = <DataColumn>[
      DataColumn(
        label: const Text('이름'),
        onSort: (int columnIndex, bool ascending) => _sort<String>((Person p) => p.name, columnIndex, ascending)),
    ];
    curColumns.addAll(
      attendancebook.eventlist.map<DataColumn>((String event) => 
      DataColumn(
        label: Text('$event'),
      ))
    );

    return ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          PaginatedDataTable(
            header: Text('$teamName 출석부'), // 헤더에 해당 셀의 정보를 추가 (동적으로 얻어온 team정보를 기준으로 만들기)
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            onSelectAll: _peopleDataSource._selectAll,
            columns: curColumns,
            source: _peopleDataSource,
          )
        ]
      );
  }
}

// class DataTableDemo extends StatefulWidget {
//   static const String routeName = '/material/data-table';

//   @override
//   _DataTableDemoState createState() => _DataTableDemoState();
// }

// class _DataTableDemoState extends State<DataTableDemo> {
//   int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//   int _sortColumnIndex;
//   bool _sortAscending = true;
//   final DessertDataSource _dessertsDataSource = DessertDataSource();

//   void _sort<T>(Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
//     _dessertsDataSource._sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Data tables'),
//         // actions: <Widget>[
//         //   // MaterialDemoDocumentationButton(DataTableDemo.routeName),
//         // ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(8.0),
//         children: <Widget>[
//           PaginatedDataTable(
//             header: const Text('Nutrition'), // 헤더에 해당 셀의 정보를 추가 (동적으로 얻어온 team정보를 기준으로 만들기)
//             rowsPerPage: _rowsPerPage,
//             onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
//             sortColumnIndex: _sortColumnIndex,
//             sortAscending: _sortAscending,
//             onSelectAll: _dessertsDataSource._selectAll,
//             columns: <DataColumn>[
//               DataColumn(
//                 label: const Text('Dessert (100g serving)'),
//                 onSort: (int columnIndex, bool ascending) => _sort<String>((Dessert d) => d.name, columnIndex, ascending)
//               ),
//               DataColumn(
//                 label: const Text('Calories'),
//                 onSort: (int columnIndex, bool ascending) => _sort<num>((Dessert d) => d.calories, columnIndex, ascending)
//               ),
//               DataColumn(
//                 label: const Text('Fat (g)'),
//                 onSort: (int columnIndex, bool ascending) => _sort<num>((Dessert d) => d.fat, columnIndex, ascending)
//               ),
//             ],
//             source: _dessertsDataSource
//           )
//         ]
//       )
//     );
//   }
// }

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: AttendanceBookPage(title: "Attendance for faith"),
  ));
}

// void main() {
//   var jsonString ='{ "name": "John Smith", "email": "john@example.com" }';

//   Map<String, dynamic> user = jsonDecode(jsonString);

// print('Howdy, ${user['name']}!');
// print('We sent the verification link to ${user['email']}.');

// print('jsonData: ${jsonEncode(user)}.');
// }


void testPerson() {
  var jsonPerson = '{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}';

  Person person = Person.fromJson(json.decode(jsonPerson) as Map<String, dynamic>);

  print(jsonEncode(person));
}


void testAttendancebook() {
  var jsonAttendancebook = '{"Team":{"Name":"2019년도 1셀","MemberIds":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20],"MemberValidPeriods":[{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"},{"From":"2018-11-04T00:00:00Z","To":"2019-11-03T00:00:00Z"}],"Positions":[[0],[1]]},"Eventlist":["금철","대예배","5부예배","셀모임"],"People":[{"Name":"이사라","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김민수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김윤호","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정윤선","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"천도현","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"조병민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"고은석","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"이재성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"박효철","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김정민","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"정가람","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김건형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"최휘성","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김혜인","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"백혜수","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"심규영","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노태형","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"노이삭","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"구현모","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}},{"Name":"김진우","Attendance":{"5부예배":false,"금철":false,"대예배":false,"셀모임":false}}]}';

  final attendancebook = Attendancebook.fromJson(json.decode(jsonAttendancebook) as Map<String, dynamic>);

  print(jsonEncode(attendancebook));
}

// void main() {
//   // testEventlist();

//   // testAttendance();

//   // testPerson();

//   testAttendancebook();
// }
