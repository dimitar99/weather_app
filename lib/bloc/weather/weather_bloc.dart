import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/error/error_model.dart';

import 'package:weather_app/models/weather/weather_model.dart';

import 'package:flutter/material.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherInitialState()) {
    on<AddWeatherLoading>(_addWeatherLoadingToBloc);
    on<AddWeatherSuccess>(_addWeatherToBloc);
    on<AddWeatherError>(_addWeatherErrorToBloc);
    on<AddWeatherEmpty>(_addWeatherEmptyToBloc);
  }

  FutureOr<void> _addWeatherLoadingToBloc(AddWeatherLoading event, Emitter<WeatherState> emit) {
    emit(WeatherLoadingState());
  }

  FutureOr<void> _addWeatherToBloc(AddWeatherSuccess event, Emitter<WeatherState> emit) {
    // Update saved value in bloc if it's not equal (Equatable)
    emit(WeatherSuccessState(weatherModelState: event.weatherModel));
  }

  FutureOr<void> _addWeatherErrorToBloc(AddWeatherError event, Emitter<WeatherState> emit) {
    emit(WeatherErrorState(errorModelState: event.errorModel));
  }

  FutureOr<void> _addWeatherEmptyToBloc(AddWeatherEmpty event, Emitter<WeatherState> emit) {
    emit(WeatherEmptyState(weatherModelState: event.weatherModel));
  }
}
