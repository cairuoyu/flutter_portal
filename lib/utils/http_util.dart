import 'package:bot_toast/bot_toast.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static Dio dio;

//  static const String API_PREFIX = 'http://localhost:9094/';
  static const String API_PREFIX = 'http://www.cairuoyu.com/api/p4/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String POST = 'post';
  static const String GET= 'get';

  static Future<ResponseBodyApi> get(String url, {data, requestToken = true}) async {
    Map map = await request(url, data: data, requestToken: requestToken,method: GET);
    if (map == null) {}
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(map);
    return responseBodyApi;
  }
  static Future<ResponseBodyApi> post(String url, {data, requestToken = true}) async {
    Map map = await request(url, data: data, requestToken: requestToken);
    if (map == null) {}
    ResponseBodyApi responseBodyApi = ResponseBodyApi.fromMap(map);
    return responseBodyApi;
  }

  static Future<Map> request(String url, {data, method, requestToken = true}) async {
    data = data ?? {};
    method = method ?? POST;

    Dio dio = createInstance();
    dio.options.method = method;
    var result;

    try {
      Response res = await dio.request(url, data: data);
      result = res.data;
    } on DioError catch (e) {
      BotToast.showText(text: '请求出错：' + e.toString());

      throw e.toString() + '||' + API_PREFIX + url;
    }

    return result;
  }

  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);
    }

    return dio;
  }

  static clear() {
    dio = null;
  }
}