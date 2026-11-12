import 'package:flutter/material.dart';

class WeatherSearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const WeatherSearchField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    textInputAction: TextInputAction.search,
    onSubmitted: (_) => onSearch(),
    style: const TextStyle(color: Colors.white, fontSize: 16),
    decoration: InputDecoration(
      hintText: 'Search for a city',
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: .85)),
      prefixIcon: const Icon(Icons.location_city, color: Colors.white),
      suffixIcon: IconButton(
        onPressed: onSearch,
        icon: const Icon(Icons.search, color: Colors.white),
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: .16),
      contentPadding: const EdgeInsets.symmetric(vertical: 17),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: .8),
          width: 1.4,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: Colors.white, width: 1.8),
      ),
    ),
  );
}
