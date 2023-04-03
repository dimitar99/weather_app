class ErrorModel {
  final String? url;
  final String? apiKey;
  final int? statusCode;
  final String? statusMessage;
  final String? errorBody;

  ErrorModel({
    required this.url,
    required this.apiKey,
    required this.statusCode,
    required this.statusMessage,
    required this.errorBody,
  });

  ErrorModel copyWith({
    String? url,
    String? apiKey,
    int? statusCode,
    String? statusMessage,
    String? errorBody,
  }) {
    return ErrorModel(
      url: url ?? this.url,
      apiKey: apiKey ?? this.apiKey,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      errorBody: errorBody ?? this.errorBody,
    );
  }

  factory ErrorModel.fromJson(Map<String, dynamic> map) {
    return ErrorModel(
      url: map['url'],
      apiKey: map['apiKey'],
      statusCode: map['statusCode'],
      statusMessage: map['statusMessage'],
      errorBody: map['errorBody'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'apiKey': apiKey,
      'statusCode': statusCode,
      'statusMessage': statusMessage,
      'errorBody': errorBody,
    };
  }

  @override
  String toString() {
    return 'ErrorModel(url: $url, apiKey: $apiKey, statusCode: $statusCode, statusMessage: $statusMessage, errorBody: $errorBody)';
  }
}
