import 'package:flutter/material.dart';

// ==================== SHAKE ANIMATION CONTROLLER ====================

class ShakeController {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  ShakeController(
    TickerProvider vsync, {
    Duration duration = const Duration(milliseconds: 500),
    double distance = 10.0,
  }) {
    _controller = AnimationController(duration: duration, vsync: vsync);

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: distance), weight: 1),
      TweenSequenceItem(
        tween: Tween(begin: distance, end: -distance),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -distance, end: distance),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: distance, end: -distance),
        weight: 2,
      ),
      TweenSequenceItem(tween: Tween(begin: -distance, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Animation<double> get animation => _animation;

  Future<void> shake() async {
    await _controller.forward(from: 0.0);
  }

  void dispose() {
    _controller.dispose();
  }
}

// ==================== SHAKE WIDGET ====================

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double distance;
  final ShakeAxis axis;
  final bool enabled;

  const ShakeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.distance = 10.0,
    this.axis = ShakeAxis.horizontal,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late ShakeController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(
      this,
      duration: widget.duration,
      distance: widget.distance,
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> shake() async {
    if (widget.enabled) {
      await _shakeController.shake();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController.animation,
      builder: (context, child) {
        final offset = _shakeController.animation.value;
        return Transform.translate(
          offset: widget.axis == ShakeAxis.horizontal
              ? Offset(offset, 0)
              : Offset(0, offset),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ==================== SHAKE AXIS ====================

enum ShakeAxis { horizontal, vertical }

// ==================== AUTO SHAKE WIDGET ====================

class AutoShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration interval;
  final double distance;
  final ShakeAxis axis;
  final bool autoStart;

  const AutoShakeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.interval = const Duration(seconds: 3),
    this.distance = 10.0,
    this.axis = ShakeAxis.horizontal,
    this.autoStart = true,
  }) : super(key: key);

  @override
  State<AutoShakeWidget> createState() => _AutoShakeWidgetState();
}

class _AutoShakeWidgetState extends State<AutoShakeWidget>
    with SingleTickerProviderStateMixin {
  late ShakeController _shakeController;
  bool _isShaking = false;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(
      this,
      duration: widget.duration,
      distance: widget.distance,
    );
    if (widget.autoStart) {
      _startAutoShake();
    }
  }

  void _startAutoShake() async {
    while (mounted) {
      await Future.delayed(widget.interval);
      if (mounted && !_isShaking) {
        _isShaking = true;
        await _shakeController.shake();
        _isShaking = false;
      }
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController.animation,
      builder: (context, child) {
        final offset = _shakeController.animation.value;
        return Transform.translate(
          offset: widget.axis == ShakeAxis.horizontal
              ? Offset(offset, 0)
              : Offset(0, offset),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ==================== SHAKE ERROR WIDGET ====================

class ShakeErrorWidget extends StatefulWidget {
  final Widget child;
  final bool hasError;
  final Duration duration;
  final double distance;
  final VoidCallback? onShakeComplete;

  const ShakeErrorWidget({
    Key? key,
    required this.child,
    required this.hasError,
    this.duration = const Duration(milliseconds: 500),
    this.distance = 8.0,
    this.onShakeComplete,
  }) : super(key: key);

  @override
  State<ShakeErrorWidget> createState() => _ShakeErrorWidgetState();
}

class _ShakeErrorWidgetState extends State<ShakeErrorWidget>
    with SingleTickerProviderStateMixin {
  late ShakeController _shakeController;
  bool _previousError = false;

  @override
  void initState() {
    super.initState();
    _shakeController = ShakeController(
      this,
      duration: widget.duration,
      distance: widget.distance,
    );
  }

  @override
  void didUpdateWidget(ShakeErrorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !_previousError) {
      _shakeController.shake().then((_) {
        widget.onShakeComplete?.call();
      });
    }
    _previousError = widget.hasError;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeController.animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeController.animation.value, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}


// ==================== EXTENSION FOR EASY USE ====================

extension ShakeExtension on Widget {
  Widget withShake({
    Key? key,
    Duration duration = const Duration(milliseconds: 500),
    double distance = 10.0,
    ShakeAxis axis = ShakeAxis.horizontal,
  }) {
    return ShakeWidget(
      key: key,
      duration: duration,
      distance: distance,
      axis: axis,
      child: this,
    );
  }

  Widget withAutoShake({
    Duration duration = const Duration(milliseconds: 500),
    Duration interval = const Duration(seconds: 3),
    double distance = 10.0,
    ShakeAxis axis = ShakeAxis.horizontal,
  }) {
    return AutoShakeWidget(
      duration: duration,
      interval: interval,
      distance: distance,
      axis: axis,
      child: this,
    );
  }

  Widget withErrorShake({
    required bool hasError,
    Duration duration = const Duration(milliseconds: 500),
    double distance = 8.0,
    VoidCallback? onShakeComplete,
  }) {
    return ShakeErrorWidget(
      hasError: hasError,
      duration: duration,
      distance: distance,
      onShakeComplete: onShakeComplete,
      child: this,
    );
  }
}
