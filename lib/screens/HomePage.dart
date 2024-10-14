import 'package:baserowdroid/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title; //Name of the application

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        //TODO: add ternary operator to display the message or the tables.
        //Also use circularprogressindicator
        child: Text('No tables found'),
      ),
      drawer: Appdrawer(
        title: widget.title,
      ),
    );
  }
}
