
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rxdart/rxdart.dart';



class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    @required this.currentPosition,
    @required this.duration,
    @required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {


    bool hasData(){
      return widget.duration.inMilliseconds > 0;
    }


    return Visibility(
      visible: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Text(durationToString(widget.currentPosition)),
            ),
            Expanded(
              child: NeumorphicSlider(
                min: 0,
                max: hasData() ? widget.duration.inMilliseconds.toDouble() : 1.0,
                value: hasData() ? percent * widget.duration.inMilliseconds.toDouble() : 0.0,
                style:
                SliderStyle(variant: Colors.grey, accent: Colors.grey[500]),
                onChangeEnd: (newValue) {
                  setState(() {
                    listenOnlyUserInterraction = false;
                    widget.seekTo(_visibleValue);
                  });
                },
                onChangeStart: (_) {
                  setState(() {
                    listenOnlyUserInterraction = true;
                  });
                },
                onChanged: (newValue) {
                  setState(() {
                    final to = Duration(milliseconds: newValue.floor());
                    _visibleValue = to;
                  });
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(durationToString(widget.duration)),
            ),
          ],
        ),
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
  final twoDigitMinutes =
  twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
  twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}



class MyAudio {
  final Audio audio;
  final String name;

  const MyAudio({
    @required this.audio,
    @required this.name,
  });
}



class AudioPlayerWidget extends StatefulWidget {
  final String file;
  final MyAudio myAudio;
  final ValueChanged<AudioPlayerWidgetState> onPlay;
  AudioPlayerWidget({Key key, this.file, this.onPlay, this.myAudio}) : super(key: key);
  @override
  AudioPlayerWidgetState createState() => AudioPlayerWidgetState();
}

class AudioPlayerWidgetState extends State<AudioPlayerWidget> {


  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    _assetsAudioPlayer.playlistFinished.listen((data) {

    });
    _assetsAudioPlayer.playlistAudioFinished.listen((data) {

    });
    _assetsAudioPlayer.current.listen((data) {

    });
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return Container(
        height: 65,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          elevation: 4.0,
          color: Colors.white.withOpacity(0.3),
          child: Padding(
              padding: EdgeInsets.only(left: 5,right: 5,bottom: 2,top: 2),
              child:  Row(
                children: <Widget>[

                  Flexible(
                      flex: 1,
                      child: new IconButton(
                          icon: Icon(Icons.play_arrow,color: Colors.white.withOpacity(0.8),),
                          onPressed: () async{
                            if (_assetsAudioPlayer.current.value == null) {
                              _assetsAudioPlayer.open(widget.myAudio.audio,
                                  autoStart: true);
                            } else {
                              _assetsAudioPlayer.playOrPause();
                            }
                          })
                  ),

                  Flexible(
                      flex: 4,
                      child: StreamBuilder(
                          stream: _assetsAudioPlayer.realtimePlayingInfos,
                          builder: (context, AsyncSnapshot<RealtimePlayingInfos> snapshot) {
                            final infos = snapshot.data;
                            return PositionSeekWidget(
                              seekTo: (to) {
                                _assetsAudioPlayer.seek(to);
                              },
                              duration: snapshot.data == null ? Duration(seconds: 0) : infos.duration,
                              currentPosition: snapshot.data == null ? Duration(seconds: 0) :  infos.currentPosition,
                            );
                          })
                  )
                ],
              )
          ),
        )
    );
  }



}