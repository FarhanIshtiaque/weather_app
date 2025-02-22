import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, Response;


import '../../core/constants/api_endpoints.dart';
import '../../core/constants/app_colors.dart';
import '../../core/helper/logger.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  static header() =>
      {"Content-Type": "application/json"
      };

  Future<HttpService> init() async {
    _dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          logger.i(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions
                  .path}"
                  "=> REQUEST VALUES: ${requestOptions
                  .queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          logger
              .i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request({required String url,
    required Method method,
    Map<String, dynamic>? params,
    String? authToken}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url,
          data: params,);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        // response = await _dio!.get(url, queryParameters: params,options: Options(headers:{"Authorization": authToken}));
        //FormData m = FormData.fromMap(params!);
        response = await _dio!.get(url,
            queryParameters: params,
            );
      }

      if (response.statusCode == 200) {
        return response;
      }
      if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 422) {
        return Get.snackbar('Opps', response.data['message'],
            backgroundColor: AppColors.red600,
            borderRadius: 12,
            icon: const Icon(Icons.error_outline, size: 40));
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (e) {
      logger.e(e);
      Get.snackbar('Opps', "No Internet Connection");
      throw Exception("No Internet Connection");
    } on FormatException catch (e) {
      logger.e(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      logger.e(e);
      if (e.type == DioExceptionType.unknown) {
        Get.snackbar('Opps', "There is unknown error");
      } else if (e.type == DioExceptionType.cancel) {
        Get.snackbar('Opps', "Request to API server was cancelled");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        Get.snackbar('Opps', "Connection timeout with API server");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        Get.snackbar('Opps', "Receive timeout in connection with API server");
      } else if (e.type == DioExceptionType.sendTimeout) {
        Get.snackbar('Opps', "Send timeout in connection with API server");
      } else if (e.type == DioExceptionType.badResponse) {
        logger.d(e.response);
        Get.snackbar('Opps', e.response?.data['message'],
            backgroundColor: AppColors.red300,
            borderRadius: 12,
            icon: const Icon(Icons.error_outline, size: 30));
      }

      throw Exception(e);
    } catch (e) {
      logger.e(e);
      throw Exception("Something went wrong");
    }
  }
}
