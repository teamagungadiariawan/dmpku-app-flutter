import 'dart:convert';

import 'package:dmpku/model/key_value_response.dart';
import 'package:flutter/services.dart';

List<String> formatKeyValueMultilineNew(List<KeyValue> data) {
  const int maxKey = 11;
  const int maxValue = 19;
  List<String> result = [];

  // Helper function buat pecah text (nested function)
  List<String> splitText(String text, int size) {
    List<String> lines = [];
    for (int i = 0; i < text.length; i += size) {
      int end = (i + size < text.length) ? i + size : text.length;
      lines.add(text.substring(i, end));
    }
    return lines;
  }

  for (final item in data) {
    String key = item.key.trim();

    // Logic replace string sesuai request
    if (key == 'Keterangan Produk') key = 'Deskripsi';
    if (key == 'Keterangan') key = 'Deskripsi';
    key = key.replaceAll('Pelanggan', 'Pel');
    key = key.replaceAll('Tagihan', 'Tag');
    key = key.replaceAll('Periode Bayar', 'Periode Byr');
    key = key.replaceAll('Jml Keluarga', 'Jm Keluarga');
    key = key.replaceAll('Volume Pakai', 'Vol Pakai');
    key = key.replaceAll('No Registrasi', 'No Regis');
    key = key.replaceAll('Jenis Pembayaran', 'Jenis Bayar');
    key = key.replaceAll('Tanggal Registrasi', 'Tgl Regis');
    key = key.replaceAll('Kantor Cabang', 'Ktr Cabang');
    key = key.replaceAll('Jenis Kendaran', 'Jenis');

    // Pecah text jadi array of string berdasarkan panjang kolom
    final keyLines = splitText(key, maxKey);
    final valueLines = splitText(item.value, maxValue);

    // Cari mana yang barisnya paling banyak (key atau value)
    // Di Dart kita pake logika if/else math max
    final maxLines = (keyLines.length > valueLines.length)
        ? keyLines.length
        : valueLines.length;

    for (int i = 0; i < maxLines; i++) {
      // Ambil potongan text, handle kalau indexnya ga ada (biar ga error range error)
      String keyPart = (i < keyLines.length) ? keyLines[i] : '';
      String valuePart = (i < valueLines.length) ? valueLines[i] : '';

      // Padding biar rata kolom
      // padRight itu sama kayak padEnd di JS
      final keyColumn = keyPart.padRight(maxKey, ' ');
      final valueColumn = valuePart.padRight(maxValue, ' ');

      if (i == 0) {
        // Baris pertama pake titik dua
        result.add('$keyColumn: $valueColumn');
      } else {
        // Baris lanjutan pake spasi doang
        result.add('$keyColumn  $valueColumn');
      }
    }
  }

  return result;
}

const keyDtlTransaksiExcluded = [
  '',
  'token',
  'ref',
  'token',
  'voucher',
  'kodeproduk',
];

const keyDtlPembayaranExcluded = ['', 'token', 'voucher', 'totalbayar', 'fee'];

const keyTkn = 'token';
const keyVoucher = 'kodevoucher';
const keyRef = 'ref';

const divider = '--------------------------------';

class PrinterNativeHelper {
  // Channel harus SAMA PERSIS dengan yang ada di MainActivity.kt
  static const _printChannel = MethodChannel(
    'id.co.aviana.duniamasterpulsa_develop/print',
  );

  // Buka menu scan printer bawaan
  static Future<void> scanPrinter() async {
    try {
      await _printChannel.invokeMethod('choosePrinter');
    } on PlatformException catch (e) {
      print("Error scan printer: ${e.message}");
    }
  }

  // Set printer aktif (Connect)
  static Future<void> setPrinter(String name, String macAddress) async {
    try {
      await _printChannel.invokeMethod('setPrinter', {
        'printerName': name,
        'printAddress': macAddress,
      });
    } on PlatformException catch (e) {
      print("Error set printer: ${e.message}");
    }
  }

  // Kirim data print (Format JSON)
  static Future<void> printData({
    required String printerName,
    required String printerAddress,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      // Kita susun Map jadi JSON String di sini biar rapi
      Map<String, dynamic> jsonMap = {"data": items};
      String jsonString = jsonEncode(jsonMap);

      await _printChannel.invokeMethod('printMessage', {
        'message': jsonString,
        'printerName': printerName,
        'printAddress': printerAddress,
      });
    } on PlatformException catch (e) {
      print("Gagal print: ${e.message}");
    }
  }

  static Future<List<Map<String, String>>> getPairedDevices() async {
    try {
      // Panggil Native
      final List<dynamic> result = await _printChannel.invokeMethod(
        'getPairedDevices',
      );

      // Convert data dynamic jadi List<Map> yang rapi
      return result.map((e) {
        final Map<dynamic, dynamic> item = e;
        return {
          "name": item["name"].toString(),
          "address": item["address"].toString(),
        };
      }).toList();
    } on PlatformException catch (e) {
      print("Gagal ambil device: ${e.message}");
      return [];
    }
  }
}
