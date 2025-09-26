import 'package:flutter/material.dart';
import 'package:flutter_minimal_weather_app/models/weather_model.dart';
import 'package:flutter_minimal_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('82daaaa07fc75e94f68d27c5babd3c0c');
  WeatherModel? _weatherModel;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrenCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/Weather-sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds': return 'assets/cloudy.json';
      case 'mist': return 'assets/Weather-mist.json';
      case 'smoke': return 'assets/Weather-mist.json';
      case 'haze': return 'assets/Weather-mist.json';
      case 'dust': return 'assets/Weather-mist.json';
      case 'fog': return 'assets/Foggy.json';
      case 'rain': return 'assets/Weather-partly shower.json';
      case 'drizzle': return 'assets/Weather-partly shower.json';
      case 'shower rain': return 'assets/Weather-mist.json';
      case 'thunderstorm': return 'assets/Weather-storm&showers(day).json';
      case 'clear': return 'assets/Weather-sunny.json';
      default:
        return 'assets/Weather-sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 32,),
                  Text(_weatherModel?.cityName ?? 'Loading city..', style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
                ],
              ),
            ),
            Lottie.asset(getWeatherAnimation(_weatherModel?.mainCondition)),
            Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Text('${_weatherModel?.temperatuer.round()}°C', style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
            ),
           // Text(_weatherModel?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
