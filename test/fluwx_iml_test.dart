import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluwx/fluwx.dart' ;
import 'package:fluwx/src/response/wechat_response.dart';
import 'package:fluwx/src/share/share_models.dart';
import 'package:fluwx/src/wechat_enums.dart';
import 'package:fluwx/src/wechat_file.dart' hide FileSchema;

void main() {
  const MethodChannel channel = MethodChannel('com.jarvanmo/fluwx');
    Fluwx  fluwx =   Fluwx();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "registerApp") {
        if (methodCall.arguments["appId"] == "wx13124324324") {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      } else if (methodCall.method == "shareText") {
        channel.invokeMethod(
            "onShareResponse", {"type": 1, "errCode": 1, "errStr": "hehe"});
        return Future.value(true);
      } else if (methodCall.method == "shareImage") {
        channel.invokeMethod(
            "onShareResponse", {"type": 1, "errCode": 0, "errStr": ""});
        return Future.value(true);
      }
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group("register", () {
    test("success", () async {
      expect(await fluwx.registerWxApi(appId: "wx13124324324"), true);
    });
    test("failed", () async {
      expect(await fluwx.registerWxApi(appId: "wx131256"), false);
    });
  });

  group("share", () {
    test("text", () async {
      expect(
          await fluwx.shareToWeChat(WeChatShareTextModel("text")), true);
    });

    test("shareImage", () async {
      expect(
          await fluwx.shareToWeChat(WeChatShareImageModel(
              WeChatImage.network("http://flutter.dev"))),
          true);
    });
  });

  group("learn", () {
    test("description", () async {
      print("argumentsss");


    });
  });
}
