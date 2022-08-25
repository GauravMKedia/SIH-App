import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webper extends StatelessWidget {
  const Webper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: WebView(
          initialUrl:
              'https://wecapable.com/tools/text-to-sign-language-converter/',
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
