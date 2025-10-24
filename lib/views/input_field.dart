import 'package:flutter/material.dart';

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
        bool isDescription = inputName == "Description";
        return Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                maxLines: isDescription ? 7 : 1,
                decoration: InputDecoration(
                  labelText: isDescription ? null : inputName,
                  border: isDescription ? OutlineInputBorder() : null,
                  hintText: isDescription ? 'Description' : null,
                ),
                validator: (value) {
                  if (isDescription) {
                    return null;
                  }
                  if (value == null || value.isEmpty) {
                    return 'Please input ${inputName.toLowerCase()}.';
                  }
                  if (T == double && num.tryParse(value) == null) {
                    return 'Please input a valid amount.';
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
