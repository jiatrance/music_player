import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/bottom_controls.dart';
import 'package:music_player/songs.dart';
import 'package:music_player/theme.dart';
import 'package:fluttery/gestures.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

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
  double _seekPercent;
  @override
  Widget build(BuildContext context) {
    return Audio(
      audioUrl: demoPlaylist.songs[0].audioUrl,
      playbackState: PlaybackState.paused,
      child: Scaffold(
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
                child: AudioComponent(
                    updateMe: [
                  WatchableAudioProperties.audioPlayhead,
                  WatchableAudioProperties.audioSeeking
                ],
                    playerBuilder: (BuildContext context, AudioPlayer player,
                        Widget child) {
                      double playbackProgress = 0.0;
                      if (player.audioLength != null &&
                          player.position != null) {
                        playbackProgress = player.position.inMilliseconds /
                            player.audioLength.inMilliseconds;
                      }
                      _seekPercent = player.isSeeking ? _seekPercent : null;
                      return RadialSeekBar(
                        progress: playbackProgress,
                        seekPercent: _seekPercent,
                        onSeekRequested: (double seekPercent) {
                          setState(() {
                            _seekPercent = seekPercent;
                          });
                          final seekMills =
                              (player.audioLength.inMilliseconds * seekPercent)
                                  .round();
                          player.seek(Duration(milliseconds: seekMills));
                        },
                      );
                    })),
            Container(
              width: double.infinity,
              height: 125.0,
            ),
            new BottomControls(),
          ],
        ),
      ),
    );
  }
}

class RadialSeekBar extends StatefulWidget {
  final double seekPercent;
  final double progress;
  final Function(double) onSeekRequested;

  RadialSeekBar(
      {this.seekPercent = 0.0, this.progress = 0.0, this.onSeekRequested});

  @override
  RadialSeekBarState createState() {
    return new RadialSeekBarState();
  }
}

class RadialSeekBarState extends State<RadialSeekBar> {
  double _progress = 0.0;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _cuurentDragPercent;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _progress = widget.progress;
  }

  void _onDragStart(PolarCoord coord) {
    _startDragCoord = coord;
    _startDragPercent = _progress;
  }

  void _onDragUpdate(PolarCoord coord) {
    final dragAngle = coord.angle - _startDragCoord.angle;
    final dragPercent = dragAngle / (2 * pi);

    setState(() {
      _cuurentDragPercent = (_startDragPercent + dragPercent) % 1.0;
    });
  }

  void _onDragEnd() {
    if (widget.onSeekRequested != null) {
      widget.onSeekRequested(_cuurentDragPercent);
    }
    setState(() {
      _cuurentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = _progress;
    if (_cuurentDragPercent != null) {
      thumbPosition = _cuurentDragPercent;
    } else if (widget.seekPercent != null) {
      thumbPosition = widget.seekPercent;
    }

    return RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 225.0,
            height: 225.0,
            child: RadialProgressBar(
              progressPercent: _progress,
              thumbPosition: thumbPosition,
              trackColor: const Color(0xffe0e0e0),
              progressColor: accentColor,
              thumbColor: lightColor,
              innerPadding: const EdgeInsets.all(15.0),
              child: ClipOval(
                clipper: CircleClipper(),
                child: Image.network(
                  demoPlaylist.songs[0].albumArtUrl,
                  scale: 1.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialProgressBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPosition;
  final Widget child;
  final EdgeInsets innerPadding;

  RadialProgressBar(
      {this.trackWidth = 4.0,
      this.trackColor = Colors.grey,
      this.progressWidth = 6.0,
      this.progressColor = Colors.black,
      this.progressPercent = 0.2,
      this.thumbSize = 10.0,
      this.thumbColor = Colors.black,
      this.thumbPosition = 0.2,
      this.child,
      this.innerPadding = const EdgeInsets.all(0.0)});

  @override
  State<StatefulWidget> createState() {
    return _RadialSeekBarState();
  }
}

class _RadialSeekBarState extends State<RadialProgressBar> {
  EdgeInsets _insetsForPainter() {
    final outerThickness =
        max(widget.trackWidth, max(widget.progressWidth, widget.thumbSize)) /
            2.0;
    return EdgeInsets.all(outerThickness);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: RadialSeekBarPainter(
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressWidth: widget.progressWidth,
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
          thumbSize: widget.thumbSize,
          thumbColor: widget.thumbColor,
          thumbPosition: widget.thumbPosition),
      child: Padding(
        padding: _insetsForPainter() + widget.innerPadding,
        child: widget.child,
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final double trackWidth;
  final Color trackColor;
  final Paint trackPaint;
  final double progressWidth;
  final Color progressColor;
  final Paint progressPaint;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final Paint thumbPaint;
  final double thumbPosition;

  RadialSeekBarPainter({
    @required this.trackWidth,
    @required this.trackColor,
    @required this.progressWidth,
    @required this.progressColor,
    @required this.progressPercent,
    @required this.thumbSize,
    @required this.thumbColor,
    @required this.thumbPosition,
  })  : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    Size constrainedSize =
        Size(size.width - outerThickness, size.height - outerThickness);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    canvas.drawCircle(center, radius, trackPaint);

    final progressAngle = 2 * pi * progressPercent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        progressAngle, false, progressPaint);

    final thunmRadius = thumbSize / 2;
    final thumbAngle = 2 * pi * thumbPosition - pi / 2;
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX, thumbY) + center;
    canvas.drawCircle(thumbCenter, thunmRadius, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: min(size.width, size.height) / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
