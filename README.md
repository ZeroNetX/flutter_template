# flutter_template

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Environment

`flutter doctor`  output
```
[√] Flutter (Channel stable, 3.3.0, on Microsoft Windows [Version 10.0.22000.1042], locale en-IN)
[√] Android toolchain - develop for Android devices (Android SDK version 31.0.0)
[√] Chrome - develop for the web
[√] Visual Studio - develop for Windows (Visual Studio Build Tools 2019 16.11.15)
[√] Android Studio (version 2021.2)
[√] VS Code (version 1.71.2)
[√] Connected device (3 available)
[√] HTTP Host Availability
```

## Build

Except Web Environment you can compile Apps normally, Flutter Web need some patching see below for more info.

## Compatibility

You can access ZeroFrame API access/ZeroNetX Websocket Commands using zeronet_ws package in `pubspec.yaml` file.
```yaml
dependencies:
  zeronet_ws: #^0.0.8 #versioned
    git: https://github.com/ZeroNetX/zeronet_ws.git #git repo
```

### Flutter Web

Add below line in your index.html

```html
<head>
...
<script type="text/javascript" src="assets/packages/zeronet_ws/js/ZeroFrame.js"></script>
</head>
```

Flutter Web Apps needs monkeyPatching to load files, thus index.html' should load _flutter Engine as below without this your Web App will failed to load.
```html
<body>
  <script>
    // `frame` variable is accessed by bindings of lib, thus name should not be changed.
    var frame = new ZeroFrame();
    frame.monkeyPatchAjax();
    frame.cmd("siteInfo", [], function () {
      var script = document.createElement("script");
      script.src = "main.dart.js";
      script.type = "text/javascript";
      document.body.appendChild(script);

      //Uncomment Below for MaterialIcons Support
      /*
      script = document.createElement("script");
      script.src = "assets/fonts/MaterialIcons-Regular.otf";
      script.type = "application/octet-stream";
      document.body.appendChild(script);
      */

      _flutter.loader.loadEntrypoint(null).then(function (engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function (appRunner) {
        return appRunner.runApp();
      });
    });
  </script>
</body>
```

### Build Web App


```flutter build web --pwa-strategy=none --dart-define=SITE_ADDR=1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M --dart-define=FLUTTER_WEB_CANVASKIT_URL=/raw/1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M/canvaskit/ --base-href=/1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M/```

> Note: In the above build step `1Mc588z8kuAEDQu8VFetR9vKaxHPyRax4M` is example site address, You need to replace that address with your own.

