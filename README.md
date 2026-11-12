# Weathery

Weather app built with Flutter. Search for a city to view its current conditions, compare weather across featured cities, and explore the five-day forecast in a temperature chart.

## Features

- Search for weather by city name
- View current temperature, daily high and low, weather conditions, and wind speed
- Browse current weather for Cairo, Alexandria, London, Dubai, and Tokyo
- Select a featured city to load its complete forecast
- Explore forecast temperatures in an interactive chart
- Refresh weather data with pull-to-refresh or the header refresh button
- View loading and error states when weather data is unavailable

## Built with

- Flutter and Dart
- GetX for app state management
- Dio for HTTP requests
- OpenWeather for current conditions and forecast data
- Syncfusion Flutter Charts for forecast visualization

## Getting started

### Requirements

- Flutter SDK compatible with the version range in `pubspec.yaml`
- An Android or iOS device, simulator, or emulator

### Run the app

```sh
flutter pub get
flutter run
```

## Project structure

```text
lib/
├── api/        HTTP request handling
├── controller/ Reactive weather state and actions
├── model/      OpenWeather response models
├── service/    Weather API operations
└── view/       Home screen and reusable UI widgets
```

## Weather data

Weathery retrieves current weather and five-day forecast data from OpenWeather. Network requests are made over HTTPS. A production deployment should make provider requests through a backend so API credentials are not distributed in the client application.
