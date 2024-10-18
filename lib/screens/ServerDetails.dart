import 'package:baserowdroid/screens/HomePage.dart';
import 'package:baserowdroid/utils/FetchAuthToken.dart';
import 'package:baserowdroid/utils/FetchServerURL.dart';
import 'package:baserowdroid/utils/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart' as constants;

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
        if (url != constants.SERVER_URL_DEFAULT_VALUE) {
          urlController.text = url;
        }
      });
    });

    readAuthToken().then((token) {
      setState(() {
        if (token != constants.AUTH_TOKEN_DEFAULT_VALUE) {
          tokenController.text = token;
        }
      });
    });
  }

  void writeServerValues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if ((urlController.text.isEmpty) || (tokenController.text.isEmpty)) {
        showSnackBar(context, 'Please enter server details');
      } else {
        await prefs.setString('server_url', urlController.text);
        await prefs.setString('auth_token', tokenController.text);
        showSnackBar(context, 'Server details added/updated sucessfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      showSnackBar(context, 'Error occurred. Please try again');
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
                },
                child: const Text('Add/Update'),
              )
            ],
          ),
        ));
  }
}
