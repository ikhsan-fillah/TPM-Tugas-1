import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int startHour = 0;
  int startMinute = 0;
  int startSecond = 0;

  late int milliseconds;
  int lastLapTime = 0;
  Timer? timer;
  bool isRunning = false;
  List<String> laps = [];
  List<String> lapOverallTimes = [];

  @override
  void initState() {
    super.initState();

    milliseconds =
        startHour * 60 * 60 * 1000 +
        startMinute * 60 * 1000 +
        startSecond * 1000;
  }

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
      lastLapTime = 0;
      laps.clear();
      lapOverallTimes.clear();
      isRunning = false;
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
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds ~/ 60000) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    int ms = (milliseconds % 1000) ~/ 10;

    return "${hours.toString().padLeft(2, '0')}:"
          "${minutes.toString().padLeft(2, '0')}:"
          "${seconds.toString().padLeft(2, '0')}."
          "${ms.toString().padLeft(2, '0')}";
  }

  String _formatLap(int time) {
    int hours = time ~/ 3600000;
    int minutes = (time ~/ 60000) % 60;
    int seconds = (time ~/ 1000) % 60;
    int ms = (time % 1000) ~/ 10;

    return "${hours.toString().padLeft(2, '0')}:"
          "${minutes.toString().padLeft(2, '0')}:"
          "${seconds.toString().padLeft(2, '0')}."
          "${ms.toString().padLeft(2, '0')}";
  }

  void _addLap() {
    setState(() {
      int lapTime = milliseconds - lastLapTime;
      lastLapTime = milliseconds;

      laps.insert(0, _formatLap(lapTime));
      lapOverallTimes.insert(0, _formatLap(milliseconds));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _formatTime(),
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w300,
                        color: colorScheme.onPrimaryContainer,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (!isRunning && milliseconds > 0)
                          ? _reset
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: const Size(72, 72),
                        backgroundColor: colorScheme.surfaceContainerHigh,
                        foregroundColor: colorScheme.onSurface,
                      ),
                      child: const Text("RST", style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _mainButton,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRunning
                            ? colorScheme.errorContainer
                            : colorScheme.primary,
                        foregroundColor: isRunning
                            ? colorScheme.onErrorContainer
                            : colorScheme.onPrimary,
                        shape: const CircleBorder(),
                        fixedSize: const Size(96, 96),
                        elevation: 4,
                      ),
                      child: Text(
                        isRunning ? "STOP" : "START",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: isRunning ? _addLap : null,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        fixedSize: const Size(72, 72),
                        backgroundColor: colorScheme.surfaceContainerHigh,
                        foregroundColor: colorScheme.onSurface,
                      ),
                      child: const Text("LAP", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: colorScheme.primaryContainer,
                          child: Text(
                            "${laps.length - index}",
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        title: Text("Lap ${laps.length - index}"),
                        subtitle: Text(
                          laps[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Overall Time",
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              lapOverallTimes[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.secondary,
                                fontFeatures: const [FontFeature.tabularFigures()],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}