import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_notification_background/local_notification_flutter.dart';
import 'package:local_notification_background/second_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final LocalNotificationService service;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    service = LocalNotificationService();
    listenNotification();
    service.intialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    final isBackGround = state == AppLifecycleState.paused;

    if (isBackGround) {
      if (kDebugMode) {
        Future.delayed(Duration(seconds: 3), () async {
          print('delayed execution');
          await service.showPayloadNotification(id: 0, title: "Payload Title", body: "Payload BOdy",payload: "payload navigation");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Local Notification"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await service.showNotification(id: 0, title: "Test Title", body: "Test BOdy");
                },
                child: Text("Show Notification"))
          ],
        ),
      ),
    );
  }

  void listenNotification() => service.onNotificationClick.stream.listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    if(payload!=null&&payload.isNotEmpty){
      print('payload $payload');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreem(payload: payload ,)),
      );
    }
  }
}
