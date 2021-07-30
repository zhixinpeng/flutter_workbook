import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatefulWidget {
  final String url;
  final String title;

  const LoginWebView(this.url, this.title, {Key? key}) : super(key: key);

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final FocusNode focusNode = FocusNode();
  bool isLoading = true;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _renderTitle(),
      ),
      body: Stack(
        children: <Widget>[
          TextField(
            focusNode: focusNode,
          ),
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            navigationDelegate: (navigation) {
              if (navigation.url.startsWith("pengzhixin://authed")) {
                var code = Uri.parse(navigation.url).queryParameters['code'];
                print('---- code webview pop is $code ----');
                Navigator.of(context).pop(code);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitDoubleBounce(
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        S.current.loading_text,
                        style: ThemeTextStyle.middleText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _renderTitle() {
    if (widget.url.length == 0) {
      return Text(widget.title);
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
