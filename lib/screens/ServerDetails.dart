import 'package:flutter/material.dart';

class Serverdetails extends StatefulWidget {
  const Serverdetails({super.key, required this.title});
  final String title;

  @override
  State<Serverdetails> createState() => _ServerdetailsState();
}

class _ServerdetailsState extends State<Serverdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(child: Text('Server Details')),
    );
  }
}
