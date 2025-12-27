import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';

import 'package:dmpku/widgets/produk/custom_popup_sort_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SortFilterProduct extends StatelessWidget {
  final TextEditingController searchController;
  final String searchValue;
  final bool hasError;
  final SortProductBy selectedSort;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<SortProductBy> onSortSelected;

  const SortFilterProduct({
    super.key,
    required this.searchController,
    required this.searchValue,
    required this.hasError,
    required this.selectedSort,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSearchField(context)),
        const Gap(6),
        CustomPopupSortProduct(
          selectedSort: selectedSort,
          onSelected: onSortSelected,
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: hasError ? context.destructive : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari Produk',
                suffixIcon: searchValue.isNotEmpty
                    ? InkWell(
                        onTap: onClearSearch,
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
  }
}
