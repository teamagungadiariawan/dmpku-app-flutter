import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/akun/widgets/member_akun_footer.dart';
import 'package:dmpku/pages/member/akun/widgets/member_header_content.dart';
import 'package:dmpku/pages/member/akun/widgets/member_saldo_card.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'widgets/member_menu_section.dart';

class MemberAkunPage extends StatefulWidget {
  const MemberAkunPage({super.key});

  @override
  State<MemberAkunPage> createState() => _MemberAkunPageState();
}

class _MemberAkunPageState extends State<MemberAkunPage> {
  static const double _headerHeight = 160.0;
  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 5,
    childAspectRatio: 2.5,
  );

  bool _isSaldoVisible = true;

  List<MenuItem> get _menuGeneral => [
    MenuItem(
      icon: Assets.img.profile.icDetailAkun,
      title: 'Detail Akun',
      subtitle: 'Informasi akun Anda.',
      onTap: () {},
    ),
    MenuItem(
      icon: Assets.img.profile.icManageDevice,
      title: 'Detail Device',
      subtitle: 'Daftar device terhubung.',
      onTap: () {},
    ),
    MenuItem(
      icon: Assets.img.profile.icFavorit,
      title: 'Daftar Favorit',
      subtitle: 'Kelola daftar favorit Anda.',
      onTap: () {},
    ),
    MenuItem(
      icon: Assets.img.profile.icPlaystore,
      title: 'Beri Penilaian',
      subtitle: 'Rating di Playstore.',
      onTap: () {},
    ),
  ];

  List<MenuItem> get _menuKeamanan => [
    MenuItem(
      icon: Assets.img.profile.icGantiPin,
      title: 'Ganti PIN',
      subtitle: 'Ubah PIN Anda.',
      onTap: () {},
    ),
    MenuItem(
      icon: Assets.img.profile.icResetPin,
      title: 'Reset/Lupa PIN',
      subtitle: 'Atur ulang PIN Anda.',
      onTap: () {},
    ),
  ];

  List<MenuItem> get _menuAkun => [
    MenuItem(
      icon: Assets.img.profile.icHapusAkun,
      title: 'Hapus Akun',
      subtitle: 'Nonaktifkan akun Anda.',
      onTap: () {},
    ),
  ];

  Future<void> _onRefresh() async {
    await getMemberProvider(context).getProfile();
  }

  void _toggleSaldoVisibility() {
    setState(() => _isSaldoVisible = !_isSaldoVisible);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildHeaderBackground(),
            Column(
              children: [
                const SizedBox(height: _headerHeight-15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: _buildContent(),
                    ),
                  ),
                ),
              ],
            ),
            MemberHeaderContent(
              headerHeight: _headerHeight,
              onRefresh: _onRefresh,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      height: _headerHeight + 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.primary,
        image: DecorationImage(
          image: Assets.img.bgPattern.provider(),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberSaldoCard(
            isSaldoVisible: _isSaldoVisible,
            onToggleVisibility: _toggleSaldoVisibility,
            onRefresh: _onRefresh,
            onIsiSaldo: () {
              // TODO: Navigate to isi saldo
            },
          ),
          Gap(4),
          MemberMenuSection(title: 'General', items:  _menuGeneral),
          CardTanya(
            title: "Punya Pertanyaan ?",
            subtitle: "Langsung chat dengan customer service kami",
            onTap: () {},
          ),
          Gap(4),
          MemberMenuSection(title:'Keamanan Akun',items: _menuKeamanan),
          MemberMenuSection(title:'Akun',items: _menuAkun),
          const Gap(10),
          _buildLogoutButton(),
          Gap(10),
          const MemberAkunFooter(),
        ],
      ),
    );
  }



  Widget _buildLogoutButton() {
    return BlocBuilder<MemberProvider, MemberState>(
      builder: (context, state) {
        return CustomButton(
          iconPosition: IconPosition.end,
          icon: LucideIcons.logOut600,
          height: 40,
          size: ButtonSize.large,
          padding: EdgeInsets.zero,
          width: double.infinity,
          text: "Logout",
          isLoading: state.apiLogoutStatus.isLoading,
          textStyle: context.bodyLarge
              .withColor(Colors.white)
              .withWeight(FontWeight.w800),
          onPressed: () => getMemberProvider(context).logout(),
          variant: ButtonVariant.destructive,
        );
      },
    );
  }
}
