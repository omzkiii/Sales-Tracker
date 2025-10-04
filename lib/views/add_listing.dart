import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class AddListing extends StatefulWidget {
  const AddListing({super.key});

  @override
  State<AddListing> createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Listing")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField<String>(inputName: "Name", controller: nameController),
            InputField<String>(
              inputName: "Description",
              controller: descController,
            ),
            InputField<double>(inputName: "Price", controller: priceController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            print("Name: ${nameController.text}");
            print("Desc: ${descController.text}");
            print("Price: ${priceController.text}");
            Listing listing = Listing(
              name: nameController.text,
              price: num.parse(priceController.text).toDouble(),
              desc: descController.text,
            );
            insertListing(listing);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class InputField<T> extends StatelessWidget {
  final String inputName;
  final TextEditingController controller;
  const InputField({
    super.key,
    required this.inputName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(labelText: inputName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input ${inputName.toLowerCase()}.';
                  }
                  if (T == double && num.tryParse(value) == null) {
                    return 'Please input a valid price.';
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
