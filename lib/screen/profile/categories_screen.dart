import 'dart:developer';

import 'package:bettersolver/bloc/categories_bloc.dart';
import 'package:bettersolver/models/categories_model.dart';
import 'package:bettersolver/screen/category/category_detail_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CategoriesScreen extends StatefulWidget {
  String? userid;

  CategoriesScreen({super.key, this.userid});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesBloc? _categoriesBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  List categoriesList = [];

  @override
  void initState() {
    super.initState();

    _categoriesBloc = CategoriesBloc(widget.userid!, _keyLoader, context);
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
          'CATEGORIES',
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
                stream: _categoriesBloc!.categoriesBlocDataStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Loading(loadingMessage: snapshot.data.message);

                      case Status.COMPLETED:
                        return _categories(snapshot.data.data);

                      case Status.ERROR:
                        return Container(
                          child: const Text(
                            'Errror msg',
                          ),
                        );
                    }
                  }
                  return Container();
                },
              )),
        ],
      ),
    );
  }

  Widget _categories(CategoriesModel categoriesModel) {
    categoriesList.clear();
    categoriesList.addAll(categoriesModel.categoreiesData);

    return GridView.builder(
      itemCount: categoriesList != null ? categoriesList.length : 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 1.2),
      itemBuilder: (BuildContext context, int index) {
        log(categoriesList[index].toString());
        String name = categoriesList[index]['name'];
        String imagephoto = categoriesList[index]['avatar'];
        String id = categoriesList[index]['group_id'];

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryDetailScreen(
                          groupid: id,
                        )));
          },
          child: Container(
            // height: MediaQuery.of(context).size.height,
            //width: MediaQuery.of(context).size.width/2,

            margin:
                const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
            decoration: BoxDecoration(
                color: kThemeColorLightBlue,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Container(
                  // height: 100,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [kThemeColorBlue, kThemeColorGreen]),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.9),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        imagephoto))),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GradientText(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: Palette.whiteText12,
                              colors: const [kThemeColorBlue, kThemeColorGreen],
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'JOINED',
                  style: Palette.whiteText10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
