import 'package:baserowdroid/screens/TableDataForm.dart';
import 'package:baserowdroid/widgets/AppDrawer.dart';
import 'package:baserowdroid/widgets/TablesView.dart';
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
      body: TablesView(),
      drawer: Appdrawer(
        title: constants.APP_NAME,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TableDataForm(title: "Add Table");
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
