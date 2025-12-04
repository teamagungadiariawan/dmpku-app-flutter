import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MemberMainPage extends StatefulWidget {
  static const routeName = '/member/main';

  const MemberMainPage({super.key});

  @override
  State<MemberMainPage> createState() => _MemberMainPageState();
}

class _MemberMainPageState extends State<MemberMainPage> {
  int _currentIndex = 0;
  final double _iconSize = 30;

  // PageController untuk smooth transition
  final PageController _pageController = PageController();

  // List of pages - state akan tetap terjaga
  final List<Widget> _pages = [
    const Center(child: Text("Dashboard Page")),
    // Placeholder for Riwayat
    const Center(child: Text("Riwayat Page")),
    // Placeholder for PROMO!
    const Center(child: Text("Promo Page")),
    // Placeholder for Official
    const Center(child: Text("Official Page")),
    // Placeholder for Akun
    const Center(child: Text("Akun Page")),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.background,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
          ],
          border: Border(top: BorderSide(color: context.border, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.primary,
          unselectedItemColor: context.foreground,
          unselectedFontSize: 14,
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveHome.image(
                width: _iconSize,
                height: _iconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveHome.image(
                width: _iconSize,
                height: _iconSize,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveRiwayat.image(
                width: _iconSize,
                height: _iconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveRiwayat.image(
                width: _iconSize,
                height: _iconSize,
              ),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactivePromo.image(
                width: _iconSize,
                height: _iconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActivePromo.image(
                width: _iconSize,
                height: _iconSize,
              ),
              label: 'PROMO!',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveOfficial.image(
                width: _iconSize,
                height: _iconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveOfficial.image(
                width: _iconSize,
                height: _iconSize,
              ),
              label: 'Official',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveProfile.image(
                width: _iconSize,
                height: _iconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveProfile.image(
                width: _iconSize,
                height: _iconSize,
              ),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
