import 'package:flutter/material.dart';

class TableDataForm extends StatefulWidget {
  const TableDataForm({super.key, required this.title});
  final String title;

  @override
  State<TableDataForm> createState() => _TableDataFormState();
}

class _TableDataFormState extends State<TableDataForm> {
  final TextEditingController table_name_controller = TextEditingController();
  final TextEditingController baserow_table_id_controller =
      TextEditingController();

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
                obscureText: true,
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
                  debugPrint("Add Table to DB");
                },
                child: Text(widget.title),
              )
            ],
          ),
        ));
  }
}
