import 'package:flutter/material.dart';

class DoubleTextWidget extends StatelessWidget {
  final String biggerText, smallerText;

  const DoubleTextWidget({super.key, required this.biggerText, required this.smallerText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          biggerText,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        InkWell(
            onTap: () {},
            child: Text(
              smallerText,
              style: Theme.of(context).textTheme.displaySmall,
            ))
      ],
    );
  }
}