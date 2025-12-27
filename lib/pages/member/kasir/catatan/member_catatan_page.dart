import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';

import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:dmpku/pages/member/kasir/catatan/member_catatan_provider.dart';
import 'package:dmpku/pages/member/kasir/catatan/widgets/hapus_catatan_dialog.dart';
import 'package:dmpku/pages/member/kasir/catatan/widgets/tambah_catatan_dialog.dart';
import 'package:dmpku/pages/member/kasir/catatan/widgets/ubah_catatan_dialog.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            await getMemberCatatanProvider(context).getCatatanList();
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const Gap(16),
                    _buildSearchField(context),
                    const Gap(16),
                  ]),
                ),
              ),
              _buildCatatanContent(context),
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
          decoration: BoxDecoration(
            color: context.background,
            border: Border.all(color: context.border, width: 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(
                LucideIcons.search,
                size: 20,
                color: context.mutedForeground,
              ),
              const Gap(12),
              Expanded(
                child: TextField(
                  controller: state.searchController,
                  onChanged: (val) {
                    getMemberCatatanProvider(context).setSearchQuery(val);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari catatan...',
                    border: InputBorder.none,
                    hintStyle: context.bodySmall.withColor(
                      context.mutedForeground,
                    ),
                  ),
                  style: context.bodyMedium,
                  textInputAction: TextInputAction.search,
                ),
              ),
              if (state.searchQuery.isNotEmpty)
                InkWell(
                  onTap: () {
                    getMemberCatatanProvider(context).setSearchQuery('');
                  },
                  child: Icon(
                    LucideIcons.x,
                    size: 20,
                    color: context.foreground,
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
        if (state.apiGetCatatanStatus.isLoading && state.catatanList.isEmpty) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildShimmerLoading(context),
              ]),
            ),
          );
        }

        final pinned = state.catatanFiltered
            .where((e) => e.prioritas == 1)
            .toList();
        final others = state.catatanFiltered
            .where((e) => e.prioritas != 1)
            .toList();

        if (state.catatanFiltered.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.fileX,
                    size: 64,
                    color: context.mutedForeground,
                  ),
                  const Gap(16),
                  Text(
                    "Tidak ada catatan ditemukan",
                    style: context.bodyMedium.withColor(
                      context.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (pinned.isNotEmpty) ...[
                _buildSectionHeader(context, "DISEMATKAN"),
                const Gap(8),
                _buildMasonryGrid(context, pinned),
                const Gap(24),
              ],
              if (others.isNotEmpty) ...[
                if (pinned.isNotEmpty) _buildSectionHeader(context, "LAINNYA"),
                const Gap(8),
                _buildMasonryGrid(context, others),
              ],
            ]),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        if (title == "DISEMATKAN")
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(MdiIcons.pin, size: 16, color: context.mutedForeground),
          ),
        Text(
          title,
          style: context.labelSmall
              .withColor(context.mutedForeground)
              .withWeight(FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildMasonryGrid(BuildContext context, List<CatatanModel> items) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildCatatanItem(context, items[index], index);
      },
    );
  }

  Widget _buildCatatanItem(BuildContext context, CatatanModel item, int index) {
    // Standard pastel colors
    final colors = [
      const Color(0xFFF0FDF4), // green-50
      const Color(0xFFFEFCE8), // yellow-50
      const Color(0xFFEFF6FF), // blue-50
      const Color(0xFFFAF5FF), // purple-50
      const Color(0xFFFFF1F2), // rose-50
    ];
    final color = colors[item.idcatatan % colors.length];

    // Using a simpler border color for cleanliness
    final border = Border.all(
      color: context.border.withValues(alpha: 0.5),
      width: 1,
    );

    return InkWell(
      onTap: () {
        // Show edit or options
        // For now, let's just show options on long press or tap?
        // User might expect tap to edit/view details.
        UbahCatatanDialog.show(context, item);
      },
      onLongPress: () {
        // Alternative to 3-dots if we want cleaner UI, but let's keep it accessible
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.judul,
                    style: context.bodyMedium.withWeight(FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.prioritas == 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Icon(
                        MdiIcons.pin,
                        size: 16,
                        color: context.primary,
                      ),
                    ),
                  ),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      MdiIcons.dotsVertical,
                      size: 16,
                      color: context.mutedForeground,
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
                                Text('Ubah', style: context.bodySmall),
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
                                Text('Hapus', style: context.bodySmall),
                              ],
                            ),
                          ),
                        ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              item.isicatatan,
              style: context.bodyMedium.withColor(
                Colors.black87,
              ), // Ensure readable on pastel
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(16),
            // Placeholder for date since model doesn't have it
            Text(
              "Hari ini", // Placeholder
              style: context.bodySmall.withColor(context.mutedForeground),
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

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: (index % 2 == 0) ? 150 : 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
