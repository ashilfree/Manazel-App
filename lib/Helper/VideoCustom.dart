
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoCustom extends StatefulWidget {
  final String url;
  final bool enableApectRatio;
  final bool showControls;
  ChewieController chewieController;

  VideoCustom({Key key, this.url, this.enableApectRatio = false, this.showControls = false, this.chewieController}) : super(key: key);

  stop(){
    if(chewieController == null){
      return;
    }
    if(chewieController.isPlaying){
       chewieController.pause();
    }
  }

  @override
  _VideoCustomState createState() => _VideoCustomState();
}

class _VideoCustomState extends State<VideoCustom> {

  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController1;


  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _videoPlayerController1 = VideoPlayerController.network(widget.url);
      await Future.wait([_videoPlayerController1.initialize(),]);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        showControls: true,
        autoPlay: true,
        looping: false,
      );
      widget.chewieController = _chewieController;
      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {

    return Center(
      child: _chewieController != null &&
          _chewieController.videoPlayerController.value.isInitialized
          ? Chewie(
        controller: _chewieController,
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading'),
        ],
      ),
    );

  }
}

