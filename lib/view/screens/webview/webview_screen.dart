import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({required this.url, Key? key});

  @override
  _WebViewPageState createState() => _WebViewPageState(this.url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String _url;
  _WebViewPageState(this._url);

  bool _loading = true;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void setState(VoidCallback fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SvgPicture.asset(
            'assets/icons/logo.png',
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_url != '')
            IconButton(
              onPressed: () {
                _controller.reload();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
            ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _url != '' ? _buildBody() : const SizedBox(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Positioned.fill(child: _buildWebView()),
        Center(
          child: _loading ? const CircularProgressIndicator(strokeWidth: 2) : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildWebView() {
    return Builder(builder: (BuildContext context) {
      return SafeArea(
        child: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) {
            _controller = webViewController;
          },
          onPageFinished: (String url) {
            _loading = false;
            setState(() {});
          },
        ),
      );
    });
  }
}
