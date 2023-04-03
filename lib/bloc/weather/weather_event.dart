part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class AddWeatherLoading extends WeatherEvent{
  const AddWeatherLoading();
}

class AddWeatherSuccess extends WeatherEvent{
  final WeatherModel weatherModel;
  const AddWeatherSuccess(this.weatherModel);
}

class AddWeatherError extends WeatherEvent{
  final ErrorModel errorModel;
  const AddWeatherError(this.errorModel);
}

class AddWeatherEmpty extends WeatherEvent{
  final WeatherModel weatherModel;
  const AddWeatherEmpty(this.weatherModel);
}