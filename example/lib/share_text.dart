import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:fluwx/src/response/wechat_response.dart';
import 'package:fluwx/src/share/share_models.dart';
import 'package:fluwx/src/wechat_enums.dart';
import 'package:fluwx/src/wechat_file.dart' hide FileSchema;

class ShareTextPage extends StatefulWidget {
  @override
  _ShareTextPageState createState() => _ShareTextPageState();
}

class _ShareTextPageState extends State<ShareTextPage> {
  String _text = "share text from fluwx";
  WeChatScene scene = WeChatScene.SESSION;
  Fluwx fluwx = Fluwx();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("ShareText"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: _shareText)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: TextEditingController(text: "share text from fluwx"),
              onChanged: (str) {
                _text = str;
              },
              decoration: InputDecoration(labelText: "TextToShare"),
            ),
            new Row(
              children: <Widget>[
                const Text("分享至"),
                Row(
                  children: <Widget>[
                    new Radio<WeChatScene>(
                        value: WeChatScene.SESSION,
                        groupValue: scene,
                        onChanged: handleRadioValueChanged),
                    const Text("会话")
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Radio<WeChatScene>(
                        value: WeChatScene.TIMELINE,
                        groupValue: scene,
                        onChanged: handleRadioValueChanged),
                    const Text("朋友圈")
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Radio<WeChatScene>(
                        value: WeChatScene.FAVORITE,
                        groupValue: scene,
                        onChanged: handleRadioValueChanged),
                    const Text("收藏")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _shareText() {
    fluwx.shareToWeChat(WeChatShareTextModel(_text, scene: scene)).then((data) {
      print("-->$data");
    });

//    sendAuth(WeChatSendAuthModel(scope: "snsapi_userinfo",state: "wechat_sdk_demo_test"));
  }

  void handleRadioValueChanged(WeChatScene scene) {
    setState(() {
      this.scene = scene;
    });
  }
}
