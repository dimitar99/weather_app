# Weather App

This project consists of a weather app where we can see the current weather in different places that we can find through a search engine. The app is designed only for mobiles.
## Used Packages

- [dio](https://pub.dev/packages/dio) -> Http client used for api calls & interceptor
- [equatable](https://pub.dev/packages/equatable) -> Used for comparing saved data with the new one
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) -> Used for state management
- [flutter_typeahead](https://pub.dev/packages/flutter_typeahead) -> TypeAhead autocomplete widget used for show suggestions to the user when he's searching
- [intl](https://pub.dev/packages/flutter_bloc) & [flutter_localization](https://pub.dev/packages/flutter_localization) -> Used for app localizations

## Installation

To run the project you need to go to the root folder and execute:

```bash
  flutter pub get
```
## API Reference

[Link to api documentation](https://www.weatherapi.com/docs/)

#### Base Url

```http
  http://api.weatherapi.com/v1
```

#### Get Current Weather

```http
  /current.json
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `q` | `string` | **Required**. Search location |
| `lang` | `string` | **Optional**. Response data language |

#### Autocomplete for search

```http
  /search.json
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `q` | `string` | **Required**. Search location |
| `lang` | `string` | **Optional**. Response data language |


## Demo
<div style="justify-content:space-around; display:flex; width: auto">
  <img src="https://github.com/dimitar99/weather_app/blob/main/android_demo.gif" height="500px">
  <img src="https://github.com/dimitar99/weather_app/blob/main/ios_demo.gif" height="500px">
</div>
