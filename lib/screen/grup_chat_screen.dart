import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';
import '../style/palette.dart';

class GroupChatScreen extends StatefulWidget {
  String image;
  String group_name;
  String group_id;

  GroupChatScreen(
      {required this.image, required this.group_name, required this.group_id});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
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
        actions: [_popupmenuForOther(widget.group_id)],
      ),
    );
  }

  Widget _popupmenuForOther(String group_id) {
    return PopupMenuButton(
        shape: Palette.cardShape,
        offset: const Offset(100, 0),
        elevation: 8.0,
        child: Container(
          margin: EdgeInsets.only(right: 10, top: 10),
          child: Icon(Icons.more_vert),
        ),
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Value1',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // showAlertDialogForReport(context: context, postid: postid);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.edit),
                      const SizedBox(width: 10),
                      Text('Edit group details'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Value2',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // showAlertDialogForHide(context: context, postid: postid);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.group),
                      const SizedBox(width: 10),
                      Text('Add member'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Value2',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // showAlertDialogForHide(context: context, postid: postid);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.history),
                      const SizedBox(width: 10),
                      Text('Clear chat'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Value2',
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // showAlertDialogForHide(context: context, postid: postid);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      const SizedBox(width: 10),
                      Text('Delete group'),
                    ],
                  ),
                ),
              ),
            ]);
  }
}
