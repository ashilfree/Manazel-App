import 'dart:async';
import 'dart:io';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'dart:io' as io;
import 'package:file/file.dart';
import 'package:path_provider/path_provider.dart';



/// Audio Recorder Plugin
class FlutterAudioRecorder {
  static const MethodChannel _channel =
      const MethodChannel('flutter_audio_recorder');
  static const String DEFAULT_EXTENSION = '.m4a';
  static LocalFileSystem fs = LocalFileSystem();

  String _path;
  String _extension;
  Recording _recording;
  int _sampleRate;

  Future _initRecorder;
  Future get initialized => _initRecorder;
  Recording get recording => _recording;

  FlutterAudioRecorder(String path, {AudioFormat audioFormat, int sampleRate = 16000}) {
    _initRecorder = _init(path, audioFormat, sampleRate);
  }

  /// Initialized recorder instance
  Future _init(String path, AudioFormat audioFormat, int sampleRate) async {
    String extension;
    String extensionInPath;
    if (path != null) {
      // Extension(.xyz) of Path
      extensionInPath = p.extension(path);
      // Use AudioFormat
      if (audioFormat != null) {
        // .m4a != .m4a

        if (_stringToAudioFormat(extensionInPath) != audioFormat) {
          // use AudioOutputFormat
          extension = _audioFormatToString(audioFormat);
          path = p.withoutExtension(path) + extension;
        } else {
          extension = p.extension(path);
        }
      } else {
        // Else, Use Extension that inferred from Path
        // if extension in path is valid
        if (_isValidAudioFormat(extensionInPath)) {
          extension = extensionInPath;
        } else {
          extension = DEFAULT_EXTENSION; // default value
          path += extension;
        }
      }


      File file = fs.file(path);
      if (await file.exists()) {
        throw new Exception("A file already exists at the path :" + path);
      } else if (!await file.parent.exists()) {
        throw new Exception("The specified parent directory does not exist");
      }
    } else {
      extension = DEFAULT_EXTENSION; // default value
    }
    _path = path;
    _extension = extension;
    _sampleRate = sampleRate;

    Map<String, Object> response;
    var result = await _channel.invokeMethod('init',
        {"path": _path, "extension": _extension, "sampleRate": _sampleRate});

    if (result != false) {
      response = Map.from(result);
    }

    _recording = new Recording()
      ..status = _stringToRecordingStatus(response['status'])
      ..metering = new AudioMetering(
          averagePower: -120, peakPower: -120, isMeteringEnabled: true);

    return;
  }

  /// Request an initialized recording instance to be [started]
  /// Once executed, audio recording will start working and
  /// a file will be generated in user's file system
  Future start() async {
    return _channel.invokeMethod('start');
  }

  /// Request currently [Recording] recording to be [Paused]
  /// Note: Use [current] to get latest state of recording after [pause]
  Future pause() async {
    return _channel.invokeMethod('pause');
  }

  /// Request currently [Paused] recording to continue
  Future resume() async {
    return _channel.invokeMethod('resume');
  }

  /// Request the recording to stop
  /// Once its stopped, the recording file will be finalized
  /// and will not be start, resume, pause anymore.
  Future<Recording> stop() async {
    Map<String, Object> response;
    var result = await _channel.invokeMethod('stop');

    if (result != null) {
      response = Map.from(result);
      _responseToRecording(response);
    }

    return _recording;
  }

  /// Ask for current status of recording
  /// Returns the result of current recording status
  /// Metering level, Duration, Status...
  Future<Recording> current({int channel = 0}) async {
    Map<String, Object> response;

    var result = await _channel.invokeMethod('current', {"channel": channel});

    if (result != null && _recording?.status != RecordingStatus.Stopped) {
      response = Map.from(result);
      _responseToRecording(response);
    }

    return _recording;
  }

  /// Returns the result of record permission
  /// if not determined(app first launch),
  /// this will ask user to whether grant the permission
  static Future<bool> get hasPermissions async {
    bool hasPermission = await _channel.invokeMethod('hasPermissions');
    return hasPermission;
  }

  ///  util - response msg to recording object.
  void _responseToRecording(Map<String, Object> response) {
    if (response == null) return;

    _recording.duration = new Duration(milliseconds: response['duration']);
    _recording.path = response['path'];
    _recording.audioFormat = _stringToAudioFormat(response['audioFormat']);
    _recording.extension = response['audioFormat'];
    _recording.metering = new AudioMetering(
        peakPower: response['peakPower'],
        averagePower: response['averagePower'],
        isMeteringEnabled: response['isMeteringEnabled']);
    _recording.status = _stringToRecordingStatus(response['status']);
  }

  Future<RecordingStatus> getState({int channel = 0})async{
    await current();
    return _recording.status;
  }

  /// util - verify if extension string is supported
  static bool _isValidAudioFormat(String extension) {
    switch (extension) {
      case ".wav":
      case ".mp4":
      case ".aac":
      case ".m4a":
      case ".mp3":
        return true;
      default:
        return false;
    }
  }

  /// util - Convert String to Enum
  static AudioFormat _stringToAudioFormat(String extension) {
    switch (extension) {
      case ".wav":
        return AudioFormat.WAV;
      case ".mp4":
        return AudioFormat.MP4;
      case ".aac":
      case ".m4a":
        return AudioFormat.AAC;
      default:
        return null;
    }
  }

  /// Convert Enum to String
  static String _audioFormatToString(AudioFormat format) {
    switch (format) {
      case AudioFormat.WAV:
        return ".wav";
      case AudioFormat.AAC:
        return ".m4a";
      case AudioFormat.MP4:
        return ".mp4";
      default:
        return ".m4a";
    }
  }

  /// util - Convert String to Enum
  static RecordingStatus _stringToRecordingStatus(String status) {
    switch (status) {
      case "unset":
        return RecordingStatus.Unset;
      case "initialized":
        return RecordingStatus.Initialized;
      case "recording":
        return RecordingStatus.Recording;
      case "paused":
        return RecordingStatus.Paused;
      case "stopped":
        return RecordingStatus.Stopped;
      default:
        return RecordingStatus.Unset;
    }
  }
}

/// Recording Object - represent a recording file
class Recording {
  /// File path
  String path;

  /// Extension
  String extension;

  /// Duration in milliseconds
  Duration duration;

  /// Audio format
  AudioFormat audioFormat;

  /// Metering
  AudioMetering metering;

  /// Is currently recording
  RecordingStatus status;
}

/// Audio Metering Level - describe the metering level of microphone when recording
class AudioMetering {
  /// Represent peak level of given short duration
  double peakPower;

  /// Represent average level of given short duration
  double averagePower;

  /// Is metering enabled in system
  bool isMeteringEnabled;

  AudioMetering({this.peakPower, this.averagePower, this.isMeteringEnabled});
}

/// Represent the status of a Recording
enum RecordingStatus {
  /// Recording not initialized
  Unset,

  /// Ready for start recording
  Initialized,

  /// Currently recording
  Recording,

  /// Currently Paused
  Paused,

  /// This specific recording Stopped, cannot be start again
  Stopped,

  Started,

  Resumed,
}

/// Audio Format,
/// WAV is lossless audio, recommended
enum AudioFormat {
  AAC,
  WAV,
  MP4,
}




class RecorderVoice{

  File _file;
  String _tag = "RecorderVoice     ";
  final LocalFileSystem _localFileSystem = LocalFileSystem();
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  StreamController<bool> stream_On_Pause;
  StreamController<bool> stream_On_Resume;
  StreamController<bool> stream_On_Init_Done;
  StreamController<bool> stream_On_recorder_started;
  StreamController<File> stream_On_Stop;
  StreamController<String> stream_On_Time_RecordListener;
  StreamController<bool> stream_On_Start_Play_Audio;
  StreamController<bool> stream_On_Stop_Play_Audio;
  StreamController<RecordingStatus> state;



  RecorderVoice(){
    stream_On_Pause = new StreamController.broadcast();
    stream_On_Resume = new StreamController.broadcast();
    stream_On_Init_Done = new StreamController.broadcast();
    stream_On_recorder_started = new StreamController.broadcast();
    stream_On_Stop = new StreamController.broadcast();
    stream_On_Start_Play_Audio = new StreamController.broadcast();
    stream_On_Stop_Play_Audio = new StreamController.broadcast();
    stream_On_Time_RecordListener = new StreamController.broadcast();
    state = new StreamController.broadcast();
  }



  RecordingStatus getStatus(){
    if(_current==null || _current.status == null){
      return null;
    }
    return _current.status;
  }


  Future<bool> isRecording()async{
    if(_current == null || _current.status == null){
      return false;
    }
    return await _recorder.getState() == RecordingStatus.Recording;
  }

  Future<bool> isInitialized()async{
    if(_current == null || _current.status == null){
      return false;
    }
    return await _recorder.getState() == RecordingStatus.Initialized;
  }

  Future<bool> isPaused()async{
    if(_current == null || _current.status == null){
      return false;
    }
    return await _recorder.getState() == RecordingStatus.Paused;
  }

  Future<bool> isStopped()async{
    if(_current == null || _current.status == null){
      return false;
    }
    return await _recorder.getState() == RecordingStatus.Stopped;
  }

  String getPath(){
    if(_current == null){
      _message("you dont have any recorder please making any record first");
      return null;
    }
    return _current.path.toString();
  }

  File getFile(){
    if(_file == null){
      _message("you dont have any recorder please making any record first");
      return null;
    }
    return _file;
  }

  dipose(){
    stream_On_Pause?.close();
    stream_On_Resume?.close();
    stream_On_Init_Done?.close();
    stream_On_recorder_started?.close();
    stream_On_Stop?.close();
    stream_On_Start_Play_Audio?.close();
    stream_On_Stop_Play_Audio?.close();
    state?.close();
    deleteAndStop();
  }

  _message(String message){
    // print(_tag+message);
  }

  // Make New Function
  static Future<List<io.File>> getListRecorder() async {
    List<io.File> files = <io.File>[];
    List<io.FileSystemEntity> file = await _dirContents(await _getDirectory());
    for(io.FileSystemEntity fileSystemEntity in file){
      io.FileSystemEntityType type = await io.FileSystemEntity.type(fileSystemEntity.path);
      if (type == io.FileSystemEntityType.FILE) {
        if(fileSystemEntity.path.contains(".temp")){
          fileSystemEntity.deleteSync(recursive: true);
        }else{
          files.add(fileSystemEntity);
        }
      }
    }
    return files;
  }

  static Future<io.Directory> _getDirectory()async{
    return io.Platform.isIOS ?  await getApplicationDocumentsDirectory() : await getExternalStorageDirectory();
  }

  static Future<List<io.FileSystemEntity>> _dirContents(io.Directory dir) {
    var files = <io.FileSystemEntity>[];
    var completer = Completer<List<io.FileSystemEntity>>();
    var lister = dir.list(recursive: false, followLinks: false);
    lister.listen ((file) => files.add(file), onDone:   () => completer.complete(files));
    return completer.future;
  }

  Future<bool> init() async {
    Completer completer = new Completer<bool>();
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        // print("hasPermissions");
        String customPath = '/flutter_audio_recorder_';

        io.Directory appDocDirectory = await _getDirectory();
        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path + customPath + DateTime.now().millisecondsSinceEpoch.toString();
        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder = FlutterAudioRecorder(customPath,audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        // should be "Initialized", if all working fine
        _current = current;
        _currentStatus = current.status;
        stream_On_Init_Done.add(true);
        completer.complete(true);
      } else {
        _message("you muste accept to use record voice");
      }
    } catch (err) {
      _message(err.toString());
    }
    return completer.future;
  }
  Timer timer;

  startRecording() async {

    if(_current!=null){
      _message(_current.status.toString());
    }

    if(await isPaused()) {
      resume();
      // print("resume");
      return;
    }

    if(await isRecording()){
      pause();
      // print("pause");
      return;
    }



    try {
      await init();
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      _current = recording;
      stream_On_recorder_started.add(true);
      state.add(RecordingStatus.Started);
      _message("on start recording");
      const tick = const Duration(milliseconds: 50);
      timer = new Timer.periodic(tick, (Timer t) async {

        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        _current = current;
        _currentStatus = _current.status;
        stream_On_Time_RecordListener.add(_printDuration(_current.duration));
      });
    } catch (err) {
      _message(err.toString());
    }
  }


  String _printDuration(Duration duration) {
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



  resume() async {

    await _recorder.resume();
    const tick = const Duration(milliseconds: 50);
    timer = new Timer.periodic(tick, (Timer t) async {

      if (_currentStatus == RecordingStatus.Stopped) {
        t.cancel();
      }

      var current = await _recorder.current(channel: 0);
      _current = current;
      _currentStatus = _current.status;
      stream_On_Time_RecordListener.add(_printDuration(_current.duration));
    });

    stream_On_Resume.add(true);
    state.add(RecordingStatus.Resumed);
    return true;
  }

  pause() async {
    await _recorder.pause();
    timer.cancel();
    stream_On_Pause.add(true);
    state.add(RecordingStatus.Paused);
    return true;
  }


 Future<io.File> stop() async {
    io.File file;
    if(_recorder == null){
      //print("_recorder == null");
      return file;
    }
    try{
      Recording result = await _recorder.stop();
      // print("Stop recording: ${result.path}");
      // print("Stop recording: ${result.duration}");
      _file = _localFileSystem.file(result.path);
      // print("File length: ${await _file.length()}");
      _current = result;
      _currentStatus = _current.status;
      stream_On_Stop.add(_file);
      state.add(RecordingStatus.Stopped);
      stream_On_Time_RecordListener.add("00:00");
      file = _file;
      return _file;
    }catch(err){
      _message("error  " + err.toString());
    }
    return file;
  }



//  void play() async {
//    AudioPlayer audioPlayer = AudioPlayer();
//    await audioPlayer.play(_current.path, isLocal: true);
//    stream_On_Start_Play_Audio.add(true);
//    audioPlayer.onPlayerCompletion.listen((onComplete){
//      stream_On_Stop_Play_Audio.add(true);
//    });
//  }


  Future<bool> deleteAndStop() async{
    await stop();
    if(_file!=null && await _file?.exists()){
      _file.deleteSync(recursive: true);
      return true;
    }
    return true;
  }


  Future<io.File> deleteAndStopAndGetFile() async{
    io.File file = _file;
    await stop();
    if(_file!=null && await _file?.exists()){
      _file.deleteSync(recursive: true);
      return file;
    }
    return file;
  }



}