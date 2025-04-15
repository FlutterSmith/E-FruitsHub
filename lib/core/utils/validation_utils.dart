import 'package:flutter/material.dart';

class ValidationUtils {
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال الاسم الكامل';
    }
    if (value.length < 3) {
      return 'يجب أن يكون الاسم أكثر من 3 أحرف';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }

    // Basic email validation regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال العنوان';
    }
    if (value.length < 5) {
      return 'يرجى إدخال عنوان أكثر تفصيلاً';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }

    // Remove spaces, dashes and parentheses for validation
    final cleanNumber = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check if number contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(cleanNumber)) {
      return 'يرجى إدخال أرقام فقط';
    }

    // Check phone number length (adjust as needed for your country)
    if (cleanNumber.length < 10 || cleanNumber.length > 15) {
      return 'يجب أن يكون رقم الهاتف بين 10 و 15 رقم';
    }

    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال المدينة';
    }
    return null;
  }

  static String? validateOptionalField(String? value) {
    // No validation for optional fields
    return null;
  }
}
