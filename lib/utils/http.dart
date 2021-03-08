// import 'dart:async';
// import 'dart:convert';

// import 'package:aoli/config/application.dart';
// import 'package:aoli/services/storage_management.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_retry/dio_retry.dart';

// /// 请求超时时限(ms)
// const int TIME_OUT = 5000;

// /// 自动重新请求次数
// const int RETRY = 2;

// /// 自动重新请求时间间隔(ms)
// const int RETRY_INTERVAL = 500;

// class RequestMethod {
//   const RequestMethod._(this.index);

//   final index;

//   static const RequestMethod GET = RequestMethod._(0);

//   static const RequestMethod POST = RequestMethod._(1);

//   static const RequestMethod PUT = RequestMethod._(2);

//   static const RequestMethod DELETE = RequestMethod._(3);

//   static const List<String> _methods = <String>["GET", "POST", "PUT", "DELETE"];

//   @override
//   String toString() {
//     return _methods[index];
//   }
// }

// class HttpRequest<D> {
//   static Dio _dio;

//   final String url;
//   final RequestMethod method;
//   final D Function(dynamic data) transform;

//   HttpRequest(this.url, {this.method = RequestMethod.GET, this.transform}) {
//     updateDio();
//   }

//   void updateDio() {
//     _dio = Dio(BaseOptions(
//       baseUrl: Application.baseUrl,
//       connectTimeout: TIME_OUT,
//       receiveTimeout: TIME_OUT,
//     ));
//     _dio.interceptors.add(RetryInterceptor(
//         dio: _dio,
//         options: RetryOptions(
//           retries: RETRY,
//           retryInterval: const Duration(milliseconds: RETRY_INTERVAL),
//           retryEvaluator: (error) =>
//               error.type != DioErrorType.CANCEL &&
//               error.type != DioErrorType.RESPONSE,
//         )));
//   }

//   Future<D> send({
//     Map<String, dynamic> data = const <String, dynamic>{},
//     dynamic contentType,
//     bool isFormData = false,
//   }) async {
//     Map<String, dynamic> responseData;
//     responseData = await _connect(
//         data: data, contentType: contentType, isFormData: isFormData);
//     int code = responseData['status'];
//     if (code == 1) {
//       var _data = handleResponse(responseData);

//       /// transform方法未传时返回null
//       return (transform ?? (_) => null)(_data);
//     } else {
//       return _handleError(code, responseData['error']);
//     }
//   }

//   Future<Map<String, dynamic>> _connect(
//       {Map<String, dynamic> data = const <String, dynamic>{},
//       dynamic contentType,
//       bool isFormData = false}) async {
//     Response response;
//     try {
//       String token = await tokenStorage.get();
//       // print("token -> $token");
//       Map<String, dynamic> headersMap = {
//         // "authorization": token ?? '',
//       };
//       Options options = Options();
//       if (token != null) {
//         data['token'] = token;
//       }
//       var httpData = isFormData ? FormData.fromMap(data) : data;

//       if (method != RequestMethod.GET) {
//         options.headers['content-type'] = contentType ?? 'application/json';
//       }
//       switch (method) {
//         case RequestMethod.GET:
//           {
//             print("GETGETGETGET ");
//             response = await _dio.get(url,
//                 queryParameters: httpData, options: options);
//             break;
//           }
//         case RequestMethod.POST:
//           {
//             response = await _dio.post(url, data: httpData, options: options);
//             break;
//           }
//         case RequestMethod.PUT:
//           {
//             response = await _dio.put(url, data: httpData, options: options);
//             break;
//           }
//         case RequestMethod.DELETE:
//           {
//             response = await _dio.delete(url, data: httpData, options: options);
//           }
//       }
//     } on DioError catch (e) {
//       print('dio error $e');
//       if (e.response == null) {
//         throw HandleError(message: '网络异常', code: 0);
//       }
//       var result = e.response.data;

//       if (e.response.headers.value('content-type') != 'application/json') {
//         try {
//           result = json.decode(result);
//         } catch (e) {
//           result = result;
//         }
//       }
//       throw HandleError(message: result['message'], code: result['resultCode']);
//     }
//     Map<String, dynamic> responseData;
//     if (response.headers.value('content-type').contains('application/json')) {
//       responseData = response.data;
//     } else {
//       responseData = json.decode(response.data);
//     }
//     return responseData;
//   }

//   handleResponse(Map<String, dynamic> res) {
//     print('res $res');
//     return res['data'];
//   }

//   _handleError(int code, String message) {
//     /// token失效处理
//     if (code == 401) {
//       // UserStore().updateUser(null);
//       // GlobalEvents().onLogout.add(null);
//     }
//     throw HandleError(message: message, code: code);
//   }
// }

// abstract class BasicHttpService<T> {
//   /// 当前请求
//   HttpRequest get request;

//   /// 发送请求
//   Future<T> send() async {
//     return request.send();
//   }
// }

// /// 列表类请求对象
// class HttpPageRequest<D> extends HttpRequest {
//   HttpPageRequest(String url,
//       {RequestMethod method = RequestMethod.GET,
//       D Function(dynamic data) transform})
//       : super(url, method: method, transform: transform);

//   @override
//   Future<List<D>> send(
//       {Map<String, dynamic> data = const <String, dynamic>{},
//       dynamic contentType,
//       bool isFormData = false}) async {
//     Map<String, dynamic> responseData;
//     responseData = await _connect(
//         data: data, contentType: contentType, isFormData: isFormData);
//     int code = responseData['code'];
//     if (code == 2000 && transform != null) {
//       var data = responseData['data'].map((d) => transform(d));
//       return List<D>.from(data);
//     } else {
//       return _handleError(code, responseData['message']);
//     }
//   }
// }

// /// 请求异常返回数据格式
// class HandleError {
//   final String message;
//   final int code;
//   final StackTrace stack;

//   HandleError({this.message, this.code, this.stack});

//   @override
//   String toString() {
//     return message;
//   }
// }
