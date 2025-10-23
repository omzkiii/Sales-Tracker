import 'package:app/models/listing.dart';
import 'package:app/views/input_field.dart';
import 'package:app/views/listing_operations.dart';
import 'package:flutter/material.dart';

class FormListing extends StatefulWidget {
  final bool isNew;
  final Listing? listing;
  final ListingNotifier listingNotifier;

  const FormListing({
    super.key,
    required this.isNew,
    this.listing,
    required this.listingNotifier,
  });

  @override
  State<FormListing> createState() => _FormListingState();
}

class _FormListingState extends State<FormListing> {
  final _formKey = GlobalKey<FormState>();

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
    String formTitle = widget.isNew ? "New Listing" : "Update Listing";
    Function listOperation = widget.isNew
        ? widget.listingNotifier.insertToListings
        : widget.listingNotifier.changeListing;
    IconData floatingIcon = widget.isNew ? Icons.save : Icons.edit;
    return Scaffold(
      appBar: AppBar(title: Text(formTitle)),
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
        child: Icon(floatingIcon),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Listing listing = Listing(
              id: widget.listing?.id,
              name: nameController.text,
              price: num.parse(priceController.text).toDouble(),
              desc: descController.text,
            );
            listOperation(listing);
            Navigator.pop(context, listing);
          }
        },
      ),
    );
  }
}
