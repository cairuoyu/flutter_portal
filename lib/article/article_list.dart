import 'package:cry/cry_list_view.dart';
import 'package:cry/cry_search_bar.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_portal/api/article_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_portal/article/article_preview.dart';
import 'package:flutter_portal/models/article.dart';
import 'package:get/get.dart';

class ArticleList extends StatefulWidget {
  @override
  ArticleListState createState() => ArticleListState();
}

class ArticleListState extends State<ArticleList> {
  List<Article> articleList = [];
  Article article = Article();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time')]);
  bool anyMore = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var searchForm = CrySearchBar(
      onSearch: (v) {
        this.article.title = v;
        this.reloadData();
      },
    );

    var listView = CryListView(
      cryListViewType: CryListViewType.column,
      count: articleList.length,
      getCell: (index) {
        Article article = articleList[index];
        var listTile = Column(children: [
          // const Divider(thickness: 2),
          ListTile(
            leading: Text((index + 1).toString()),
            title: Text(article.title ?? '--'),
            subtitle: Text(article.titleSub ?? ''),
          ),
        ]);
        return InkWell(
          child: listTile,
          onTap: () => Get.to(ArticlePreview(article: article)),
        );
      },
      loadMore: loadMore,
      onRefresh: reloadData,
    );
    var result = Stack(
      children: [
        Padding(
          child: listView,
          padding: EdgeInsets.only(top: 50),
        ),
        searchForm,
      ],
    );
    return result;
  }

  Future reloadData() async {
    page.current = 1;
    articleList = [];
    anyMore = true;
    await loadData();
  }

  loadMore() {
    if (!anyMore) {
      return;
    }
    page.current++;
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(params: article.toMap(), page: page);
    ResponseBodyApi responseBodyApi = await ArticleApi.pagePortal(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    articleList = [...articleList, ...page.records.map((e) => Article.fromMap(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
