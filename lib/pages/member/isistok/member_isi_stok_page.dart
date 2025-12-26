import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/widgets/custom_tab_switch.dart';
import 'package:dmpku/pages/member/isistok/widgets/member_isi_stok_header.dart';
import 'package:dmpku/pages/member/isistok/widgets/metode_isi_stok_list.dart';
import 'package:dmpku/pages/member/isistok/widgets/riwayat_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberIsiStokPage extends StatefulWidget {
  static const String routeName = '/member/isi-stok';

  const MemberIsiStokPage({super.key});

  @override
  State<MemberIsiStokPage> createState() => _MemberIsiStokPageState();
}

class _MemberIsiStokPageState extends State<MemberIsiStokPage> {
  late PageController _pageViewController;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    getMemberIsiStokProvider(context).fetchRiwayatTiketBankTransfer();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              const MemberIsiStokHeader(),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 225),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CustomTabSwitch(
            selectedIndex: _activeTab,
            onTap: (index) {
              setState(() {
                _activeTab = index;
              });
              _pageViewController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageViewController,
            onPageChanged: (index) {
              setState(() {
                _activeTab = index;
              });
            },
            children: const [
              MetodeIsiStokList(),
              RiwayatContent(),
            ],
          ),
        ),
      ],
    );
  }
}
