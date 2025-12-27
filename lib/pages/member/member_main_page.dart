import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/akun/member_akun_page.dart';
import 'package:dmpku/pages/member/dashboard/member_dashboard_page.dart';
import 'package:dmpku/pages/member/official/member_official_page.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_page.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/dialog/konfirmasi_keluar_app_dialog.dart';
import 'package:flutter/material.dart';

class MemberMainPage extends StatefulWidget {
  static const routeName = '/member/main';

  // 1. Tambahkan variabel ini untuk nangkep index awal
  final int initialIndex;

  // 2. Pasang di constructor, defaultnya 0 (Home)
  const MemberMainPage({super.key, this.initialIndex = 0});

  @override
  State<MemberMainPage> createState() => _MemberMainPageState();
}

class _MemberMainPageState extends State<MemberMainPage> {
  int _currentIndex = 0;
  final double _iconSize = 30;

  // PageController untuk smooth transition
  late PageController _pageController;

  // List of pages - state akan tetap terjaga
  late final List<Widget> _pages = [
    const MemberDashboardPage(),
    MemberRiwayatPage(),
    // Placeholder for PROMO!
    const Center(child: Text("Promo Page")),
    MemberOfficialPage(),
    MemberAkunPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    getMemberProvider(context).getProfile();
    getMemberProvider(context).getProfileDetail();

    getMemberRiwayatProvider(context).fetchRiwayatToday();
    getMemberRiwayatProvider(context).fetchRiwayatHistory();
    getMemberRiwayatProvider(context).fetchMutasiStok();
    getMemberRiwayatProvider(context).fetchRekapTransaksi();
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (_currentIndex != 0) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return;
        }

        KonfirmasiKeluarAppDialog.show(context);
      },
      child: Scaffold(
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
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
              ),
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
      ),
    );
  }
}
