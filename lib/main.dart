import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/songs.dart';
import 'package:music_player/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xffdddddd),
          onPressed: () {},
        ),
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            color: Color(0xffdddddd),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width : 125.0,
                height : 125.0,
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Image.network(
                    demoPlaylist.songs[0].albumArtUrl,
                    scale: 1.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ),

          Container(
            width: double.infinity,
            height: 125.0,
          ),
          Container(
            width: double.infinity,
            color: accentColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
              child: Column(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Song Title\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4.0,
                          height: 1.5,
                        )),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Artist Name',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          height: 1.0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(),),
                        IconButton(icon: Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 35.0,
                          ),
                          onPressed: (){},
                        ),
                        Expanded(child: Container(),),
                        RawMaterialButton(
                          shape: CircleBorder(),
                          fillColor: Colors.white,
                          splashColor: lightColor,
                          highlightColor: lightColor.withOpacity(0.5),
                          elevation: 6.0,
                          highlightElevation: 3.0,
                          onPressed: (){},
                          child: Padding(
                            padding:EdgeInsets.all(8.0),
                            child:Icon(
                              Icons.play_arrow,
                              color:darkAccentColor,
                              size:35.0
                            )
                          ),
                        ),
                        Expanded(child: Container(),),
                        IconButton(icon: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 35.0,
                          ),
                          onPressed: (){},
                        ),
                        Expanded(child: Container(),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center:Offset(size.width/2, size.height/2),
      radius: min(size.width,size.height)/2
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}
