import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathery/controller/home_controller.dart';
import 'package:weathery/model/current_temperatures.dart';
import 'package:weathery/view/widgets/weather_ui_helpers.dart';

class CurrentWeatherCard extends StatelessWidget {
  final HomeController controller;
  final CurrentTemperatures? weather;
  const CurrentWeatherCard({
    super.key,
    required this.controller,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.isCurrentWeatherLoading.value && weather == null) {
      return const LoadingWeatherCard(height: 282);
    }
    if (controller.currentWeatherError.value.isNotEmpty && weather == null) {
      return WeatherErrorCard(
        message: controller.currentWeatherError.value,
        onRetry: controller.updateWeather,
      );
    }
    if (weather == null) return const LoadingWeatherCard(height: 282);

    final current = weather!;
    final condition = current.weather.firstOrNull?.description ?? 'Weather';
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: weatherCardShadow,
      ),
      child: Column(
        children: [
          Text(
            current.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('EEEE, MMM d').format(DateTime.now()),
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const Divider(height: 28),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      condition,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xff626b75),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${current.main.temp.round()}°C',
                      style: const TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.w300,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Min ${current.main.tempMin.round()}°  /  Max ${current.main.tempMax.round()}°',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  WeatherGlyph(description: condition, size: 78),
                  const SizedBox(height: 7),
                  Text(
                    'Wind ${current.wind.speed} m/s',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
