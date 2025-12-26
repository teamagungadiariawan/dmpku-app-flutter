import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:dmpku/pages/member/kasir/member_catatan_provider.dart';
import 'package:dmpku/pages/member/kasir/hapus_catatan_dialog.dart';
import 'package:dmpku/pages/member/kasir/tambah_catatan_dialog.dart';
import 'package:dmpku/pages/member/kasir/ubah_catatan_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

class MemberCatatanPage extends StatefulWidget {
  const MemberCatatanPage({super.key});

  static const String routeName = '/member/kasir/catatan';

  @override
  State<MemberCatatanPage> createState() => _MemberCatatanPageState();
}

class _MemberCatatanPageState extends State<MemberCatatanPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberCatatanProvider()..getCatatanList(),
      child: const MemberCatatanView(),
    );
  }
}

class MemberCatatanView extends StatefulWidget {
  const MemberCatatanView({super.key});

  @override
  State<MemberCatatanView> createState() => _MemberCatatanViewState();
}

class _MemberCatatanViewState extends State<MemberCatatanView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Catatan"),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TambahCatatanDialog.show(context);
          },
          backgroundColor: context.primary,
          shape: const CircleBorder(),
          child: const Icon(LucideIcons.plus, color: Colors.white),
        ),
        body: Padding(
          padding: paddingPage,
          child: Column(
            children: [
              _buildSearchField(context),
              const Gap(10),
              Expanded(child: _buildCatatanContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return BlocBuilder<MemberCatatanProvider, MemberCatatanState>(
      buildWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery ||
          previous.searchController != current.searchController,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.muted,
            border: Border.all(color: context.border, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Icon(
                MdiIcons.textBoxSearch,
                size: 24,
                color: context.mutedForeground,
              ), // matched icon from RN
              const Gap(6),
              Expanded(
                child: TextField(
                  controller: state.searchController,
                  onChanged: (val) {
                    getMemberCatatanProvider(context).setSearchQuery(val);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Catatan',
                    border: InputBorder.none,
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              getMemberCatatanProvider(
                                context,
                              ).setSearchQuery('');
                            },
                            child: Icon(
                              MdiIcons.close,
                              size: 18,
                              color: context.foreground,
                            ),
                          )
                        : null,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCatatanContent(BuildContext context) {
    return BlocBuilder<MemberCatatanProvider, MemberCatatanState>(
      buildWhen: (previous, current) =>
          previous.apiGetCatatanStatus != current.apiGetCatatanStatus ||
          previous.catatanFiltered != current.catatanFiltered,
      builder: (context, state) {
        // Use filtered list
        return RefreshableList(
          loadingWidget: _buildShimmerLoading(context),
          isLoading:
              state.apiGetCatatanStatus.isLoading && state.catatanList.isEmpty,
          // Note: RefreshableList handles 'isLoading' by showing shimmering if items empty,
          // or just RefreshControl if has items.
          onRefresh: getMemberCatatanProvider(context).getCatatanList,
          items: state.catatanFiltered,
          itemBuilder: (context, item, index) {
            return _buildCatatanItem(context, item);
          },
        );
      },
    );
  }

  Widget _buildCatatanItem(BuildContext context, CatatanModel item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.border, width: 0.7),
      ),
      child: Padding(
        padding: paddingCard,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to top
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: context.muted, // neutral30 equivalent
                shape: BoxShape.circle,
              ),
              child: Icon(
                MdiIcons.notebook,
                size: 18,
                color: context.mutedForeground, // gray equivalent
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  Text(
                    item.judul,
                    style: context.bodySmall.withWeight(FontWeight.w500),
                  ),
                  const Gap(2),
                  // Isi Catatan
                  Text(
                    item.isicatatan,
                    style: context.bodySmall.withColor(context.mutedForeground),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(8),
            Row(
              children: [
                if (item.prioritas == 1)
                  Icon(MdiIcons.pin, color: context.primary, size: 18),

                PopupMenuButton<String>(
                  icon: Icon(
                    MdiIcons.dotsVertical,
                    size: 20,
                    color: context.foreground,
                  ),
                  onSelected: (String value) {
                    if (value == 'pin') {
                      getMemberCatatanProvider(
                        context,
                      ).togglePinCatatan(context, item);
                    } else if (value == 'edit') {
                      UbahCatatanDialog.show(context, item);
                    } else if (value == 'delete') {
                      HapusCatatanDialog.show(context, item);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'pin',
                          child: Row(
                            children: [
                              Icon(
                                item.prioritas == 1
                                    ? MdiIcons.pinOff
                                    : MdiIcons.pin,
                                color: item.prioritas == 1
                                    ? context.destructive
                                    : context.primary,
                                size: 18,
                              ),
                              const Gap(8),
                              Text(
                                item.prioritas == 1
                                    ? 'Lepaskan Pin'
                                    : 'Sematkan',
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.notebookEdit,
                                color: context.primary,
                                size: 18,
                              ),
                              const Gap(8),
                              Text('Ubah Data', style: context.bodySmall),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.notebookRemove,
                                color: context.destructive,
                                size: 18,
                              ),
                              const Gap(8),
                              Text('Hapus Data', style: context.bodySmall),
                            ],
                          ),
                        ),
                      ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- SHIMMER LOADING EFFECT ---
  Widget _buildShimmerLoading(BuildContext context) {
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: paddingCard,
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 14,
                          margin: const EdgeInsets.only(right: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Gap(6),
                        Container(
                          width: 150,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
