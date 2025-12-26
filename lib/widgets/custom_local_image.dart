import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomLocalImage extends StatelessWidget {
  final String? imagePath;
  final ImageProvider? imageProvider;
  final double size;
  final BoxFit fit;

  const CustomLocalImage({
    super.key,
    this.imagePath,
    this.imageProvider,
    this.size = 28.0,
    this.fit = BoxFit.contain,
  }) : assert(
         imagePath != null || imageProvider != null,
         'Either imagePath or imageProvider must be provided',
       );

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        width: size,
        height: size,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: child,
          );
        },
      );
    }

    return Image(
      image: imageProvider!,
      width: size,
      height: size,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return SizedBox(
          width: size,
          height: size,
          child: Center(child: _AnimatedHourglass(size: size * 0.6)),
        );
      },
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        LucideIcons.imageOff,
        size: size * 0.6,
        color: Colors.grey[500],
      ),
    );
  }
}

// Widget internal buat animasi hourglass biar kodenya gak numpuk
class _AnimatedHourglass extends StatefulWidget {
  final double size;
  const _AnimatedHourglass({required this.size});

  @override
  State<_AnimatedHourglass> createState() => _AnimatedHourglassState();
}

class _AnimatedHourglassState extends State<_AnimatedHourglass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(
        LucideIcons.hourglass,
        size: widget.size,
        color: Colors.blueGrey,
      ),
    );
  }
}
