import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AmbientWatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new TimeDisplay(interval: const Duration(minutes: 1)),
      ));
}

/// Displays the time, updating on an interval state by duration
class TimeDisplay extends StatefulWidget {
  TimeDisplay({@required this.interval});
  final Duration interval;

  @override
  createState() => new _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  String _timeStr;
  Timer _timer;

  @override
  initState() {
    super.initState();
    _timeStr = _buildTime();
    _timer = Timer.periodic(
        widget.interval, (timer) => setState(() => _timeStr = _buildTime()));
  }

  @override
  dispose() {
    _timer.cancel();
    super.dispose();
  }

  static String _buildTime() {
    final time = new DateTime.now();
    final second = time.second.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '${time.hour}:$minute:$second';
  }

  @override
  Widget build(BuildContext context) => new Text(_timeStr,
      style:
          Theme.of(context).textTheme.display1.copyWith(color: Colors.white));
}
