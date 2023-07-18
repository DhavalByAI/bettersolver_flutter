import 'package:bettersolver/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
   String? video;

  VideoPlayScreen({this.video});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    print('init set video - ${widget.video}');
    _videoPlayerController = VideoPlayerController.network(widget.video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        appBar: AppBar(
          backgroundColor: kBlack,
          title: Text('video'),
          iconTheme: IconThemeData(color: kWhite),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _videoPlayerController!.value.isInitialized
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: 500,
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 1.3,
                            width: 500,
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: VideoPlayer(_videoPlayerController!))),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(onPressed: (){
                // }, child: Icon(Icons.pause)),
                InkWell(
                  onTap: () {
                    _videoPlayerController!.pause();
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    color: kWhite,
                    child: Center(child: Icon(Icons.pause)),
                  ),
                ),
                Padding(padding: EdgeInsets.all(2)),
                InkWell(
                  onTap: () {
                    _videoPlayerController!.play();
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    color: kWhite,
                    child: Center(child: Icon(Icons.play_arrow)),
                  ),
                ),
                // ElevatedButton(
                //
                //     onPressed: (){
                //
                //
                // }, child: Icon(Icons.play_arrow))
              ],
            )
          ],
        )
        // Container(
        //   margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
        //   child: Center(
        //     child: VideoPlayer(_videoPlayerController),
        //   ),
        // ),
        );
  }
}
