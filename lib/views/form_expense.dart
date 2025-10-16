import 'package:app/controllers/expense.dart';
import 'package:app/models/expenses.dart';
import 'package:app/views/expense_operations.dart';
import 'package:app/views/input_field.dart';
import 'package:flutter/material.dart';

class FormExpense extends StatefulWidget {
  final int listingId;
  final ExpenseNotifier expenseNotifier;
  const FormExpense({
    super.key,
    required this.listingId,
    required this.expenseNotifier,
  });

  @override
  State<FormExpense> createState() => _FormExpenseState();
}

class _FormExpenseState extends State<FormExpense> {
  final _formKey = GlobalKey<FormState>();
  late var nameController = TextEditingController();
  late var amountController = TextEditingController();
  late var descContoller = TextEditingController();

  String _formTitle = "Update Expense";
  // Function _expenseOperation = updateListing;
  IconData _floatingIcon = Icons.edit;

  @override
  void initState() {
    nameController = TextEditingController();
    amountController = TextEditingController();
    descContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_formTitle)),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField<String>(inputName: "Name", controller: nameController),
            InputField<double>(
              inputName: "Amount",
              controller: amountController,
            ),
            InputField<String>(
              inputName: "Description",
              controller: descContoller,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_floatingIcon),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Expense expense = Expense(
              listingId: widget.listingId,
              name: nameController.text,
              amount: num.parse(amountController.text).toDouble(),
              desc: descContoller.text,
            );
            widget.expenseNotifier.addToExpenses(expense);
            Navigator.pop(context, true);
          }
        },
      ),
    );
  }
}
