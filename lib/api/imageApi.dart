import 'package:flutter_portal/models/responeBodyApi.dart';
import 'package:flutter_portal/utils/httpUtil.dart';

class ImageApi {
  static Future<ResponeBodyApi> upload(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/image/upload', data: data);
    return responeBodyApi;
  }

  static Future<ResponeBodyApi> list(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/image/list', data: data);
    return responeBodyApi;
  }


}
