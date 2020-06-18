import 'package:flutter_portal/models/responeBodyApi.dart';
import 'package:flutter_portal/utils/httpUtil.dart';

class ImageApi {

  static page(data) {
    return HttpUtil.post('/image/page', data: data);
  }

  static Future<ResponeBodyApi> list(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/image/list', data: data);
    return responeBodyApi;
  }
}
