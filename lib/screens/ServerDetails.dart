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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Server URL',
              )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Token',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('Add/Update pressed');
                },
                child: Text('Add/Update'),
              )
            ],
          ),
        ));
  }
}
