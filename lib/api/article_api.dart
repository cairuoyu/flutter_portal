import 'package:flutter_portal/utils/http_util.dart';

class ArticleApi {

  static pagePortal(data) {
    return HttpUtil.post('/article/pagePortal', data: data);
  }
}
