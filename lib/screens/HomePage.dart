import 'package:baserowdroid/widgets/AppDrawer.dart';
import '../Constants.dart' as constants;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.APP_NAME),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        //TODO: add ternary operator to display the message or the tables.
        //Also use circularprogressindicator
        child: Text('No tables found'),
      ),
      drawer: Appdrawer(
        title: constants.APP_NAME,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Add table pressed');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
