// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// UTILS
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'package:prep/src/parser.dart';

// ignore_for_file: invalid_use_of_protected_member

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Extracts the value from a prep expression.
String $$(final String expression) {
  return PrepParser.instance.$extract(expression)?.value.toString() ?? "";
}

/// Extracts the key from a prep expression.
String $(final String expression) {
  return PrepParser.instance.$extract(expression)?.key.toString() ?? "";
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension PrepKeyValue on String {
  /// Deprecated. Use [prepKey] instead.
  @deprecated
  String get key => $(this);

  /// Deprecated. Use [prepValue] instead.
  @deprecated
  String get value => $$(this);

  /// Extracts the key from a prep expression.
  String get prepKey => $(this);

  /// Extracts the value from a prep expression.
  String get prepValue => $$(this);
}