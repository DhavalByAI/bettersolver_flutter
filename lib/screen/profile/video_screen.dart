import 'package:bettersolver/bloc/video_bloc.dart';
import 'package:bettersolver/models/commondata_model.dart';

import 'package:bettersolver/screen/profile/video_player.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  String? userid;

  VideoScreen({super.key, this.userid});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoBloc? _videoBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();

    _videoBloc = VideoBloc(widget.userid!, _keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhite,
        title: Text(
          'VIDEOS',
          style: Palette.greytext20B,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 30,
            decoration: Palette.loginGradient,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: StreamBuilder(
                stream: _videoBloc!.videoblocDataStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Loading(loadingMessage: snapshot.data.message);
                        break;
                      case Status.COMPLETED:
                        return _videolist(snapshot.data.data);
                        break;
                      case Status.ERROR:
                        return Container(
                          child: const Text(
                            'Errror msg',
                          ),
                        );
                        break;
                    }
                  }
                  return Container();
                },
              ))
        ],
      ),
    );
  }

  Widget _videolist(CommonDataModel commonDataModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: commonDataModel != null ? commonDataModel.data.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String video = commonDataModel.data[index];
          print("Video Link :$video");
          return SizedBox(child: VideoPlayer(post: video));
        },
        separatorBuilder: (context, index) {
          return Container(
            color: Colors.white,
            height: 20,
          );
        },
      ),
    );
  }
}
