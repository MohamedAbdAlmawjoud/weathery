import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weathery/controller/home_controller.dart';
import 'package:weathery/model/five_day_weather_forecast.dart';
import 'package:weathery/view/widgets/weather_ui_helpers.dart';

class ForecastChart extends StatelessWidget {
  final HomeController controller;
  const ForecastChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final forecasts = controller.fiveDayForecast.value ?? <ListElement>[];
    if (controller.isForecastLoading.value && forecasts.isEmpty) {
      return const LoadingWeatherCard(height: 275);
    }
    if (controller.forecastError.value.isNotEmpty && forecasts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WeatherErrorCard(
          message: controller.forecastError.value,
          onRetry: controller.updateWeather,
        ),
      );
    }
    if (forecasts.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text('Forecast is unavailable')),
      );
    }
    final points = forecasts
        .map(
          (item) => ForecastPoint(
            DateTime.fromMillisecondsSinceEpoch(item.dt * 1000),
            item.main['temp'] ?? 0,
          ),
        )
        .toList();

    return Container(
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(8, 17, 15, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: weatherCardShadow,
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
          majorGridLines: const MajorGridLines(width: 0),
          dateFormat: DateFormat('d HH'),
          intervalType: DateTimeIntervalType.hours,
          labelStyle: TextStyle(color: Colors.blueGrey.shade500, fontSize: 10),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          majorGridLines: MajorGridLines(
            color: Colors.blueGrey.withValues(alpha: .12),
          ),
          labelStyle: TextStyle(color: Colors.blueGrey.shade400, fontSize: 10),
          axisLine: const AxisLine(width: 0),
        ),
        series: <CartesianSeries<ForecastPoint, DateTime>>[
          SplineSeries<ForecastPoint, DateTime>(
            dataSource: points,
            xValueMapper: (point, _) => point.time,
            yValueMapper: (point, _) => point.temperature,
            color: const Color(0xff4285aa),
            width: 2.5,
            markerSettings: const MarkerSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class ForecastPoint {
  final DateTime time;
  final double temperature;
  const ForecastPoint(this.time, this.temperature);
}
