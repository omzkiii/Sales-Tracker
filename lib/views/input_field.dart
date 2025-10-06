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
