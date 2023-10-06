import 'package:flutter/material.dart';

class SuggestionCard extends StatefulWidget {
  final String title;
  final String subtitle;

  const SuggestionCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          widget.subtitle,
        )
      ]),
    );
  }
}
