import 'package:app/views/input_field.dart';
import 'package:flutter/material.dart';

class FormExpense extends StatefulWidget {
  const FormExpense({super.key});

  @override
  State<FormExpense> createState() => _FormExpenseState();
}

class _FormExpenseState extends State<FormExpense> {
  late var nameController = TextEditingController();
  late var amountController = TextEditingController();
  late var descContoller = TextEditingController();

  String _formTitle = "Update Expense";

  @override
  void initState() {
    nameController = TextEditingController();
    amountController = TextEditingController();
    descContoller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_formTitle)),
      body: Form(
        child: Column(
          children: [
            InputField<String>(inputName: "name", controller: nameController),
            InputField<double>(
              inputName: "amount",
              controller: amountController,
            ),
            InputField<String>(inputName: "name", controller: descContoller),
          ],
        ),
      ),
    );
  }
}
