class WeatherModel {
  final String cityName;
  final double temperatuer;
  final String mainCondition;

  WeatherModel({
    required this.cityName,
    required this.temperatuer,
    required this.mainCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperatuer: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
