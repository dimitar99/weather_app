import 'package:dio/dio.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/error/error_model.dart';
import 'package:weather_app/models/weather-autocomplete/weather_autocomplete_model.dart';
import 'package:weather_app/models/weather/weather_model.dart' show WeatherModel;
import 'package:weather_app/requests/interceptor/interceptor.dart';

class WeatherApi {
  /// Request for obtaining weather info from a location
  /// 
  /// Returns {WeatherModel if OK / ErrorModel if error}
  Future getCurrentWeather({String searchText = ''}) async {
    Response response;

    Map<String, String> queryParams = {};
    if (searchText.isNotEmpty) {
      queryParams.addAll({'q': searchText, 'lang': 'es'});
    }
    try {
      response = await DioInterceptor().request().get(Constants.currentWeatherEndpoint, queryParameters: queryParams);
    } on DioError catch (e) {
      int? error = e.response?.statusCode;
      if (e.response != null && e.response!.data != null && e.response!.data["error"] != null && e.response!.data["error"]!["code"] != null) {
        error = e.response!.data["error"]!["code"];
      }
      return ErrorModel(
        url: e.requestOptions.baseUrl + Constants.currentWeatherEndpoint,
        apiKey: e.requestOptions.queryParameters['key'],
        statusCode: error,
        statusMessage: e.response?.statusMessage ?? '',
        errorBody: e.requestOptions.data.toString(),
      );
    }

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      return ErrorModel;
    }
  }

  /// Request for obtaining locations match from a text
  /// 
  /// Returns {WeatherAutocompleteModel if OK / ErrorModel if error}
  Future autocompleteLocations({String searchText = ''}) async {
    Response response;

    Map<String, String> queryParams = {};
    if (searchText.isNotEmpty) {
      queryParams.addAll({'q': searchText, 'lang': 'es'});
    }

    try {
      response = await DioInterceptor().request().get(Constants.searchAutocompleteEndpoint, queryParameters: queryParams);
    } on DioError catch (e) {
      return ErrorModel(
        url: e.requestOptions.baseUrl + Constants.searchAutocompleteEndpoint,
        apiKey: e.requestOptions.queryParameters['key'],
        statusCode: e.response?.statusCode,
        statusMessage: e.response?.statusMessage ?? '',
        errorBody: e.requestOptions.data.toString(),
      );
    }

    if (response.statusCode == 200) {
      List<WeatherAutocompleteModel> list = [];
      for (var w in response.data) {
        list.add(WeatherAutocompleteModel.fromJson(w));
      }
      return list;
    } else {
      return ErrorModel;
    }
  }
}
