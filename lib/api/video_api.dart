import 'package:cry/model/response_body_api.dart';
import 'package:flutter_portal/utils/http_util.dart';

class VideoApi {
  static page(data) {
    return HttpUtil.post('/video/page', data: data);
  }

  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/video/list', data: data);
    return responseBodyApi;
  }
}
