import 'dart:math';

import 'package:baserowdroid/utils/api_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/api_helper.dart';

class CustomTableView extends StatefulWidget {
  final String title;
  final String primaryColumn;
  final String tableId;

  const CustomTableView(
      {super.key,
      required this.title,
      required this.primaryColumn,
      required this.tableId});

  @override
  State<CustomTableView> createState() => _CustomTableViewState();
}

class _CustomTableViewState extends State<CustomTableView> {
  late ApiService apiService;
  List<dynamic> rows = [];
  List<dynamic> displayedRows = [];
  int itemsToShow = 20;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _fetchRows();
  }

  Future<void> _fetchRows() async {
    final fetchedRows =
        await apiService.fetchTableRows(int.parse(widget.tableId));
    if (fetchedRows != null) {
      setState(() {
        rows = fetchedRows;
        _loadMoreData();
      });
    }
  }

  String getDisplayValue(dynamic value) {
    if (value is Map<String, dynamic> && value.containsKey('value')) {
      return value['value'].toString();
    }
    return value?.toString() ?? "N/A";
  }

  void _loadMoreData() {
    // Calculate the next set of rows to display
    final int start = (currentPage - 1) * itemsToShow;
    final int end = (currentPage * itemsToShow).clamp(0, rows.length);

    setState(() {
      displayedRows.addAll(rows.sublist(start, end));
      currentPage++;
    });
  }

  bool _hasMoreData() {
    return displayedRows.length < rows.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search pressed");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: displayedRows.length + (_hasMoreData() ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == displayedRows.length) {
            // Show a "Load More" button if there's more data
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: TextButton(
                  onPressed: _loadMoreData,
                  child: const Text('Load More'),
                ),
              ),
            );
          }

          final row = displayedRows[index];
          return ExpansionTile(
            title: Text(row[widget.primaryColumn] ?? 'No Data'),
            children: [
              for (var key in row.keys)
                if (key != 'order') // Ignore 'order' key
                  ListTile(
                    title: Text(key),
                    subtitle: Text(
                      row[key] is Map && row[key]['value'] != null
                          ? row[key]['value'].toString()
                          : row[key]?.toString() ?? 'N/A',
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
