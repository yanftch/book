import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:book/domins.dart';

/// 查看大图页面
// todo 后续支持下载本地功能

class ImageGalleryPage extends StatefulWidget {
  List<StageSmallImage> images;
  int position;

  ImageGalleryPage({this.images, this.position});

  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  PageController _pageController;

  /// 定位当前索引值
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.position;
    if (widget.images != null) {
      print(
          "images.length--------------------${widget.images.length}     position=${widget.position}");
    }
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: (widget.images == null || widget.images.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: Image.asset('assets/placeholder.png'),
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: _onPageChange,
                          itemCount: widget.images.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                child: CachedNetworkImage(
                                    imageUrl: widget.images[index].imgUrl),
                              )),
                    ),
                    Positioned(
                      child: Text(
                        _showIndex(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      bottom: -1,
                      left: 10,
                    )
                  ],
                ),
              ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  /// 左下角进度值
  String _showIndex() => "${_currentIndex + 1}/${widget.images.length}";

  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
