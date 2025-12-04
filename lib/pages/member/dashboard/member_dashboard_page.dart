import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberDashboardPage extends StatefulWidget {
  const MemberDashboardPage({super.key});

  @override
  State<MemberDashboardPage> createState() => _MemberDashboardPageState();
}

class _MemberDashboardPageState extends State<MemberDashboardPage> {
  final _scrollController = ScrollController();
  double _opacity = 0.0;

  static const _scrollThreshold = 150.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final newOpacity = (_scrollController.offset / _scrollThreshold).clamp(
      0.0,
      1.0,
    );
    if (newOpacity != _opacity) {
      setState(() => _opacity = newOpacity);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(body: Stack(children: [])),
    );
  }
}
