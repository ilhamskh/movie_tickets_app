import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_tickets_app/src/models/style.dart';

class CategoryItem extends StatelessWidget {
  final String emoji;
  final String title;
  const CategoryItem({super.key, required this.title, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 90,
      width: 75,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.circular(22)
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
        children: [
          TextSpan(text: emoji, style: TextStyle(fontSize: 30)),
          TextSpan(text: title,)
        ]

      )),
    );
  }
}