import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/utils/typography.dart';

positiveMessage({required String message, required}) {
  return Get.rawSnackbar(
      messageText: Text(
        message,
        style: AppTypography.caption.copyWith(
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}

negativeMessage({required String message}) {
  return Get.rawSnackbar(
      messageText: Text(
        message,
        style: AppTypography.caption.copyWith(
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}

warningMessage({required String message}) {
  return Get.rawSnackbar(
      messageText: Text(
        message,
        style: AppTypography.caption.copyWith(
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.amber,
      borderRadius: 10,
      margin: const EdgeInsets.all(10));
}
