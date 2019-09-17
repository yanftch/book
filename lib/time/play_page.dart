import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

/// 视频播放页面
/// [videoUrl] 视频地址
class VideoPlayPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  VideoPlayPage({@required this.videoUrl, @required this.title});
  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  IjkMediaController _controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void play() async {
      await _controller.setNetworkDataSource(widget.videoUrl,
                  autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.play_arrow),
          //   onPressed: () async {
          //     await _controller.setNetworkDataSource(widget.videoUrl,
          //         autoPlay: true);
          //   },
          // )
        ],
      ),
      body: Container(
        child: IjkPlayer(
          mediaController: _controller,
        ),
      ),
    );
  }
}
