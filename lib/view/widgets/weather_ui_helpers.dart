import 'package:flutter/material.dart';

const weatherCardShadow = [
  BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 6)),
];

class WeatherGlyph extends StatelessWidget {
  final String description;
  final double size;
  const WeatherGlyph({
    super.key,
    required this.description,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final text = description.toLowerCase();
    final icon = text.contains('rain') || text.contains('drizzle')
        ? Icons.water_drop
        : text.contains('snow')
        ? Icons.ac_unit
        : text.contains('thunder')
        ? Icons.thunderstorm
        : text.contains('cloud')
        ? Icons.wb_cloudy
        : Icons.wb_sunny_rounded;
    final sunny = icon == Icons.wb_sunny_rounded;
    return Icon(
      icon,
      size: size,
      color: sunny ? const Color(0xffffc748) : const Color(0xff6c9dbd),
    );
  }
}

class LoadingWeatherCard extends StatelessWidget {
  final double height;
  const LoadingWeatherCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Center(child: CircularProgressIndicator()),
  );
}

class WeatherErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const WeatherErrorCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, textAlign: TextAlign.center),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Try again'),
        ),
      ],
    ),
  );
}
