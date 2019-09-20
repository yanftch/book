import 'package:flutter/material.dart';
import 'package:book/domins.dart' show Movie, Comment;

/// 影评页面
class MovieCommentsPage extends StatefulWidget {
  List<Comment> comments;
  MovieCommentsPage(this.comments);

  @override
  _MovieCommentsPageState createState() => _MovieCommentsPageState();
}

class _MovieCommentsPageState extends State<MovieCommentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: widget.comments.length,
      itemBuilder: (context, index) => _buildItem(widget.comments[index]));

  Widget _buildItem(Comment comment) => Container(
        child: Container(
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    child: CircleAvatar(
                        child: ClipRRect(
                          child: Image.network("${comment.headImg}"),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        backgroundColor: Colors.grey[600]),
                    width: 32,
                    height: 32,
                  ),
                  SizedBox(width: 8.0),
                  Text("${comment.nickname} · ",
                      style: TextStyle(fontSize: 16.0, color: Colors.black87)),
                  Text("${comment.commentDate}"),
                  Flexible(
                    child: Align(
                      child: Text(
                        "-${comment.rating}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: 1.0,
                color: Colors.grey[400],
              ),
              Text(
                "${comment.content}",
                style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
              )
            ],
          ),
        ),
      );
}
