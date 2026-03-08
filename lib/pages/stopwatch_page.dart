import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int milliseconds = 0;
  Timer? timer;
  bool isRunning = false;
  List<String> laps = [];

  void _start() {
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        milliseconds += 10;
      });
    });

    setState(() {
      isRunning = true;
    });
  }

  void _stop() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void _reset() {
    timer?.cancel();
    setState(() {
      milliseconds = 0;
      laps.clear();
    });
  }

  void _mainButton() {
    if (isRunning) {
      _stop();
    } else {
      _start();
    }
  }

  String _formatTime() {
    int minutes = (milliseconds ~/ 60000);
    int seconds = (milliseconds ~/ 1000) % 60;
    int ms = (milliseconds % 1000) ~/ 10;

    return "${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}.${ms.toString().padLeft(2,'0')}";
  }

  void _addLap() {
    setState(() {
      laps.insert(0, _formatTime());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_formatTime(), style: TextStyle(fontSize: 50)),
        
            SizedBox(height: 30),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (!isRunning && milliseconds > 0) ? _reset : null,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    fixedSize: Size(80, 60),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Text("RST",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        
                SizedBox(width: 8),
        
                ElevatedButton(
                  onPressed: _mainButton,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRunning
                        ? Colors.white
                        : Colors.black,
                    foregroundColor: isRunning
                      ? Colors.black : Colors.white,
                    shape: CircleBorder(),
                    fixedSize: Size(100, 80),
                  ),
                  child: Text(
                    isRunning
                        ? "STOP"
                        : "START",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        
                SizedBox(width: 8),
        
                ElevatedButton(
                  onPressed: isRunning ? _addLap : null,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    fixedSize: Size(80, 60),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black
                  ),
                  child: Text("LAP",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
        
            Expanded(
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Lap ${laps.length - index}"),
                    trailing: Text(laps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
