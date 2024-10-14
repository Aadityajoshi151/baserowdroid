import 'package:baserowdroid/screens/ServerDetails.dart';
import 'package:flutter/material.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key, required this.title});
  final String title;

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(widget.title),
            subtitle: const Text(
                //TODO: use server url stored in memory
                'http://192.168.29.73:5050'),
          ),
          ListTile(
            leading: const Icon(Icons.dns),
            title: const Text('Add/Update Server Info'),
            onTap: () {
              debugPrint("add/update server URL pressed");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Serverdetails(title: 'Server Details');
              }));
            },
          ),
        ],
      ),
    );
  }
}
