import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///
class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3"),
        centerTitle: true,
      ),
      body: RaisedButton(child: Text("images"),onPressed: (){
        Navigator.pushNamed(context, '/image_gallery?title=abc&images=imgaeUrlS');
      },),
    );
  }
}
