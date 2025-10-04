import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:flutter/material.dart';

class FormListing extends StatefulWidget {
  final bool isNew;
  final Listing? listing;
  const FormListing({super.key, required this.isNew, this.listing});

  @override
  State<FormListing> createState() => _FormListingState();
}

class _FormListingState extends State<FormListing> {
  final _formKey = GlobalKey<FormState>();

  String _formTitle = "Update Listing";

  Function _listOperation = updateListing;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.listing?.name);

    final descController = TextEditingController(text: widget.listing?.desc);

    final priceController = TextEditingController(
      text: widget.listing?.price.toString(),
    );

    if (widget.isNew) {
      _formTitle = "New Listing";
      _listOperation = insertListing;
    }
    return Scaffold(
      appBar: AppBar(title: Text(_formTitle)),
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
            Listing listing = Listing(
              id: widget.listing?.id,
              name: nameController.text,
              price: num.parse(priceController.text).toDouble(),
              desc: descController.text,
            );
            _listOperation(listing);
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
