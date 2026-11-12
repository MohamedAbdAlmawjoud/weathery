import 'package:weathery/api/api_repo.dart';
import 'package:weathery/model/current_temperatures.dart';
import 'package:weathery/model/five_day_weather_forecast.dart';

class WeatherService {
  String city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String apiKey = '3539ac330c775a118c15231a0d1327ca';
  final ApiRepo _apiRepo;

  WeatherService({required this.city, ApiRepo? apiRepo})
      : _apiRepo = apiRepo ?? ApiRepo();

  // Get current weather
  Future<void> getCurrentWeather({
    required String city, 
    required void Function(CurrentTemperatures weather) onSuccess,
    required void Function(String error) onError,
    void Function()? beforeSend,
  }) async {
    await _apiRepo.getData(
      url: '$baseUrl/weather',
      queryParameters: {
        'q': city,
        'appid': apiKey,
        'units': 'metric',
      },
      beforeSend: beforeSend,
      onSuccess: (data) {
        final weather = CurrentTemperatures.fromMap(data);
        onSuccess(weather);
      },
      onError: onError,
    );
  }

  // Get five-day weather forecast
 Future<void> getFiveDayForecast({
  String? city,
  required void Function(List<ListElement> forecast) onSuccess,
  required void Function(String error) onError,
  void Function()? beforeSend,
}) async {
  await _apiRepo.getData(
    url: '$baseUrl/forecast',
    queryParameters: {
      'q': city ?? this.city,
      'appid': apiKey,
      'units': 'metric',
    },
    beforeSend: beforeSend,
    onSuccess: (data) {
      final response = FiveDayWeatherForecast.fromMap(data);

      onSuccess(response.list);
    },
    onError: onError,
  );
}
}
