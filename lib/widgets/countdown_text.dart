import 'dart:async';

import 'package:flutter/material.dart';

import '../core/helpers/date_helper.dart';

class CountdownText extends StatefulWidget {
  final String targetDate;
  final TextStyle? style;

  const CountdownText({super.key, required this.targetDate, this.style});

  @override
  State<CountdownText> createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final countdown = DateHelper.countdownFromString(widget.targetDate);
    setState(() {
      _remaining = countdown ?? Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(DateHelper.formatCountdown(_remaining), style: widget.style);
  }
}
