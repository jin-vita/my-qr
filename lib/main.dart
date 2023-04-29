import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart';

// flutter pub add qrscan
// flutter pub add permission_handler
// flutter pub add audio_video_progress_bar
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = "No scanned QR value yet";
  int mySize = 15;
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('QR sample'),
              actions: [
                IconButton(
                  onPressed: () {
                    themeNotifier.value =
                        themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                  },
                  icon: Icon(
                    themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text('Text Size Control'),
                    SizedBox(
                      width: 300,
                      child: ProgressBar(
                        progress: Duration(minutes: mySize),
                        total: const Duration(minutes: 30),
                        onSeek: (percent) {
                          setState(() {
                            mySize = percent.inMinutes;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                        child: Text(
                      _output,
                      style: TextStyle(fontSize: mySize.toDouble()),
                    )),
                  ],
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
      },
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scan();
    setState(() {
      _output = barcode!;
    });
  }
}
