import 'dart:convert';
import 'dart:io';
import 'package:baserowdroid/screens/CustomTableView.dart';

import '../utils/api_helper.dart';
import 'package:baserowdroid/models/table_data_model.dart';
import 'package:baserowdroid/screens/TableDataForm.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:baserowdroid/utils/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class TableTile extends StatefulWidget {
  final TableData table;
  final DatabaseHelper dbHelper;
  final VoidCallback onDelete;

  const TableTile({
    Key? key,
    required this.table,
    required this.dbHelper,
    required this.onDelete,
  }) : super(key: key);

  @override
  _TableTileState createState() => _TableTileState();
}

class _TableTileState extends State<TableTile> {
  final ApiService apiService = ApiService();
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
                                    widget.onDelete();
                                    showSnackBar(
                                        context,
                                        "Table '" +
                                            widget.table.tableName +
                                            "' Deleted");
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
      onTap: () async {
        final responsebody =
            await apiService.fetchFields(widget.table.baserowTableId);
        String? primaryColumn;
        if (responsebody != null) {
          String? primaryColumn;
          for (var item in responsebody) {
            if (item['primary'] == true) {
              primaryColumn = item['name'];
              break;
            }
          }
          print(primaryColumn);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CustomTableView(
                title: widget.table.tableName,
                tableId: widget.table.baserowTableId,
                primaryColumn: primaryColumn!);
          }));
        }
      },
    );
  }
}
