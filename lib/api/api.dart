// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// Dio dio = Dio();

// class ApiService {
//   final baseUrl = kDebugMode ? "base" : "base";
//   initApiService() async {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         headers: {'Content-Type': 'application/json'},
//       ),
//     );
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest:
//             (RequestOptions options, RequestInterceptorHandler handler) async {
//               print(options.path);
//               return handler.next(options);
//             },
//         onResponse: (Response response, ResponseInterceptorHandler handler) {
//           print(response.data);
//           return handler.next(response);
//         },
//         onError: (DioException error, ErrorInterceptorHandler handler) {
//           if (error.type == DioExceptionType.connectionError) {
//             Get.showSnackbar(
//               GetSnackBar(
//                 message: "Please check your Internet.",
//                 duration: Duration(seconds: 1),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           } else {
//             Get.showSnackbar(
//               GetSnackBar(
//                 message:
//                     error.response?.data['message'].toString() ??
//                     "Something went wrong.",
//                 duration: Duration(seconds: 1),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }

//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   bool setToken(token) {
//     dio.options.headers['Authorization'] = "Bearer $token";
//     return dio.options.headers['Authorization'] == "Bearer $token";
//   }

//   Future<Response> getApiCall(
//     String endPoint, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     return await dio.get(
//       endPoint,
//       queryParameters: queryParameters,
//       data: data,
//     );
//   }

//   Future<Response> postApiCall(
//     String endPoint, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     return await dio.post(
//       endPoint,
//       data: data,
//       queryParameters: queryParameters,
//     );
//   }

//   Future<Response> putApiCall(String endPoint, Object? data) async {
//     return await dio.put(endPoint, data: data);
//   }

//   Future<Response> deleteApiCall(
//     String endPoint, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     return await dio.delete(endPoint, queryParameters: queryParameters);
//   }
// }
