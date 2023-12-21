import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opengl_texture/opengl_texture.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = new OpenGLTextureController();
  final _width = 500.0;
  final _height = 500.0;

  @override
  initState() {
    super.initState();

    initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('OpenGL via Texture widget example'),
        ),
        body: Stack(
          children: [
            Positioned(
              child: Container(
                width: _width,
                height: _height,
                child: _controller.isShow
                    ? new Texture(textureId: _controller.textureId)
                    : null,
              ),
            ),
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: 3,
                    ),
                    children: [
                      ElevatedButton(
                        child: Text('create'),
                        onPressed: () async {
                          await _controller.initialize(_width, _height);
                          setState(() {});
                        },
                      ),
                      ElevatedButton(
                        child: Text('destroy'),
                        onPressed: () async {
                          await _controller.dispose();
                          setState(() {});
                        },
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  Future<Null> initializeController() async {
    await _controller.initialize(_width, _height);
    setState(() {});
  }
}
