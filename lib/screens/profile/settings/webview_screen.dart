
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  String title;
  String url;
  WebViewScreen({
    this.title = '',
    this.url = '',
  });

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: ImageIcon(
          AssetImage('assets/icons/ic_logo_viiddo.png'),
          size: 72,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xFF7861B7),
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFFFA685),
          size: 12,
        ),
      ),
      key: scaffoldKey,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      key: formKey,
      child: Container(
        color: Color(0xFFFFFBF8),
        child: Column(
          children: <Widget>[
            (progress != 1.0)
                ? SizedBox(
                  height: 1.0,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFFFA685),
                    ),
                  ),
                )
                : null, // Should be removed while showing
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrl: widget.url,
                  initialHeaders: {},
                  onWebViewCreated: (InAppWebViewController controller) {},
                  onLoadStart:
                      (InAppWebViewController controller, String url) {},
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            )
          ].where((Object o) => o != null).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
