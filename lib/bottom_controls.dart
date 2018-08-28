import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/theme.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

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
                    text: '她说\n',
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
                    text: '林俊杰',
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
                    Expanded(
                      child: Container(),
                    ),
                    new PreviousButton(),
                    Expanded(
                      child: Container(),
                    ),
                    new PlayPauseButton(),
                    Expanded(
                      child: Container(),
                    ),
                    new NextButton(),
                    Expanded(
                      child: Container(),
                    ),
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
    return AudioComponent(
      updateMe: [
         WatchableAudioProperties.audioPlayerState
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        IconData icon=Icons.music_note;
        Color buttonColor=lightColor;
        Function onPressed;

        if(player.state==AudioPlayerState.playing){
          icon=Icons.pause;
           onPressed=player.pause;
           buttonColor=Colors.white;
        }else if(player.state==AudioPlayerState.paused|| player.state==AudioPlayerState.completed){
          icon=Icons.play_arrow;
           onPressed=player.play;
           buttonColor=Colors.white;
        }

        return RawMaterialButton(
          shape: CircleBorder(),
          fillColor: buttonColor,
          splashColor: lightColor,
          highlightColor: lightColor.withOpacity(0.5),
          elevation: 6.0,
          highlightElevation: 3.0,
          onPressed: onPressed,
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  Icon(icon, color: darkAccentColor, size: 35.0)),
        );
      },
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: () {},
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: () {},
    );
  }
}
