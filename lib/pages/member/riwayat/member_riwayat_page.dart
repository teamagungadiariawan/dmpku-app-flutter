import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_filter_section.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_header.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_list_hari_ini.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_list_kemarin.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_list_mutasi_stok.dart';
import 'package:dmpku/pages/member/riwayat/widgets/riwayat_list_rekap_transaksi.dart';
import 'package:dmpku/widgets/tab/custom_tab_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberRiwayatPage extends StatefulWidget {
  static const routeName = '/member/riwayat';

  const MemberRiwayatPage({super.key});

  @override
  State<MemberRiwayatPage> createState() => _MemberRiwayatPageState();
}

class _MemberRiwayatPageState extends State<MemberRiwayatPage> {
  late PageController _pageViewController;
  late CustomTabRiwayatController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = CustomTabRiwayatController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index, {bool fromTab = true}) {
    setState(() {
      _selectedTabIndex = index;
    });

    if (fromTab) {
      _pageViewController.jumpToPage(index);
    } else {
      _tabController.jumpToTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        backgroundColor: context.secondary,
        body: Stack(
          fit: StackFit.loose,
          children: [
            RiwayatHeader(
              tabController: _tabController,
              onTabChanged: (int index) {
                _onTabChanged(index, fromTab: true);
              },
            ),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 130),
        RiwayatFilterSection(selectedTabIndex: _selectedTabIndex),
        Expanded(
          child: Container(
            color: context.secondary,
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (index) {
                _onTabChanged(index, fromTab: false);
              },
              children: const [
                RiwayatListHariIni(),
                RiwayatListKemarin(),
                RiwayatListMutasiStok(),
                RiwayatListRekapTransaksi(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
