import 'package:baserowdroid/screens/TableDataForm.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:baserowdroid/utils/database_helper.dart';
import 'package:baserowdroid/widgets/TableTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/table_data_model.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  final dbHelper = DatabaseHelper();
  List<TableData> tableDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchTableData(); // Fetch table data when the page loads
  }

  void _fetchTableData() async {
    List<TableData> data = await dbHelper.getAllTableData();
    setState(() {
      tableDataList = data;
    });
  }

  void _refreshUI() {
    _fetchTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<TableData>>(
        future: dbHelper.getAllTableData(), // Fetch data from database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tables available'));
          } else {
            return ListView.builder(
              itemCount: tableDataList.length,
              itemBuilder: (context, index) {
                final table = tableDataList[index];
                return TableTile(
                    table: table, dbHelper: dbHelper, onDelete: _refreshUI);
              },
            );
          }
        },
      ),
    );
  }
}
