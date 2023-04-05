import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}
class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level';

  void getBatteryLevel ()
  {
    platform.invokeMethod('getBatteryLevel').then((value)
    {
      setState(() {
        batteryLevel ='battery level at $value %.';
      });
    }).catchError((error)
    {
      batteryLevel = "Failed to get battery level : '${error.message}' .";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
