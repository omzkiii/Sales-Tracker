import 'package:flutter/material.dart';

Future<String?> showDeleteDialog(
  BuildContext context,
  String item,
  List<dynamic> args,
  Function operation,
) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: Text('Delete $item?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Function.apply(operation, args);
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
