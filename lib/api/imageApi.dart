import 'package:cry/model/response_body_api.dart';
import 'package:flutter_portal/utils/httpUtil.dart';

class ImageApi {

  static page(data) {
    return HttpUtil.post('/image/page', data: data);
  }

  static Future<ResponseBodyApi> list(data) async {
    ResponseBodyApi responseBodyApi = await HttpUtil.post('/image/list', data: data);
    return responseBodyApi;
  }
}
