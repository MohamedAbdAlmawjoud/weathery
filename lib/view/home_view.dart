import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathery/controller/home_controller.dart';
import 'package:weathery/view/widgets/city_weather_list.dart';
import 'package:weathery/view/widgets/current_weather_card.dart';
import 'package:weathery/view/widgets/forecast_chart.dart';
import 'package:weathery/view/widgets/home_header.dart';
import 'package:weathery/view/widgets/section_title.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.find();
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchCity() {
    final city = searchController.text.trim();
    if (city.isEmpty) return;
    controller.city = city;
    controller.updateWeather();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Obx(() {
      // Register all dashboard state here so async loading, errors, and
      // city/forecast updates rebuild the composed screen.
      controller.isCurrentWeatherLoading.value;
      controller.currentWeatherError.value;
      controller.isTopCitiesLoading.value;
      controller.topFiveCities.length;
      controller.isForecastLoading.value;
      controller.forecastError.value;
      controller.fiveDayForecast.value;
      return RefreshIndicator(
        onRefresh: () async => controller.updateWeather(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            HomeHeader(
              onRefresh: controller.updateWeather,
              searchController: searchController,
              onSearch: searchCity,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                child: CurrentWeatherCard(
                  controller: controller,
                  weather: controller.currentWeather.value,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionTitle(title: 'OTHER CITIES'),
            ),
            SliverToBoxAdapter(
              child: CityWeatherList(
                controller: controller,
                onCitySelected: (city) {
                  searchController.text = city;
                  controller.city = city;
                  controller.updateWeather();
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionTitle(title: 'FORECAST — NEXT 5 DAYS'),
            ),
            SliverToBoxAdapter(child: ForecastChart(controller: controller)),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          ],
        ),
      );
    }),
  );
}
