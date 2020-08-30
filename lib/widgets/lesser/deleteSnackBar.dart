import 'package:flutter/material.dart';

class DeleteSnackBar extends SnackBar {
  DeleteSnackBar({
    @required String name,
    @required void Function() onPressed,
  }) : super(
            content: Text('You deleted $name'),
            duration: const Duration(milliseconds: 1000),
            backgroundColor: Colors.grey[500],
            action: SnackBarAction(label: 'Restore', onPressed: onPressed));
}
