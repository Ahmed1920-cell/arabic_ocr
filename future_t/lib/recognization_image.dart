import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecognizePage extends StatefulWidget {
  final String path;
  const RecognizePage({Key? key, required this.path}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    processImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recognized page"),
        ),
        body: _isBusy == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: "text goes her!!!"),
                ),
              ));
  }

  void processImage() {
    setState(() {
      _isBusy = true;
    });
    setState(() {
      _isBusy = false;
    });
  }
}
