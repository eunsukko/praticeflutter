import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; 
import 'attendancebook.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance for Faith Group',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Arrangements(),
    );
  }
}

class Team {
  int id;
  Team(this.id){

  }
}

// maintains the state of the RandomWords widget.
class ArrangementsState extends State<Arrangements> {
  // final _suggestions = <WordPair>[];
  // final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _teams = <Team>[];

  @override
  void initState() {
    // get team's ids

    // init _teams 
    for (var i = 0; i < 3; i++) {
      _teams.add(Team(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance for Faith Group'),
        actions: <Widget>[ // leave this for result page
          IconButton(
            icon: const Icon(Icons.list),
            // onPressed: _pushSaved,
          ),
        ]
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (_teams.length <= index) {
          return ListTile();
        }
        return _buildRow(_teams[index], index);
      },
      itemCount: 2 * _teams.length ,
    );
  }

  Widget _buildRow(Team team, int index) {
    int id = team.id;
    return ListTile(
      title: Text(
        "[$index] " + "id: " + "$id",
        style: _biggerFont,
      ),
      trailing: new Icon(
        Icons.favorite,
        color: Colors.red,
      ), 
      onTap: () {
        _showAttendancebook(id);
      },
    );
  }

  void _showAttendancebook(int teamId) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Attendancebook(teamId);
        }
      )
    );
  }
}

class Arrangements extends StatefulWidget {
  @override
  ArrangementsState createState() => new ArrangementsState(); 
}

