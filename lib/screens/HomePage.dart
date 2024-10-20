import 'package:baserowdroid/models/table_data_model.dart';
import 'package:baserowdroid/screens/TableDataForm.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:baserowdroid/widgets/AppDrawer.dart';
import '../utils/database_helper.dart';
import '../Constants.dart' as constants;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();
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
        //child: Text('No tables found'),
        child: FutureBuilder<List<TableData>>(
          future: dbHelper.getAllTableData(), // Fetch data from database
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading spinner while data is loading
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle any errors that might occur
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Display a message if there is no data
              return Center(child: Text('No tables available'));
            } else {
              // If data is available, display it in a ListView
              final tables = snapshot.data!;
              return ListView.builder(
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  final table = tables[index];
                  return ListTile(
                    title: Text(table.tableName), // Display table name
                    subtitle: Text('Local Table Id: ' +
                        table.id.toString() +
                        '\nBaserow Table ID: ' +
                        table.baserowTableId.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TableDataForm(
                                  title: "Update Table",
                                  tableName: table.tableName,
                                  id: table.id,
                                  baserow_table_id: table.baserowTableId,
                                );
                              }));
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              try {
                                await dbHelper.deleteTableData(table.id!);
                                showSnackBar(context, 'Table Deleted');
                                setState(() {});
                              } catch (e) {
                                showSnackBar(context, 'Error Occurred');
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            )),
                      ],
                    ),
                    onTap: () {
                      // Handle tap on ListTile if needed
                      debugPrint(table.tableName);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
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
