import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService('c13f065d14626969aec068bc9153b144');
  Weather? _weather;

  // Fetch Weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // Additional fun features

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'snow':
      case 'ice':
      case 'freeze':
        return 'assets/snow';
      case 'wind':
      case 'gust wind':
      case 'gusty winds':
        return 'assets/windy.json';
      case 'sun':
      case 'clear':
      case 'hot':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 209, 209, 209)),
          bodyMedium: TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 255, 255, 255)),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent).copyWith(background: const Color.fromARGB(255, 82, 81, 81)),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "loading city name..."),
              LottieBuilder.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text("${_weather?.temperature.round()}°C"),
              Text(_weather?.mainCondition ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
