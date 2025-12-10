import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/belum_login_page.dart';
import 'package:dmpku/pages/guest/dashboard/dashboard_page.dart';
import 'package:dmpku/pages/guest/official/official_page.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/main';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final double _iconSize = 30;

  // PageController untuk smooth transition
  final PageController _pageController = PageController();

  // List of pages - state akan tetap terjaga
  final List<Widget> _pages = [
    const DashboardPage(),
    // Placeholder for Riwayat
    const BelumLoginPage(title: "Riwayat"),
    // Placeholder for PROMO!
    const BelumLoginPage(title: "PROMO!"),
    // Placeholder for Official
    const OfficialPage(),
    // Placeholder for Akun
    const BelumLoginPage(title: "Akun"),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != 0 && index != 3) {
      BelumLoginDialog.show(context);
      return;
    }

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
