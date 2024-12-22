// ignore_for_file: deprecated_member_use, library_private_types_in_public_api
import 'package:citybazaronline_seller_app/Utils/Theme/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String url;
  // final bool isPlayingAction;

  const VideoApp({Key? key, required this.url}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // print('isPlayingAction-------${widget.isPlayingAction}');
        setState(() {
        //   if (widget.isPlayingAction) {
        //     _controller.pause();
        //     _controller.dispose();
        //     return;
        //   }
        });
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () => setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowDialogVideo(url: widget.url);
            },
          );
          // if (_controller.value.isPlaying) {
          //   _controller.pause();
          //   _isPlaying = false;
          // }
          // else {
          //   // _controller.play();
          //   // _isPlaying = true;
          // }
        }),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(_controller),
             const Center(child: Icon(Icons.play_circle_rounded,color: ConstantColor.primaryBackgroundMainColor,)),
              // _playPauseButtonNon(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _playPauseButtonNon() {
  //   IconData iconData =_isPlaying ? Icons.pause_circle_rounded : Icons.play_circle_rounded;
  //   return Center(
  //     child: IconButton(
  //       icon: Icon(iconData,color: _isPlaying? ConstantColor.transparent1:ConstantColor.primaryBackgroundMainColor,),
  //       iconSize: 30.0,
  //       onPressed: () {
  //         // setState(() {
  //         //   if (_controller.value.isPlaying) {
  //         //     _controller.pause();
  //         //     _isPlaying = false;
  //         //   } else {
  //         //     _controller.play();
  //         //     _isPlaying = true;
  //         //   }
  //         // });
  //       },
  //     ),
  //   );
  // }
}




class ShowDialogVideo extends StatefulWidget {
  final String url;

  const ShowDialogVideo({Key? key, required this.url}) : super(key: key);

  @override
  State<ShowDialogVideo> createState() => _ShowDialogVideoState();
}

class _ShowDialogVideoState extends State<ShowDialogVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(_videoListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _videoListener() {
    if (_controller.value.isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    } else if (_controller.value.isInitialized) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildVideoDialog();
        } else {
          return const Center(child: CircularProgressIndicator(color: ConstantColor.primaryMainColor,));
        }
      },
    );
  }

  Widget _buildVideoDialog() {
    return Dialog(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_controller),
            _playPauseButton(),
          ],
        ),
      ),
    );
  }

  Widget _playPauseButton() {
    IconData iconData = _isPlaying ? Icons.pause_circle_rounded : Icons.play_circle_rounded;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

