import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:fluwx/src/response/wechat_response.dart';
import 'package:fluwx/src/share/share_models.dart';
import 'package:fluwx/src/wechat_enums.dart';
import 'package:fluwx/src/wechat_file.dart' hide FileSchema;

class SendAuthPage extends StatefulWidget {
  @override
  _SendAuthPageState createState() => _SendAuthPageState();
}

class _SendAuthPageState extends State<SendAuthPage> {
  String _result = "无";
  Fluwx fluwx = Fluwx();
  @override
  void initState() {
    super.initState();
    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
      if (res is WeChatAuthResponse) {
        setState(() {
          _result = "state :${res.state} \n code:${res.code}";
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _result = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Auth"),
      ),
      body: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              fluwx
                  .sendWeChatAuth(
                      scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
                  .then((data) {});
            },
            child: const Text("send auth"),
          ),
          const Text("响应结果;"),
          Text(_result)
        ],
      ),
    );
  }
}
