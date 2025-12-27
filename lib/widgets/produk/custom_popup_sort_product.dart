import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class CustomPopupSortProduct extends StatelessWidget {
  final Function(SortProductBy) onSelected;
  final SortProductBy? selectedSort;

  const CustomPopupSortProduct({
    super.key,
    required this.onSelected,
    this.selectedSort = SortProductBy.hargaTerendah,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortProductBy>(
      onSelected: (value) {
        onSelected(value);
      },
      padding: EdgeInsets.zero,
      menuPadding: EdgeInsets.zero,
      itemBuilder: (context) => [
        _buildMenuItem(context, SortProductBy.hargaTerendah),
        _buildMenuItem(context, SortProductBy.hargaTertinggi),
        _buildMenuItem(context, SortProductBy.namaAtoZ),
        _buildMenuItem(context, SortProductBy.namaZtoA),
      ],
      child: SizedBox(
        width: 150,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text(
                  selectedSort?.displayName ?? "",
                  style: context.labelMedium,
                ),
                Spacer(),
                Icon(selectedSort?.iconData ?? MdiIcons.sort, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<SortProductBy> _buildMenuItem(
    BuildContext context,
    SortProductBy sortMethod,
  ) {
    return PopupMenuItem(
      value: sortMethod,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      child: Row(
        children: [
          Icon(sortMethod.iconData, size: 14),
          const SizedBox(width: 8),
          Text(sortMethod.displayName, style: context.bodySmall),
        ],
      ),
    );
  }
}
