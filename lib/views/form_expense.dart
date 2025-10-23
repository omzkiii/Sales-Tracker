import 'package:app/models/expenses.dart';
import 'package:app/views/expense_operations.dart';
import 'package:app/views/input_field.dart';
import 'package:flutter/material.dart';

class FormExpense extends StatefulWidget {
  final int listingId;
  final ExpenseNotifier expenseNotifier;
  final bool isNew;
  final Expense? expense;
  final int? index;
  const FormExpense({
    super.key,
    required this.listingId,
    required this.expenseNotifier,
    required this.isNew,
    this.expense,
    this.index,
  });

  @override
  State<FormExpense> createState() => _FormExpenseState();
}

class _FormExpenseState extends State<FormExpense> {
  final _formKey = GlobalKey<FormState>();
  late var nameController = TextEditingController();
  late var amountController = TextEditingController();
  late var descContoller = TextEditingController();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.expense?.name);
    amountController = TextEditingController(
      text: widget.expense?.amount.toString(),
    );
    descContoller = TextEditingController(text: widget.expense?.desc);
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
    String formTitle = widget.isNew ? "New Expense" : "Update Expense";
    Function expenseOperation = widget.isNew
        ? widget.expenseNotifier.addToExpenses
        : widget.expenseNotifier.modifyExpenses;
    IconData floatingIcon = widget.isNew ? Icons.save : Icons.edit;

    return Scaffold(
      appBar: AppBar(title: Text(formTitle)),
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
        child: Icon(floatingIcon),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Expense expense = Expense(
              id: widget.isNew
                  ? null
                  : widget.expenseNotifier.list[widget.index!].id,
              listingId: widget.listingId,
              name: nameController.text,
              amount: num.parse(amountController.text).toDouble(),
              desc: descContoller.text,
            );
            expenseOperation(expense);
            Navigator.pop(context, true);
          }
        },
      ),
    );
  }
}
