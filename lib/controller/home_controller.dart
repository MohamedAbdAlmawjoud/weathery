import 'package:get/get.dart';
import 'package:weathery/service/weather_service.dart';
import 'package:weathery/model/current_temperatures.dart';
import 'package:weathery/model/five_day_weather_forecast.dart';

class HomeController extends GetxController {
  final WeatherService weatherService;
  String city;

  HomeController({required this.weatherService, required this.city});

  // Current weather state
  RxBool isCurrentWeatherLoading = false.obs;
  RxString currentWeatherError = ''.obs;
  Rxn<CurrentTemperatures> currentWeather = Rxn<CurrentTemperatures>();

  // Five-day forecast state
  RxBool isForecastLoading = false.obs;
  RxString forecastError = ''.obs;
  Rxn<List<ListElement>> fiveDayForecast = Rxn<List<ListElement>>();

  // Top five cities state
  RxList<CurrentTemperatures> topFiveCities = <CurrentTemperatures>[].obs;

  RxBool isTopCitiesLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    initState();
    getTopFiveCities();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeather();
    getFiveDaysData();
  }

  Future<void> getTopFiveCities() async {
  final cities = ['Cairo', 'Alex', 'London', 'Dubai', 'Tokyo'];

  isTopCitiesLoading.value = true;
  topFiveCities.clear();

  for (final cityName in cities) {
    await weatherService.getCurrentWeather(
      city: cityName,
      onSuccess: (weather) {
        topFiveCities.add(weather);
      },
      onError: (error) {
      },
    );
  }

  isTopCitiesLoading.value = false;
  }

  void getCurrentWeather() {
    weatherService.getCurrentWeather(
      city: city,
      beforeSend: () {
        isCurrentWeatherLoading.value = true;
        currentWeatherError.value = '';
      },
      onSuccess: (weather) {
        currentWeather.value = weather;
        isCurrentWeatherLoading.value = false;
      },
      onError: (error) {
        currentWeatherError.value = error;
        isCurrentWeatherLoading.value = false;
      },
    );
  }

  void getFiveDaysData() {
    weatherService.getFiveDayForecast(
      city: city,
      beforeSend: () {
        isForecastLoading.value = true;
        forecastError.value = '';
      },
      onSuccess: (forecast) {
        fiveDayForecast.value = forecast;
        isForecastLoading.value = false;
      },
      onError: (error) {
        forecastError.value = error;
        isForecastLoading.value = false;
      },
    );
  }
}
