import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';


class FileRecord {

  String name="";
  String path;
  String time="";
  AudioPlayer _player;
  AudioPlayer _audioPlayer;
  Duration duration;
  File _file;
  StreamSubscription _streamOnPlayerStateChanged;


  FileRecord(File file) {
    this._file = file;
    name = file.path.toString().split("/").last;
    path = file.path;
    _newPlay();
  }

  play() async {
    _newPlay();
    await stop();
    await _player.play(path, isLocal: true);
  }

  _newPlay(){
    if (_player == null) {_player = AudioPlayer();}
  }

  stop() async{
   await _player?.stop();
  }

  pause() async{
   await _player?.pause();
  }

  resume() async{
   await _player?.resume();
  }


  stopStreamChange(){
    _streamOnPlayerStateChanged?.cancel();
  }

  onChangeState(ValueChanged<AudioPlayerState> audioPlayerState) async{
    _streamOnPlayerStateChanged = _player.onPlayerStateChanged.listen((event) {
      audioPlayerState(event);
    });
  }

  release() async{
   stopStreamChange();
   await _player.release();
  }

  seek(Duration duration) async{
   await _player.seek(duration);
  }

  onPositionChange(ValueChanged<Duration> onDuration) async{
    _player.onAudioPositionChanged.listen((event) {
      onDuration(event);
   });
  }
  onComplete(Function onComplete) async{
    _player.onPlayerCompletion.listen((event) {
      onComplete();
   });
  }

//  Future<String> getDuration()async{
//    _audioPlayer = new AudioPlayer();
//    duration = new Duration(milliseconds:  await _audioPlayer.getDurationAndroid({"uri":path}));
//    time = getTime(duration);
//    return time;
//  }

  String getTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if(duration.inHours == 1){
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void delete(){
    _file.deleteSync(recursive: true);
  }

}
