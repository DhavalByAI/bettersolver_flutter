import 'package:bettersolver/bloc/photos_bloc.dart';
import 'package:bettersolver/models/commondata_model.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  String? userid;

  PhotoScreen({super.key, this.userid});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  PhotosBloc? _photosBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photosBloc = PhotosBloc(widget.userid!, _keyLoader, context);
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
          'PHOTOS',
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
                stream: _photosBloc!.photosBlocDataStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Loading(loadingMessage: snapshot.data.message);
                        break;
                      case Status.COMPLETED:
                        return _categories(snapshot.data.data);
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
              )),
        ],
      ),
    );
  }

  Widget _categories(CommonDataModel commonDataModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: commonDataModel != null ? commonDataModel.data.length : 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 11 / 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          String image = commonDataModel.data[index];
          return Padding(
            padding: const EdgeInsets.all(0),
            child: InkWell(
              onTap: () {
                MultiImageProvider multiImageProvider = MultiImageProvider(
                    List.generate(commonDataModel.data.length, ((index) {
                      return Image(
                          image: CachedNetworkImageProvider(
                        commonDataModel.data[index],
                      )).image;
                    })),
                    initialIndex: index);
                showImageViewerPager(
                    context,
                    backgroundColor: Colors.black.withAlpha(110),
                    multiImageProvider,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                    useSafeArea: true);
              },
              child: Container(
                // margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(image))),
              ),
            ),
          );
        },
      ),
    );
  }
}
