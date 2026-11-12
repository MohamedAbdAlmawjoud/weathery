import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(22, 23, 22, 10),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.blueGrey.shade700,
        fontWeight: FontWeight.w700,
        fontSize: 13,
        letterSpacing: .8,
      ),
    ),
  );
}
