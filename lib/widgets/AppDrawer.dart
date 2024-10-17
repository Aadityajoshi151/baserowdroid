import 'package:baserowdroid/screens/ServerDetails.dart';
import 'package:baserowdroid/utils/FetchAuthToken.dart';
import 'package:baserowdroid/utils/FetchServerURL.dart';
import 'package:flutter/material.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key, required this.title});
  final String title;

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  String server_url = '';
  String auth_token = '';

  @override
  void initState() {
    super.initState();

    // Directly call the readServerUrl function without a separate method
    readServerUrl().then((url) {
      setState(() {
        server_url = url;
      });
    });

    readAuthToken().then((token) {
      setState(() {
        if (token != "No token configured") {
          auth_token = token.substring(0, 4) +
              "-xxxx-" +
              token.substring(token.length - 4);
        } else {
          auth_token = token;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(widget.title),
            subtitle: Text(
                "Server URL: " + server_url + "\nAuth Token: " + auth_token),
          ),
          ListTile(
            leading: const Icon(Icons.dns),
            title: const Text('Add/Update Server Info'),
            onTap: () {
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
