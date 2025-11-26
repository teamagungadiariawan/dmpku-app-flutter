import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OfflineDialog extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineDialog({super.key, this.onRetry});

  static void show(BuildContext context, {VoidCallback? onRetry}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => OfflineDialog(onRetry: onRetry),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Lottie.asset(Assets.animations.noConnection)],
      ),
    );
  }
}
