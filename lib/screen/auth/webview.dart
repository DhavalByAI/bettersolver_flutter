import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../style/constants.dart';
import '../../style/palette.dart';

class WebViewScreen extends StatelessWidget {
  String url;
  String title;
  WebViewScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kWhite,
          title: Text(
            title,
            style: Palette.greytext20B,
          ),
        ),
        body: Center(child: WebView(initialUrl: url)));
  }
}
