// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// SRC PARSER
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com,>
// <#Date = 8/26/2021>
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'dart:io' show File, Platform;
import 'package:meta/meta.dart';
import 'package:prep/src/replacements.dart';
import 'package:prep/src/src_files_and_folders.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class PrepParser {
  //
  //
  //

  String beg = "<";
  String end = ">";
  String sep = "=";

  //
  //
  //

  static final PrepParser instance = PrepParser._();
  factory PrepParser() => instance;
  PrepParser._();

  //
  //
  //

  void syntax({
    final String? beg,
    final String? end,
    final String? sep,
  }) {
    if (beg != null) this.beg = beg;
    if (end != null) this.end = end;
    if (sep != null) this.sep = sep;
  }

  //
  //
  //

  RegExp _expUpdate(final String key) {
    return RegExp("$beg *$key *$sep[^$sep]* *$end", caseSensitive: false);
  }

  RegExp _expReplace(final String key) {
    return RegExp("$beg *$key *$end", caseSensitive: false);
  }

  //
  //
  //

  String _replaceFields(
    final String line,
    final String key,
    final String value,
  ) {
    return line.replaceAll(_expReplace("##$key"), value);
  }

  //
  //
  //

  String _updateFields1(
    final String line,
    final String key,
    final String value,
  ) {
    final _valueDefault = "$beg#$key $sep $value$end";
    return line
        .replaceAll(_expUpdate("##$key"), value)
        .replaceAll(_expUpdate("#$key"), _valueDefault);
  }

  //
  //
  //

  String _updateFields2(
    final String line,
    final String keyShort,
    final String keyLong,
    final String value,
  ) {
    final _valueShort = "$beg#$keyShort$sep$value$end";
    final _valueLong = "$beg#$keyLong $sep $value$end";
    return line
        .replaceAll(_expUpdate("##$keyShort"), value)
        .replaceAll(_expUpdate("##$keyLong"), value)
        .replaceAll(_expUpdate("#$keyShort"), _valueShort)
        .replaceAll(_expUpdate("#$keyLong"), _valueLong);
  }

  //
  //
  //

  String _incrementFields(
    final String line,
    final String key,
  ) {
    final _match = (_expUpdate("##$key").firstMatch(line)?.group(0) ??
        _expUpdate("#$key").firstMatch(line)?.group(0));
    // If match is found.
    if (_match != null) {
      final _extracted = PrepParser().$extract(_match)?.value;
      final _value =
          (_extracted != null ? (int.tryParse(_extracted) ?? -1) : 0) + 1;
      final _valueDefault = "$beg#$key $sep $_value$end";
      return line
          .replaceAll(_expUpdate("##$key"), _value.toString())
          .replaceAll(_expUpdate("#$key"), _valueDefault);
    }
    return line;
  }

  //
  //
  //

  Future<void> parse(
    final String path, {
    final Map<String, Object> fields = const {},
    final bool includeEnv = false,
  }) async {
    final _now = DateTime.now();
    final _date = _dateFormatted(_now);
    final _time = _timeFormatted(_now);
    final _file = File(path);
    final _shortFile = getShortFileName(path);
    final _title = () {
      final _dot = _shortFile.lastIndexOf(".");
      return _shortFile
          .substring(0, _dot == -1 ? 0 : _dot)
          .toUpperCase()
          .replaceAll(RegExp("[^A-Z]+"), " ");
    }();
    final _envVars = Platform.environment;
    final _lines = (await _file.readAsLines());

    // Loop through lines.
    for (int n = 0; n < _lines.length; n++) {
      String l = _lines[n];
      // Skip immediately if a line contains the stop command.
      if (l.trim().startsWith("// prep: stop_here")) break;

      // Default updates.
      l = _updateFields2(l, "p", "Path", path);
      l = _updateFields2(l, "f", "File", _shortFile);
      l = _updateFields2(l, "t", "Time", _time);
      l = _updateFields2(l, "d", "Date", _date);
      l = _updateFields2(l, "l", "Line", "${n + 1}");
      l = _updateFields1(l, "Title", _title);

      // Default replacements.
      l = _replaceFields(l, "p", path);
      l = _replaceFields(l, "f", _shortFile);
      l = _replaceFields(l, "t", _time);
      l = _replaceFields(l, "d", _date);
      l = _replaceFields(l, "l", "${n + 1}");
      l = _replaceFields(l, "Path", path);
      l = _replaceFields(l, "File", _shortFile);
      l = _replaceFields(l, "Time", _time);
      l = _replaceFields(l, "Date", _date);
      l = _replaceFields(l, "Line", "${n + 1}");
      l = _replaceFields(l, "Title", _title);

      // Breaks.
      l = _replaceFields(l, "br-heavy", BR_HEAVY);
      l = _replaceFields(l, "br-medium", BR_MEDIUM);
      l = _replaceFields(l, "br-light", BR_LIGHT);
      l = _replaceFields(l, "br-dash", BR_DASH);
      l = _replaceFields(l, "br-line", BR_LINE);

      // Experimental.
      l = _incrementFields(l, "Runs");

      // Replace with environment variables.
      if (includeEnv) {
        for (final entry in _envVars.entries) {
          final _key = entry.key;
          final _value = entry.value;
          l = _updateFields1(l, "ENV $_key", _value);
        }
      }
      // Custom replacements.
      for (final entry in fields.entries) {
        final _key = entry.key.toString();
        final _keyLowerCase = _key.toLowerCase();
        final _value = entry.value.toString();
        // Skip if value contains default keys.
        if ([
          "d",
          "date",
          "f",
          "file",
          "p",
          "path",
          "l",
          "line",
          "t",
          "time",
          "title",
        ].contains(_keyLowerCase)
            // Skip if value contains keywords.
            // NB: beg, end and sep cannot be special RegEx characters.
            //|| _value.toString().contains(RegExp("($beg|$end|$sep)"))
            ) {
          continue;
        }
        l = _updateFields1(l, _key, _value);
      }
      _lines[n] = l;
    }
    await _file.writeAsString(_lines.join("\n"));
  }

  //
  //
  //

  @protected
  MapEntry<String, String>? $extract(final String expression) {
    final _keyValue = expression.split(sep);
    if (_keyValue.length >= 2) {
      final _key = _keyValue[0].replaceAll(beg, " ").trim();
      final _value = _keyValue[1].replaceAll(end, " ").trim();
      return MapEntry(_key, _value);
    }
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String _dateFormatted(final DateTime now) {
  return "${now.month}/${now.day}/${now.year}";
}

String _timeFormatted(final DateTime now) {
  return "${now.hour.toString().padLeft(2, "0")}:"
      "${now.minute.toString().padLeft(2, "0")}";
}