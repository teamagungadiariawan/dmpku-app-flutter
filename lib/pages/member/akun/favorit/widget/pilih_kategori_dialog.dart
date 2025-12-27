import 'package:dmpku/core/enums/kategori_favorit.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PilihKategoriDialog extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<KategoriItem> onCategorySelected;

  const PilihKategoriDialog({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  static Future<void> show(
      BuildContext context, {
        required int selectedIndex,
        required ValueChanged<KategoriItem> onCategorySelected,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent, // Biar rounded corner kelihatan
      builder: (_) => PilihKategoriDialog(
        selectedIndex: selectedIndex,
        onCategorySelected: onCategorySelected,
      ),
    );
  }

  @override
  State<PilihKategoriDialog> createState() => _PilihKategoriDialogState();
}

class _PilihKategoriDialogState extends State<PilihKategoriDialog> {
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  bool _isSearching = false;
  late List<KategoriItem> listKategori;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data di sini best practice
    listKategori = getKategoriFavorit();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<KategoriItem> get filteredKategori {
    if (_searchController.text.isEmpty) {
      return listKategori;
    } else {
      return listKategori
          .where(
            (kategori) => kategori.label.toLowerCase().contains(
          _searchController.text.toLowerCase(),
        ),
      )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil padding keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      // Batasi tinggi maksimal biar enak dilihat (misal 85% layar)
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ).copyWith(bottom: bottomInset > 0 ? bottomInset : 20), // Kasih padding bawah
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: context.border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          const TopDividerSheet(),
          const Gap(15),
          _buildHeader(context),
          const Gap(10),
          _buildSearchField(context),
          const Gap(10),
          // Flexible biar listview bisa scroll kalau item banyak
          Flexible(
            child: filteredKategori.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Kategori tidak ditemukan",
                  style: context.bodyMedium.copyWith(color: context.mutedForeground),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true, // Penting di dalam Column/Modal
              itemCount: filteredKategori.length,
              itemBuilder: (_, index) {
                final kategori = filteredKategori[index];
                final isSelected = widget.selectedIndex == kategori.id;

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 8), // Kasih jarak antar item
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      // Kalau selected, bordernya warna primary & lebih tebal
                      color: isSelected ? context.primary : context.border,
                      width:  1,
                    ),
                  ),
                  // Opsional: kasih tint warna dikit backgroundnya kalau selected
                  color: isSelected ? context.primary.withValues(alpha: 0.05) : context.card,
                  clipBehavior: Clip.antiAlias, // Biar splash inkwell gak keluar card
                  child: InkWell(
                    onTap: () {
                      widget.onCategorySelected(kategori);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: paddingCard, // Padding dalem card
                      child: Row(
                        children: [
                          // --- LEADING ICON ---
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // Biar icon ada background bulet tipis
                              color: context.muted,
                              shape: BoxShape.circle,
                            ),
                            child: kategori.icon != null
                                ? Image(image: kategori.icon!, width: 20, height: 20)
                                : Icon(
                              MdiIcons.star, // Sesuai request lu
                              size: 18,
                              color: context.foreground,
                            ),
                          ),
                          const Gap(12), // Jarak icon ke text

                          // --- TITLE ---
                          Expanded(
                            child: Text(
                              kategori.label,
                              style: context.bodyMedium.copyWith(
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? context.primary : context.foreground,
                              ),
                            ),
                          ),

                          // --- TRAILING CHECK ---
                          if (isSelected)
                            Icon(MdiIcons.checkCircle, color: context.primary, size: 22),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(20),
          CustomButton(
            height: 40,
            width: double.infinity,
            padding: EdgeInsets.zero,
            variant: ButtonVariant.destructive,
            text: "TUTUP",
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // Adjust padding
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.mutedForeground),
          const Gap(8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
              },
              style: context.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari nama kategori...',
                hintStyle: context.bodyMedium.copyWith(color: context.mutedForeground),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                // Tombol clear search
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                  child: Icon(
                    MdiIcons.closeCircle,
                    size: 18,
                    color: context.mutedForeground,
                  ),
                )
                    : null,
                suffixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 20),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      elevation: 0, // Biasanya di modern UI elevation 0 lebih bersih kalau ada border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.border),
      ),
      color: context.card,
      child: Padding(
        padding: const EdgeInsets.all(12), // Asumsi paddingCard isinya ini
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[800] : Colors.grey[100], // Ganti stone kalau ga ada
                shape: BoxShape.circle,
              ),
              child: Icon(MdiIcons.listBoxOutline, color: context.primary, size: 20),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Biasanya judul rata kiri lebih enak dibaca di list
                children: [
                  Text(
                    "Pilih Kategori Favorit",
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Silakan pilih salah satu opsi di bawah",
                    style: context.bodySmall.copyWith(color: context.mutedForeground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}