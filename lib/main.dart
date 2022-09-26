import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zeronet_ws/models/siteinfo.dart';
import 'package:zeronet_ws/zeronet_ws.dart';

late ZeroNet zeroNet;

const siteAddr = String.fromEnvironment(
  'SITE_ADDR',
  defaultValue: '1HELLoE3sFD9569CLCbHEAVqvqV7U2Ri9d',
);

void main() async {
  zeroNet = ZeroNet.instance;
  if (!kIsWeb) {
    await zeroNet.connect(siteAddr);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample ZeroNet Site',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sample ZeroNet Site'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? content;

  void loadSiteInfo() async {
    final info = (await zeroNet.siteInfoFuture()).siteInfo;
    content = 'Site Address: ${info.address!}';
    content = '${content!}\nPeers: ${info.peers}';
    content =
        '$content\nModified: ${DateTime.fromMillisecondsSinceEpoch(info.settings!.modified! * 1000)}';
    setState(() {});
  }

  @override
  void initState() {
    loadSiteInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (content != null)
              Text(
                content!,
                style: Theme.of(context).textTheme.headline6,
              ),
          ],
        ),
      ),
    );
  }
}
