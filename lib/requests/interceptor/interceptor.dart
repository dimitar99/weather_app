import 'dart:developer';

import 'package:dio/dio.dart';

import '../../constants/constants.dart';

class DioInterceptor {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  DioInterceptor();

  Dio request() {
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        /// Method execute before making the request
        /// Add the common options to the request, usually an access token or some specific header
        onRequest: (requestOptions, handler) {
          // Add the api key to the request as a query param
          requestOptions.queryParameters.addAll({'key': Constants.apiKey});
          log('---DioInterceptor.onRequest()------');
          log('Endpoint -> ${requestOptions.path}');
          log('Query Parms -> ${requestOptions.queryParameters}');

          // Continue to the next step -> onResponse or onError
          handler.next(requestOptions);
          log('Next');
        },

        /// Method executed when request has ended with a success
        onResponse: (resp, handler) {
          log('---DioInterceptor.onResponse()------');
          log('Status Code --> ${resp.statusCode}');
          log('Status Message --> ${resp.statusMessage}');
          log('Data --> ${resp.data}');

          // Continue with the next request in queue or end the process
          handler.next(resp);
        },

        /// Method executed when request has ended with an error
        onError: (error, handler) {
          log('---DioInterceptor.onError()------');
          log('Status Code --> ${error.response?.statusCode}');
          log('Status Message --> ${error.response?.statusMessage}');
          log('Data --> ${error.response?.data}');

          // Retry call one time
          _retryCall(error.requestOptions, handler);
        },
      ),
    );
    return dio;
  }

  Future _retryCall(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    log('---DioInterceptor.retryCall()------');
    final opts = Options(
      validateStatus: (_) => true,
      receiveDataWhenStatusError: true,
      method: requestOptions.method,
      responseType: requestOptions.responseType,
    );
    dynamic response;
    try {
      response = await dio.request(requestOptions.path, options: opts, data: requestOptions.data, queryParameters: requestOptions.queryParameters);
      log('---Success------');
      log('Status Code --> ${response.statusCode}');
      log('Status Message --> ${response.statusMessage}');
      log('Data --> ${response.data}');
      // Solves request with a success response & continue with the next request in queue or end the process
      handler.resolve(response);
    } on DioError catch (error) {
      log('---Error------');
      log('Status Code --> ${error.response?.statusCode}');
      log('Status Message --> ${error.response?.statusMessage}');
      log('Data --> ${error.response?.data}');
      // Return an error & exits request queue
      handler.reject(error);
    }
    return response;
  }
}
