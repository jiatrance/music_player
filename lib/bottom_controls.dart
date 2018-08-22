import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/theme.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: accentColor,
      child: Material(
        shadowColor: Color(0x44000000),
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

                    new PreviousButton(),
                    Expanded(child: Container(),),

                    new PlayPauseButton(),
                    
                    Expanded(child: Container(),),

                    new NextButton(),
                    Expanded(child: Container(),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
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
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(
      Icons.skip_previous,
      color: Colors.white,
      size: 35.0,
      ),
      onPressed: (){},
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(
      Icons.skip_next,
      color: Colors.white,
      size: 35.0,
      ),
      onPressed: (){},
    );
  }
}