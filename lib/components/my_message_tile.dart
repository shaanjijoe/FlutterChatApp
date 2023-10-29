import 'package:flutter/material.dart';

class MyMessageTile extends StatelessWidget {
  final String message;
  final String subTitle;
  const MyMessageTile({
    super.key,
    required this.message,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
              title: Text(message),
              subtitle: Text(subTitle, style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),),
          ),
        ),
    );
  }
}
