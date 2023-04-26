import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = "Empty Scan Code";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Builder(
          builder: (context) {
            return Center(
              child: Text(_output, style: TextStyle(color: Colors.black),),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
          tooltip: 'scan',
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Future _scan() async {
    String? barcode = await scan();
    setState(() {
      _output = barcode!;
    });
  }
}