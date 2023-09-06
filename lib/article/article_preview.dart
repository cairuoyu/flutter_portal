import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_portal/models/article.dart';

class ArticlePreview extends StatelessWidget {
  final Article article;

  const ArticlePreview({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var body = Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? '--',
            style: textTheme.headline3,
          ),
          SizedBox(height: 20),
          Text(
            article.titleSub ?? '',
            style: textTheme.caption,
          ),
          // Divider(thickness: 2),
          SizedBox(height: 20),
          // Expanded(child: Markdown(data: '1111',)),
          Expanded(
            child: Card(
              child: article.fileUrl == null
                  ? Container()
                  : FutureBuilder<Response<String>>(
                      // initialData: Response(data: '...'),
                      future: Dio().get(article.fileUrl ?? '--'),
                      builder: (BuildContext context, AsyncSnapshot<Response<String>> snapshot) {
                        return Markdown(data: snapshot.data?.data ?? '--');
                      },
                    ),
            ),
          ),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text('查看文章'),
      ),
      body: body,
    );

    return result;
  }
}
