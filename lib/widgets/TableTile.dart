import 'package:baserowdroid/models/table_data_model.dart';
import 'package:baserowdroid/screens/TableDataForm.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:baserowdroid/utils/database_helper.dart';
import 'package:flutter/material.dart';

class TableTile extends StatefulWidget {
  final TableData table;
  final DatabaseHelper dbHelper;

  const TableTile({
    Key? key,
    required this.table,
    required this.dbHelper,
  }) : super(key: key);

  @override
  _TableTileState createState() => _TableTileState();
}

class _TableTileState extends State<TableTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.table.tableName), // Display table name
      subtitle: Text('Local Table Id: ' +
          widget.table.id.toString() +
          '\nBaserow Table ID: ' +
          widget.table.baserowTableId.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TableDataForm(
                    title: "Update Table",
                    tableName: widget.table.tableName,
                    id: widget.table.id,
                    baserow_table_id: widget.table.baserowTableId,
                  );
                }));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("Are You Sure?"),
                          content: Text("This will delete '" +
                              widget.table.tableName +
                              "' table entry from this device. No changes are made on the Baserow instance."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('No'),
                            ),
                            TextButton(
                                onPressed: () async {
                                  try {
                                    await widget.dbHelper
                                        .deleteTableData(widget.table.id!);
                                    showSnackBar(context, 'Table Deleted');
                                    setState(() {});
                                  } catch (e) {
                                    showSnackBar(context, 'Error Occurred');
                                  }
                                  Navigator.pop(context, 'Yes');
                                },
                                child: Text("Yes"))
                          ],
                        ));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.deepOrange,
              )),
        ],
      ),
      onTap: () {
        debugPrint(widget.table.tableName);
      },
    );
  }
}