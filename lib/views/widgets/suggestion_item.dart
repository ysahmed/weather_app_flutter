import 'package:flutter/material.dart';

class SuggestionItem extends StatefulWidget {
  final String title;
  final String subtitle;

  const SuggestionItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<SuggestionItem> createState() => _SuggestionItemState();
}

class _SuggestionItemState extends State<SuggestionItem> {
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
