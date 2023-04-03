import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:weather_app/generated/l10n.dart';

import 'package:weather_app/helpers/weather_icons.dart';
import 'package:weather_app/models/weather-autocomplete/weather_autocomplete_model.dart';
import 'package:weather_app/models/weather/weather_model.dart';
import 'package:weather_app/requests/weather/weather_api.dart';
import 'package:weather_app/styles/colors.dart';

import '../../bloc/signal-check/signal_check_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../models/error/error_model.dart';
import '../../styles/decorations.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<WeatherAutocompleteModel> listOfAutocomplete = [];

  @override
  void initState() {
    _initialSteps();
    super.initState();
  }

  /// That code will be executed after page widget tree is created
  _initialSteps() async {
    _getWeather('canals', addLoadingState: true);
  }

  /// Uses [searchTxt] to search that place in the WeatherApi. If the response is a WeatherModel adds <br>
  /// AddWeatherSucces event to WeatherBloc & if the response is ErrorModel adds AddWeatherError event. <br>
  /// If [addLoadingState] == true, adds AdddWeatherLoading event.
  Future _getWeather(String searchTxt, {bool addLoadingState = false}) async {
    if (addLoadingState) BlocProvider.of<WeatherBloc>(context).add(const AddWeatherLoading());
    var response = await WeatherApi().getCurrentWeather(searchText: searchTxt);
    if (response is ErrorModel) {
      if (mounted) BlocProvider.of<WeatherBloc>(context).add(AddWeatherError(response));
    } else {
      if (mounted) BlocProvider.of<WeatherBloc>(context).add(AddWeatherSuccess(response));
    }
  }

  /// Uses [searchTxt] to found places that match that string & return a list of them. <br>
  /// If there are no matches, return an empty list
  Future<List<WeatherAutocompleteModel>> _getAutocomplete(String searchTxt) async {
    List<WeatherAutocompleteModel> listToReturn = [];
    if (_textEditingController.text.isNotEmpty) {
      var response = await WeatherApi().autocompleteLocations(searchText: searchTxt);
      if (response is ErrorModel) {
        listToReturn = [];
      } else {
        setState(() => listOfAutocomplete = response);
        listToReturn = response;
      }
    }
    return listToReturn;
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors["black"],
        body: SafeArea(
          child: BlocBuilder<SignalCheckBloc, SignalCheckState>(
            builder: (context, state) {
              return Column(
                children: [
                  _searchField(),
                  _pageBody(mediaquery),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: TypeAheadField<WeatherAutocompleteModel>(
        hideOnError: true,
        hideOnEmpty: true,
        hideOnLoading: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: _textEditingController,
          style: TextStyle(color: colors["white"]),
          decoration: Decorations.searchFieldDecoration(),
        ),
        debounceDuration: const Duration(milliseconds: 500),
        suggestionsCallback: (text) async => await _getAutocomplete(text),
        itemBuilder: (context, WeatherAutocompleteModel item) => _searchFieldItemBuilder(item),
        onSuggestionSelected: (suggestion) => _getWeather(suggestion.url, addLoadingState: true),
      ),
    );
  }

  ListTile _searchFieldItemBuilder(WeatherAutocompleteModel item) {
    return ListTile(title: Text('${item.name} (${item.region})'), subtitle: Text(item.country));
  }

  BlocBuilder<WeatherBloc, WeatherState> _pageBody(MediaQueryData mediaquery) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return _loadingBody();
        }
        if (state is WeatherSuccessState) {
          return _successStateBody(mediaquery, state);
        }
        if (state is WeatherErrorState) {
          return _errorStateBody(mediaquery.size, state);
        }
        // Default -> (state is WeatherInitialState)
        return Container();
      },
    );
  }

  Expanded _loadingBody() => const Expanded(child: Center(child: CircularProgressIndicator()));

  Widget _successStateBody(MediaQueryData mediaquery, WeatherState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: double.infinity),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _date(),
                    if (state.weatherModel?.location?.name != null) _locationName(mediaquery.size, state),
                    _weatherImage(state),
                    _moreInfo(state),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _date() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Text(
        DateFormat('d MMMM, yyyy').format(DateTime.now()),
        style: TextStyle(fontSize: 14, color: colors["white"], fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _locationName(Size size, WeatherState state) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: size.width,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: state.weatherModel!.location!.name!,
            style: TextStyle(fontSize: 28, color: colors["white"], fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: '\n(${state.weatherModel!.location!.region!})',
            style: TextStyle(fontSize: 28, color: colors["white"], fontWeight: FontWeight.w600),
          ),
        ]),
      ),
    );
  }

  Widget _weatherImage(WeatherState state) {
    String icon = state.weatherModel!.current!.condition!.icon!;
    String iconCode = icon.substring(icon.lastIndexOf("/") + 1, icon.lastIndexOf("."));
    bool isDay = state.weatherModel!.current!.isDay == 1;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Image.asset(
            isDay ? WeatherIcons().getDayIconByCode(iconCode) : WeatherIcons().getNightIconByCode(iconCode),
            height: 150,
            width: 150,
          ),
        ),
        _tempAndCondition(state),
      ],
    );
  }

  Widget _tempAndCondition(WeatherState state) {
    return Column(
      children: [
        Text(
          '${state.weatherModel?.current?.tempC ?? '0'}º',
          style: TextStyle(fontSize: 32, color: colors["white"]),
        ),
      ],
    );
  }

  Widget _moreInfo(WeatherState state) {
    WeatherModel? weatherModel = state.weatherModel;
    if (weatherModel == null) return Container();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customChip(icon: Icons.air, description: '${weatherModel.current?.windKph} km/h'),
              _customChip(icon: Icons.explore_outlined, description: '${weatherModel.current?.windDir}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customChip(title: 'UV', description: '${weatherModel.current?.uv} %'),
              _customChip(assetImage: 'assets/images/barometer.png', description: '${weatherModel.current?.pressureMb} mb'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _customChip(icon: Icons.water_drop_outlined, description: '${weatherModel.current?.humidity} %'),
              _customChip(icon: Icons.water, description: '${weatherModel.current?.precipMm} mm'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customChip({String? assetImage, IconData? icon, String? title, required String description}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: colors["white"],
      ),
      child: Row(
        children: [
          if (assetImage != null) Image.asset(assetImage, height: 22, width: 22),
          if (icon != null) Icon(icon),
          if (title != null) Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text(description),
          ),
        ],
      ),
    );
  }

  /// Location not found
  Widget _errorStateBody(Size size, WeatherErrorState state) {
    return Expanded(
      child: Container(
        // _searchField() height(48) + padding(16)
        margin: const EdgeInsets.only(bottom: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/error.png', height: 150, width: 150),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Text(
                S.current.errorOcurred,
                style: TextStyle(fontSize: 20, color: colors["white"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
