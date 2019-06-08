import 'package:flutter/material.dart';

import 'package:gatrabali/scoped_models/news.dart';
import 'package:gatrabali/models/entry.dart';
import 'package:gatrabali/widgets/cover_image_decoration.dart';
import 'package:gatrabali/single_news.dart';

class SingleNewsCard extends StatelessWidget {
  final Entry entry;

  SingleNewsCard({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final feeds = News.of(ctx).feeds;
    final feedTitle = entry.getFeedTitle(feeds);
    final source = feedTitle == null ? '' : feedTitle;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _header(ctx, source),
          ListTile(
            title: Padding(
                padding: EdgeInsets.only(top: 7),
                child: Text(entry.title,
                    style: TextStyle(fontWeight: FontWeight.bold))),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Text("$source (${entry.formattedDate})")),
            onTap: () {
              _openDetail(ctx, source);
            },
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext ctx, String source) {
    if (entry.hasPicture) {
      return Stack(
        children: [
          CoverImageDecoration(
              url: entry.picture,
              width: null,
              height: 150.0,
              onTap: () {
                _openDetail(ctx, source);
              }),
        ],
      );
    } else {
      return Container(
        width: double.infinity,
        height: 150.0,
        color: Colors.blueGrey,
      );
    }
  }

  // Open detail page
  void _openDetail(BuildContext ctx, String source) {
    Navigator.of(ctx).pushNamed(SingleNews.routeName,
        arguments: SingleNewsArgs(source, entry));
  }
}
