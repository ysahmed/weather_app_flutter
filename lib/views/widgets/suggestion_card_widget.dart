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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        )
      ]),
    );
  }
}
