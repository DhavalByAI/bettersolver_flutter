import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
          initialUrl: "https://bettersolver.com/demo2/terms/privacy-policy"),
    );
  }
}
