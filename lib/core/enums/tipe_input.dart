import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enum untuk tipe input pada field tujuan
enum TipeInput {
  numericOnly('1'),
  alphanumeric('2'),
  extended('3'),
  freeText('4');

  final String value;

  const TipeInput(this.value);

  static TipeInput fromValue(String? value) {
    return TipeInput.values.firstWhere(
          (e) => e.value == value,
      orElse: () => TipeInput.freeText,
    );
  }

  TextInputType get keyboardType {
    switch (this) {
      case TipeInput.numericOnly:
        return TextInputType.number;
      case TipeInput.alphanumeric:
      case TipeInput.extended:
      case TipeInput.freeText:
        return TextInputType.text;
    }
  }

  RegExp? get pattern {
    switch (this) {
      case TipeInput.numericOnly:
        return RegExp(r'^[0-9]+$');
      case TipeInput.alphanumeric:
        return RegExp(r'^[a-zA-Z0-9]+$');
      case TipeInput.extended:
        return RegExp(r'^[a-zA-Z0-9@&=#\-. ]+$');
      case TipeInput.freeText:
        return null;
    }
  }

  String get errorMessage {
    switch (this) {
      case TipeInput.numericOnly:
        return 'Tujuan harus berupa angka saja';
      case TipeInput.alphanumeric:
        return 'Tujuan harus berupa angka dan huruf saja';
      case TipeInput.extended:
        return 'Tujuan mengandung karakter yang tidak diizinkan';
      case TipeInput.freeText:
        return '';
    }
  }

  List<TextInputFormatter> get inputFormatters {
    switch (this) {
      case TipeInput.numericOnly:
        return [FilteringTextInputFormatter.digitsOnly];
      case TipeInput.alphanumeric:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
      case TipeInput.extended:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@&=#\-. ]'))
        ];
      case TipeInput.freeText:
        return [];
    }
  }

  bool isValid(String text) {
    if (text.isEmpty) return true;
    final regex = pattern;
    if (regex == null) return true;
    return regex.hasMatch(text);
  }

  String? validate(String text) {
    if (text.isEmpty) return 'Tujuan tidak boleh kosong';
    if (!isValid(text)) return errorMessage;
    return null;
  }
}