import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathery/controller/home_controller.dart';
import 'package:weathery/service/weather_service.dart';
import 'package:weathery/view/home_view.dart';

void main() {
  Get.put(WeatherService(city: 'Cairo'));
  Get.put(HomeController(weatherService: Get.find(), city: 'Cairo'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weathery',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1684b4)),
          scaffoldBackgroundColor: const Color(0xfff7f8fa),
        ),
        home: const HomeView(),
      );
}
