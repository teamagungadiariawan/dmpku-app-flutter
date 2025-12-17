import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// 1️⃣ Bikin Controllernya dulu
class CustomTabRiwayatController extends ChangeNotifier {
  int _index;

  CustomTabRiwayatController({int initialIndex = 0}) : _index = initialIndex;

  int get index => _index;

  // Fungsi buat pindah tab dari luar
  void jumpToTab(int newIndex) {
    if (_index != newIndex) {
      _index = newIndex;
      notifyListeners(); // Kasih tau widget buat update
    }
  }
}

class CustomTabRiwayat extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onChange;
  final List<String> tabs;
  // 2️⃣ Tambahin parameter controller
  final CustomTabRiwayatController? controller;

  const CustomTabRiwayat({
    super.key,
    this.initialIndex = 0,
    this.onChange,
    this.tabs = const [],
    this.controller,
  });

  @override
  State<CustomTabRiwayat> createState() => _CustomTabRiwayatState();
}

class _CustomTabRiwayatState extends State<CustomTabRiwayat> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // Prioritaskan index dari controller kalau ada
    _currentIndex = widget.controller?.index ?? widget.initialIndex;

    // 3️⃣ Dengerin perubahan dari controller
    widget.controller?.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    // Jangan lupa lepas listener biar gak memory leak
    widget.controller?.removeListener(_handleControllerChange);
    super.dispose();
  }

  // Fungsi yang dipanggil kalau controller berubah
  void _handleControllerChange() {
    if (widget.controller != null) {
      setState(() {
        _currentIndex = widget.controller!.index;
      });
    }
  }

  void _onTabTapped(int index) {
    // Update UI lokal
    setState(() {
      _currentIndex = index;
    });

    // Update controller biar sinkron
    widget.controller?.jumpToTab(index);

    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        separatorBuilder: (context, index) => Gap(8),
        padding: EdgeInsets.symmetric(horizontal: paddinPageh),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = _currentIndex == index;
          return InkWell( // Pindahin InkWell keluar Container biar ripple-nya bener (opsional sih)
            onTap: () => _onTabTapped(index),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected
                    ? context.card
                    : context.isDarkMode
                    ? context.card.withOpacity(0.3)
                    : Colors.black12,
              ),
              child: Center(
                child: Text(
                  widget.tabs[index],
                  style: context.bodySmall
                      .withColor(
                    isSelected ? context.primary : Colors.white,
                  )
                      .withWeight(FontWeight.w600),
                ),
              ),
            ),
          );
        },
        itemCount: widget.tabs.length,
      ),
    );
  }
}