import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/permission_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

/// Model untuk menampung kontak dengan nomor telepon terpisah
class ContactWithPhone {
  final Contact contact;
  final Phone phone;

  ContactWithPhone({required this.contact, required this.phone});

  String get displayName => contact.displayName;

  String get phoneNumber {
    var ph = TipeInput.numericOnly.filter(phone.number);

    if (ph.startsWith('62')) {
      ph = '0' + ph.substring(2);
    }

    return ph;
  }

  String get phoneLabel => phone.label.name;

  ContactWithPhone copyWith({Contact? contact, Phone? phone}) {
    return ContactWithPhone(
      contact: contact ?? this.contact,
      phone: phone ?? this.phone,
    );
  }
}

class ContactPickerDialog extends StatefulWidget {
  final Function(ContactWithPhone)? onSelected;

  const ContactPickerDialog({super.key, this.onSelected});

  static void show(
    BuildContext context, {
    Function(ContactWithPhone)? onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContactPickerDialog(onSelected: onSelected),
    );
  }

  @override
  State<ContactPickerDialog> createState() => _ContactPickerDialogState();
}

class _ContactPickerDialogState extends State<ContactPickerDialog> {
  List<ContactWithPhone> _flattenedContacts = [];
  List<ContactWithPhone> _filteredContacts = [];
  bool _isLoading = true;
  bool _permissionDenied = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchContacts() async {
    var status = await checkContactsPermission();

    if (!status.isGranted) {
      requestContactsPermission();
      setState(() {
        _permissionDenied = true;
        _isLoading = false;
      });
      return;
    }

    final contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
    );

    // Flatten contacts - pisahkan setiap nomor telepon yang unik
    final flattened = <ContactWithPhone>[];
    for (final contact in contacts) {
      if (contact.phones.isEmpty) {
        // Kontak tanpa nomor telepon, skip atau tampilkan tanpa nomor
        continue;
      }

      // Ambil nomor unik saja (hindari duplikasi)
      final uniquePhones = <String, Phone>{};
      for (final phone in contact.phones) {
        final normalized = _normalizePhone(phone.number);
        if (!uniquePhones.containsKey(normalized)) {
          uniquePhones[normalized] = phone;
        }
      }

      // Buat entry terpisah untuk setiap nomor unik
      for (final phone in uniquePhones.values) {
        flattened.add(ContactWithPhone(contact: contact, phone: phone));
      }
    }

    setState(() {
      _flattenedContacts = flattened;
      _filteredContacts = flattened;
      _isLoading = false;
    });
  }

  /// Normalisasi nomor telepon untuk perbandingan
  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = _flattenedContacts;
      } else {
        final queryLower = query.toLowerCase();
        _filteredContacts = _flattenedContacts.where((item) {
          final nameLower = item.displayName.toLowerCase();
          final phoneMatch = item.phoneNumber.contains(query);
          return nameLower.contains(queryLower) || phoneMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopDividerSheet(),
            const Gap(15),
            _buildHeader(context),
            const Gap(10),
            _buildSearchField(context),
            const Gap(10),
            Expanded(child: _buildContactList(context)),
            const Gap(10),
            CustomButton(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.zero,
              variant: ButtonVariant.destructive,
              text: "TUTUP",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? stone[700] : stone[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(MdiIcons.accountBox),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Kontak',
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Pilih kontak dari daftar atau cari berdasarkan nama/nomor.',
                    style: context.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterContacts,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari Kontak',
                suffixIcon: _searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _filterContacts('');
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
  }

  Widget _buildContactList(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_permissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MdiIcons.accountOff,
              size: 64,
              color: context.secondaryForeground,
            ),
            const Gap(16),
            Text('Izin akses kontak ditolak', style: context.bodyLarge),
            const Gap(8),
            CustomButton(
              text: 'Buka Pengaturan',
              onPressed: () => FlutterContacts.openExternalPick(),
            ),
          ],
        ),
      );
    }

    if (_filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MdiIcons.accountSearch,
              size: 64,
              color: context.secondaryForeground,
            ),
            const Gap(16),
            Text(
              _searchController.text.isEmpty
                  ? 'Tidak ada kontak'
                  : 'Tidak ditemukan "${_searchController.text}"',
              style: context.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: _filteredContacts.length,
      separatorBuilder: (_, __) => Gap(6),
      itemBuilder: (context, index) {
        var item = _filteredContacts[index];

        return _ContactTile(
          item: item,
          onTap: () {
            widget.onSelected?.call(item);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _ContactTile extends StatelessWidget {
  final ContactWithPhone item;
  final VoidCallback onTap;

  const _ContactTile({required this.item, required this.onTap});

  String _getPhoneLabelDisplay(String label) {
    switch (label.toLowerCase()) {
      case 'mobile':
        return 'Seluler';
      case 'home':
        return 'Rumah';
      case 'work':
        return 'Kantor';
      case 'main':
        return 'Utama';
      case 'other':
        return 'Lainnya';
      default:
        return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: paddingCard,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: context.isDarkMode ? stone[700] : stone[200],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    item.displayName.isNotEmpty
                        ? item.displayName[0].toUpperCase()
                        : '?',
                    style: context.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.displayName, style: context.bodyMedium),
                  Row(
                    children: [
                      Text(item.phoneNumber, style: context.bodySmall),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? stone[700] : stone[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getPhoneLabelDisplay(item.phoneLabel),
                          style: context.bodySmall.copyWith(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Icon(MdiIcons.chevronRight),
            ],
          ),
        ),
      ),
    );
  }
}
