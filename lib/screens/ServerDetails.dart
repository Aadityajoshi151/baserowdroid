import 'package:baserowdroid/screens/HomePage.dart';
import 'package:baserowdroid/utils/FetchAuthToken.dart';
import 'package:baserowdroid/utils/FetchServerURL.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Serverdetails extends StatefulWidget {
  const Serverdetails({super.key, required this.title});
  final String title;

  @override
  State<Serverdetails> createState() => _ServerdetailsState();
}

class _ServerdetailsState extends State<Serverdetails> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readServerUrl().then((url) {
      setState(() {
        if (url != "No URL configured") {
          urlController.text = url;
        }
      });
    });

    readAuthToken().then((token) {
      setState(() {
        if (token != "No token configured") {
          tokenController.text = token;
        }
      });
    });
  }

  void writeServerValues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('server_url', urlController.text);
      await prefs.setString('auth_token', tokenController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Server details added/updated sucessfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred. Please try again')));
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
                  controller: urlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server URL',
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: tokenController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Token',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  writeServerValues();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Add/Update'),
              )
            ],
          ),
        ));
  }
}
