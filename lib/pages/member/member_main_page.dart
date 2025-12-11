import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/pages/member/akun/member_akun_page.dart';
import 'package:dmpku/pages/member/dashboard/member_dashboard_page.dart';
import 'package:dmpku/pages/member/official/member_official_page.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  late final List<Widget> _pages = [
    const MemberDashboardPage(),
    // Placeholder for Riwayat
    const Center(child: Text("Riwayat Page")),
    // Placeholder for PROMO!
    const Center(child: Text("Promo Page")),
    MemberOfficialPage(),
    MemberAkunPage(),
  ];

  @override
  void initState() {
    getMemberProvider(context).getProfile();
    super.initState();
  }

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
