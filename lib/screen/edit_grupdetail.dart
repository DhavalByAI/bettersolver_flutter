import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';
import '../style/palette.dart';

class EditGrupDetail extends StatefulWidget {
  String image;
  String group_name;
  String group_id;

  EditGrupDetail(
      {required this.image, required this.group_name, required this.group_id});

  @override
  State<EditGrupDetail> createState() => _EditGrupDetailState();
}

class _EditGrupDetailState extends State<EditGrupDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        titleSpacing: 1.0,
        flexibleSpace: Container(
          decoration: Palette.loginGradient,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
          ),
          preferredSize: Size.fromHeight(0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(widget.image),
            ),
            SizedBox(
              width: 10,
            ),
            Text('${widget.group_name}'),
          ],
        ),
        actions: [
          //_popupmenuForOther(widget.group_id)
        ],
      ),
    );
  }
}
