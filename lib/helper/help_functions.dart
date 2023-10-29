import 'package:flutter/material.dart';

// Function to show errors
void displayErrorToUser(String message, BuildContext context)
{
    showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text(message),
        ),

    );
}
