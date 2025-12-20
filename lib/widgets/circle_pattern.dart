import 'package:flutter/material.dart';

class CirclePattern extends StatelessWidget {
  final Color color;
  final double radius;
  final double spacing;
  final bool isStaggered; // Biar selang-seling kayak sarang lebah

  const CirclePattern({
    super.key,
    this.color = const Color(0xFFE0E0E0), // Default abu-abu muda
    this.radius = 4.0,
    this.spacing = 20.0,
    this.isStaggered = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePatternPainter(
        color: color,
        radius: radius,
        spacing: spacing,
        isStaggered: isStaggered,
      ),
      child: Container(), // Ngisi seluruh area parent
    );
  }
}

class _CirclePatternPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double spacing;
  final bool isStaggered;

  _CirclePatternPainter({
    required this.color,
    required this.radius,
    required this.spacing,
    required this.isStaggered,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Kita gambar lebih sedikit dari area layar biar pas di edge gak kepotong aneh
    // Loop vertikal (Y)
    for (double y = 0; y < size.height ; y += spacing) {
      // Cek baris ganjil/genap buat efek selang-seling (staggered)
      double shiftX = 0;
      if (isStaggered) {
        int rowIndex = (y / spacing).round();
        if (rowIndex % 2 != 0) {
          shiftX = spacing / 2;
        }
      }

      // Loop horizontal (X)
      for (double x = -spacing; x < size.width + spacing; x += spacing) {
        canvas.drawCircle(Offset(x + shiftX, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CirclePatternPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.spacing != spacing;
  }
}


class RhombusPattern extends StatelessWidget {
  final Color color;

  // Radius di sini artinya jarak dari titik tengah ke ujung sudut ketupatnya.
  // Jadi total lebar/tinggi ketupatnya adalah radius * 2.
  final double radius;
  final double spacing;
  final bool isStaggered;

  const RhombusPattern({
    super.key,
    this.color = const Color(0xFFBDBDBD), // Default abu-abu
    this.radius = 6.0,
    this.spacing = 30.0,
    this.isStaggered = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RhombusPatternPainter(
        color: color,
        radius: radius,
        spacing: spacing,
        isStaggered: isStaggered,
      ),
      // Penting: Container kosong ini biar dia bisa di-expand parent-nya
      child: Container(),
    );
  }
}

class _RhombusPatternPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double spacing;
  final bool isStaggered;

  _RhombusPatternPainter({
    required this.color,
    required this.radius,
    required this.spacing,
    required this.isStaggered,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Kita bikin satu objek Path di luar loop biar hemat memori
    final path = Path();

    // Loop vertikal (Y) - dilebihin dikit area gambarnya
    for (double y = -spacing; y < size.height ; y += spacing) {
      double shiftX = 0;
      if (isStaggered) {
        int rowIndex = (y / spacing).round();
        if (rowIndex % 2 != 0) {
          shiftX = spacing / 2;
        }
      }

      // Loop horizontal (X)
      for (double x = -spacing; x < size.width + spacing; x += spacing) {
        path.reset(); // Bersihin path sebelumnya

        // Titik tengah ketupat
        final cx = x + shiftX;
        final cy = y;

        // Gambar Belah Ketupat:
        // Mulai dari titik Atas
        path.moveTo(cx, cy - radius);
        // Garis ke Kanan
        path.lineTo(cx + radius, cy);
        // Garis ke Bawah
        path.lineTo(cx, cy + radius);
        // Garis ke Kiri
        path.lineTo(cx - radius, cy);
        // Tutup jalur (balik ke Atas otomatis)
        path.close();

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RhombusPatternPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.spacing != spacing ||
        oldDelegate.isStaggered != isStaggered;
  }
}
