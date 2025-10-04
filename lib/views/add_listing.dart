import 'package:flutter/material.dart';

class AddListing extends StatefulWidget {
  const AddListing({super.key});

  @override
  State<AddListing> createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Listing")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField(inputName: "Name"),
            InputField(inputName: "Description"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String inputName;
  const InputField({super.key, required this.inputName});

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: inputName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input ${inputName.toLowerCase()}.';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
