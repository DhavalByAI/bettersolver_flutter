import 'package:bettersolver/bloc/category_bloc.dart';
import 'package:bettersolver/models/category_model.dart';
import 'package:bettersolver/screen/category/category_detail_screen.dart';
import 'package:bettersolver/style/constants.dart';
import 'package:bettersolver/style/palette.dart';
import 'package:bettersolver/utils/loading.dart';
import 'package:bettersolver/utils/response.dart';
import 'package:flutter/material.dart';

import '../../bottom_navigation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryBloc? _categoryBloc;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  List categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryBloc = CategoryBloc(_keyLoader, context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            'CATEGORY',
            style: Palette.greytext20B,
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => MessageScreen()));
          //     },
          //     child: Container(
          //       height: 20,
          //       width: 20,
          //       margin: const EdgeInsets.only(right: 15),
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage('assets/images/chaticonbig.png'))),
          //     ),
          //   )
          // ],
        ),
        body: Stack(
          children: [
            Container(
              height: 20,
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
                  stream: _categoryBloc!.CategoryBlocDataStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                        case Status.COMPLETED:
                          return _list(snapshot.data.data);
                        case Status.ERROR:
                          return Container(
                            child: const Text(
                              'Errror msg',
                            ),
                          );
                      }
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _list(CategoryModel categoryModel) {
    categoryList.clear();
    categoryList.addAll(categoryModel.group);

    return ListView.builder(
        itemCount: categoryList != null ? categoryList.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (Context, index) {
          String id = categoryList[index]['id'];
          var image = categoryList[index]['avatar'];
          var name = categoryList[index]['name'];
          return Container(
            margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Row(
              children: [
                Container(
                  decoration: Palette.RoundGradient,
                  height: 50,
                  width: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        // height: 50,
                        // width: 50,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30),
                          // image: DecorationImage(
                          //     fit: BoxFit.contain,
                          //     image: CachedNetworkImageProvider(
                          //       image,
                          //     ))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Image.network(image),
                        ),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryDetailScreen(
                                    groupid: id,
                                  )));
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width ,
                      height: 50,
                      decoration: Palette.cardShapGradient,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(25))),
                            child: Container(
                                margin: const EdgeInsets.only(left: 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '$name',
                                  style: Palette.greytext12,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
