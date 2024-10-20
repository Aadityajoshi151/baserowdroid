import 'package:baserowdroid/models/table_data_model.dart';
import 'package:baserowdroid/screens/HomePage.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:baserowdroid/utils/database_helper.dart';
import 'package:flutter/material.dart';

class TableDataForm extends StatefulWidget {
  final String title;
  final String? tableName; // Optional tableName
  final int? id;
  final int? baserow_table_id;

  const TableDataForm({
    super.key,
    required this.title,
    this.tableName,
    this.baserow_table_id, // Optional
    this.id, // Optional
  });

  @override
  State<TableDataForm> createState() => _TableDataFormState();
}

class _TableDataFormState extends State<TableDataForm> {
  TextEditingController table_name_controller = TextEditingController();
  TextEditingController baserow_table_id_controller = TextEditingController();
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Initialize the text controller, use tableName if it's provided
    table_name_controller = TextEditingController(text: widget.tableName ?? '');
    if (widget.baserow_table_id != null) {
      baserow_table_id_controller =
          TextEditingController(text: widget.baserow_table_id.toString());
    }
  }

  void addTableDataToDB() async {
    if ((table_name_controller.text.isEmpty) ||
        (baserow_table_id_controller.text.isEmpty)) {
      showSnackBar(context, 'Please enter table details');
    } else {
      try {
        //Adding a new table
        if ((widget.tableName == null) && (widget.id == null)) {
          TableData tableData = TableData(
              tableName: table_name_controller.text,
              baserowTableId: int.parse(baserow_table_id_controller.text));
          await dbHelper.insertTableData(tableData);
          showSnackBar(context, 'Table details added sucessfully');
        } else {
          //updating an already existing table
          TableData updatedTable = TableData(
              id: widget.id,
              tableName: table_name_controller.text,
              baserowTableId: int.parse(baserow_table_id_controller.text));
          await dbHelper.updateTableData(updatedTable);
          showSnackBar(context, 'Table details updated sucessfully');
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        showSnackBar(context, 'Error occurred. Please try again');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                  controller: table_name_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Table Name',
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: baserow_table_id_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Baserow Table Id',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addTableDataToDB();
                },
                child: Text(widget.title),
              )
            ],
          ),
        ));
  }
}
