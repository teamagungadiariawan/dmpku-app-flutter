import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSuccessMessage(String message, {
  String title = "Sukses"
}){
  _showMessage(title: title, message: message, type: ToastificationType.success);
}

void showErrorMessage(String message, {
  String title = "Terjadi Kesalahan"
}){
  _showMessage(title: title, message: message, type: ToastificationType.error);

}

void showWarningMessage(String message, {
  String title = "Perhatian"
}){
  _showMessage(title: title, message: message, type: ToastificationType.warning);
}

void _showMessage({
  required String title,
  required String message,
  required ToastificationType type
}){
  toastification.show(
    type: type,
    style: ToastificationStyle.flat,
    title: Text(title),
    description: Text(message),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    boxShadow: highModeShadow,
    showProgressBar: true,
    dragToClose: true,
  );
}