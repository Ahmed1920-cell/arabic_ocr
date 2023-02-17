import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'image_picker_class.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCamera = false;
  double r=0;


  String? _imagePath;
  Future<void> detectObject() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

// Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imagePath = imagePath;
    });
  }

  /*void onCameraTap() {
    log("Camera");
    // pickImage(source: ImageSource.camera).then((path) {
    //   if (path != '') {
    //     imageCropperView(path, context).then((value) => {
    //       if (value != '')
    //         {
    //           Navigator.push(
    //             context,
    //             CupertinoPageRoute(
    //               builder: (_) => RecognizePage(
    //                 path: value,
    //               ),
    //             ),
    //           ),
    //         }
    //     });
    //   }
    // });
  }*/

/*  void onGallaryTap() {
    log("Gallary");
    // pickImage(source: ImageSource.gallery).then((path) {
    //   if (path != '') {
    //     galleryObject(path);
    //   }
    // });
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child:
    Scaffold(
        appBar: AppBar(
          title: Text("Arabic OCR"),
        ),
        body: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Container(
              width: double.infinity,
              height: 580,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey
              ),
              child: Center(child: Text("Recent Document",style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500,color: Colors.black),))
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: detectObject,
        child: Icon(Icons.camera_alt_outlined),
      ),
    ));
  }}