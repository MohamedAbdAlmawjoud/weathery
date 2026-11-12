import 'package:flutter/material.dart';
import 'package:weathery/controller/home_controller.dart';
import 'package:weathery/view/widgets/weather_ui_helpers.dart';

class CityWeatherList extends StatelessWidget {
  final HomeController controller;
  final ValueChanged<String> onCitySelected;
  const CityWeatherList({
    super.key,
    required this.controller,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.isTopCitiesLoading.value &&
        controller.topFiveCities.isEmpty) {
      return const SizedBox(
        height: 135,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (controller.topFiveCities.isEmpty) {
      return const SizedBox(
        height: 108,
        child: Center(child: Text('City weather is unavailable')),
      );
    }
    return SizedBox(
      height: 145,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: controller.topFiveCities.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final city = controller.topFiveCities[index];
          final condition = city.weather.firstOrNull?.description ?? '';
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => onCitySelected(city.name),
            child: Container(
              width: 122,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: weatherCardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    city.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${city.main.temp.round()}°C',
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: [
                      WeatherGlyph(description: condition, size: 33),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          condition,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
