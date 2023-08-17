import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constant/configuration/url_routes.dart';
import '../data/repository/prefs_repository_impl.dart';
import '../domin/repositories/prefs_repository.dart';
import 'di_container.config.dart';


final GetIt _getIt = GetIt.I;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() async => $initGetIt(_getIt);

@module
abstract class AppModule {
  BaseOptions get dioOption => BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
  @singleton
  Logger get logger => Logger();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @preResolve
  @singleton
  Future<PrefsRepository> get prefsRepository async {
    SharedPreferences prefs = await sharedPreferences;
    return PrefsRepositoryImpl(prefs);
  }

  @singleton
  Dio dio(BaseOptions option , Logger logger) {
    final dio = Dio(option);
    dio.interceptors.add(LoggerInterceptor());
    return dio;
  }
}
class LoggerInterceptor extends Interceptor {
  final PrefsRepository _prefsRepository = GetIt.I<PrefsRepository>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      log(_prefsRepository.token.toString());
      log(
        "***|| INFO Request ${options.path.substring(Urls.baseUrl.length)} ||***"
            "\n HTTP Method: ${options.method}"
            "\n token : ${options.headers[HttpHeaders.authorizationHeader]?.substring(0, 20)}"
            "\n param : ${options.data}"
            "\n url: ${options.path}"
            "\n Header: ${options.headers}"
            "\n timeout: ${options.connectTimeout! ~/ 1000}s",
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      "***|| INFO Response Request  '✊✊✊✊✊✊✊✊✊✊✊' } ||***"
          "\n Status code: ${response.statusCode}"
          "\n Status message: ${response.statusMessage}"
          "\n Data: ${response.data}",
    );
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        "***|| SOMETHING ERROR 💔💔💔💔💔💔 ||***"
            "\n error: ${err.error}"
            "\n response: ${err.response}"
            "\n message: ${err.message}"
            "\n type: ${err.type}"
            "\n stackTrace: ${err.stackTrace}",
      );
    }
    handler.next(err);
  }
}