class WeatherAutocompleteModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;
  WeatherAutocompleteModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'url': url,
    };
  }

  factory WeatherAutocompleteModel.fromJson(Map<String, dynamic> map) {
    return WeatherAutocompleteModel(
      id: map['id'] as int,
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      url: map['url'] as String,
    );
  }

  @override
  String toString() {
    return 'WeatherAutocompleteModel(id: $id, name: $name, region: $region, country: $country, lat: $lat, lon: $lon, url: $url)';
  }
}
