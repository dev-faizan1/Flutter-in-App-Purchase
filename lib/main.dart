import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'components.dart';
import 'package:purchase/upgrade.dart';
import 'package:flutter/services.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = false;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("Code Here");

    PurchaserInfo purchaserInfo;
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();
      print(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all['all_features'] != null) {
        appData.isPro = purchaserInfo.entitlements.all['all_features'].isActive;
      } else {
        appData.isPro = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }

    print('#### is user pro? ${appData.isPro}');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home()
    );
  }
}


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: kColorPrimary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  'Welcome',
                  style: kSendButtonTextStyle.copyWith(fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    color: kColorAccent,
                    textColor: kColorText,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Purchase a subscription',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                    onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UpgradeScreen(),
                            settings: RouteSettings(name: 'Upgrade screen')));
                    }),
              ),
            ],
          ),
        ),
      );
  }
}
