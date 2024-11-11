import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTableView extends StatefulWidget {
  final String title;
  final String primaryColumn;
  final int tableId;

  const CustomTableView(
      {super.key,
      required this.title,
      required this.primaryColumn,
      required this.tableId});

  @override
  State<CustomTableView> createState() => _CustomTableViewState();
}

class _CustomTableViewState extends State<CustomTableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: Text(widget.primaryColumn)),
    );
  }
}
