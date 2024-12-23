import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final int highlightedIndex;

  const HighlightedText({
    super.key,
    required this.text,
    required this.highlightedIndex,
  });

  @override
  Widget build(BuildContext context) {
    List<String> words = text.split(' ');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          children:
              words.asMap().entries.map((entry) {
                int index = entry.key;
                String word = entry.value;
                return TextSpan(
                  text: '$word ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color:
                        index == highlightedIndex ? Colors.red : Colors.black,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
