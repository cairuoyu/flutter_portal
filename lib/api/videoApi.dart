
import 'package:flutter_portal/models/responeBodyApi.dart';
import 'package:flutter_portal/utils/httpUtil.dart';

class VideoApi {
  static Future<ResponeBodyApi> list(data) async {
    ResponeBodyApi responeBodyApi = await HttpUtil.post('/video/list', data: data);
    return responeBodyApi;
  }
}
