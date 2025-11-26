import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class OfficialPage extends StatefulWidget {
  const OfficialPage({super.key});

  @override
  State<OfficialPage> createState() => _OfficialPageState();
}

class _OfficialPageState extends State<OfficialPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Official Page', style: context.bodyMedium));
  }
}
