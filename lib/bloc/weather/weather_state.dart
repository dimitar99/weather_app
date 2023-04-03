part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  final WeatherModel? weatherModel;
  const WeatherState({this.weatherModel});
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();

  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherState {
  WeatherLoadingState() : super(weatherModel: WeatherModel.empty);
  
  @override
  List<Object?> get props => [];
}

class WeatherSuccessState extends WeatherState {
  final WeatherModel? weatherModelState;
  const WeatherSuccessState({this.weatherModelState}) : super(weatherModel: weatherModelState);

  @override
  List<Object?> get props => [weatherModelState];
}

class WeatherErrorState extends WeatherState {
  final ErrorModel errorModelState;
  const WeatherErrorState({required this.errorModelState});

  @override
  List<Object?> get props => [];
}

class WeatherEmptyState extends WeatherState {
  final WeatherModel weatherModelState;
  const WeatherEmptyState({required this.weatherModelState});

  @override
  List<Object?> get props => [];
}