import 'package:app/controllers/listing.dart';
import 'package:app/models/listing.dart';
import 'package:app/views/input_field.dart';
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
  IconData _floatingIcon = Icons.edit;

  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.listing?.name);
    descController = TextEditingController(text: widget.listing?.desc);
    priceController = TextEditingController(
      text: widget.listing?.price.toString(),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNew) {
      _formTitle = "New Listing";
      _listOperation = insertListing;
      _floatingIcon = Icons.save;
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
        child: Icon(_floatingIcon),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Listing listing = Listing(
              id: widget.listing?.id,
              name: nameController.text,
              price: num.parse(priceController.text).toDouble(),
              desc: descController.text,
            );
            _listOperation(listing);
            Navigator.pop(context, true);
          }
        },
      ),
    );
  }
}
