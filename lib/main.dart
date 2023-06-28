import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Athlete {
  final String name;
  final String level;

  Athlete({required this.name, required this.level});
}

class MyApp extends StatelessWidget {
  final String jsonData = '''
    [
      {"name": "Abhishek", "level": "Basic"},
      {"name": "Tarun", "level": "Intermediate"},
      {"name": "Mohan", "level": "Advanced"},
      {"name": "Mohan", "level": "Intermediate"},
      {"name": "Raja", "level": "Basic"}
    ]
  ''';

  List<Athlete> parse(String jsonStr) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed.map<Athlete>((json) => Athlete(name: json['name'], level: json['level'])).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Athlete> athletes = parse(jsonData);

    final basic = athletes.where((athlete) => athlete.level == 'Basic').toList();
    final intermediate = athletes.where((athlete) => athlete.level == 'Intermediate').toList();
    final advanced = athletes.where((athlete) => athlete.level == 'Advanced').toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Athletes')),
        ),
        body: Container(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget> [
              Container(
                width:400,
                child: Center(child: AthleteList(athletes: basic, level: 'Basic')),
              ),
               Container(
                 width:400,
                 child: Center(child: AthleteList(athletes: intermediate, level: 'Intermediate'))
               ),
              Container(
                width:400,
              child: Center(child: AthleteList(athletes: advanced, level: 'Advanced'),)
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AthleteList extends StatelessWidget {
  final List<Athlete> athletes;
  final String level;

  AthleteList({required this.athletes, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            level,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: athletes.map((athlete) => AthleteCard(athlete: athlete)).toList(),
          ),
        ),
      ],
    );
  }
}

class AthleteCard extends StatelessWidget {
  final Athlete athlete;

  AthleteCard({required this.athlete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(athlete.name),
      ),
    );
  }
}
