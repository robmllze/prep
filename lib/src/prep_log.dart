// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PREP LOG
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'utils.dart' show PrepKeyValue;

typedef OutputFn = Function(String);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Use PrepLog to log the status of your application and help with debugging.
class PrepLog {
  PrepLog._(); // Only allow static access.

  static int _entryCount = 0;

  /// All log entries are added to this List.
  static final List<String> allEntries = [];

  /// All alert logs are added to this List.
  static final List<String> alertEntries = [];

  /// All error logs are added to this List.
  static final List<String> errorEntries = [];

  /// All info logs are added to this List.
  static final List<String> infoEntries = [];

  /// All note logs are added to this List.
  static final List<String> noteEntries = [];

  /// All warning logs are added to this List.
  static final List<String> warningEntries = [];

  //
  //
  //

  static OutputFn _output = print;

  /// Sets the output function. The default is [print].
  static void setOutput(final OutputFn output) => _output = output;

  //
  //
  //

  static DateTime? _startTime;

  /// Starts the log timer.
  static void start() {
    _startTime ??= DateTime.now();
  }

  /// Calculates elapsed time in seconds since the call of [start].
  static double _elapsed() {
    if (_startTime != null) {
      final _dt = DateTime.now() - _startTime!;
      final _seconds = _dt.inMicroseconds / 1E6;
      return _seconds;
    }
    return -1;
  }

  //
  //
  //

  /// Logs a new entry.
  static String _log({
    required final String prefix,
    required final String message,
    required final String l,
    required final String f,
    required final OutputFn? output,
  }) {
    final _file = f.prepValue;
    final _line = int.tryParse(l.prepValue);
    final _time = _elapsed();
    final _timeFormatted = _time != -1 ? " ⏳ ${_time}s" : "";
    final _entry = '[${_entryCount++}] '
        '$prefix In FILE $_file and LINE ${_line ?? ""}$_timeFormatted\n'
        '"$message"';
    (output ?? _output).call(_entry);
    return _entry;
  }

  /// Logs an alert 🟡
  ///
  /// `l` line number as a prep String.
  /// `f` file name as a prep String.
  static void alert(
    final dynamic message, {
    required final String l,
    required final String f,
    final OutputFn? output,
  }) {
    final _messageAsString = message.toString();
    final _entry = _log(
      prefix: "🟡",
      message: _messageAsString,
      l: l,
      f: f,
      output: output,
    );
    allEntries.add(_entry);
    alertEntries.add(_entry);
  }

  /// Logs an error 🔴
  ///
  /// `l` line number as a prep String.
  /// `f` file name as a prep String.
  static void error(
    final dynamic message, {
    required final String l,
    required final String f,
    final OutputFn? output,
  }) {
    final _messageAsString = message.toString();
    final _entry = _log(
      prefix: "🔴",
      message: _messageAsString,
      l: l,
      f: f,
      output: output,
    );
    allEntries.add(_entry);
    errorEntries.add(_entry);
  }

  /// Logs an info ⚪
  ///
  /// `l` line number as a prep String.
  /// `f` file name as a prep String.
  static void info(
    final dynamic message, {
    required final String l,
    required final String f,
    final OutputFn? output,
  }) {
    final _messageAsString = message.toString();
    final _entry = _log(
      prefix: "⚪",
      message: _messageAsString,
      l: l,
      f: f,
      output: output,
    );
    allEntries.add(_entry);
    infoEntries.add(_entry);
  }

  /// Logs a note 🟢
  ///
  /// `l` line number as a prep String.
  /// `f` file name as a prep String.
  static void note(
    final dynamic message, {
    required final String l,
    required final String f,
    final OutputFn? output,
  }) {
    final _messageAsString = message.toString();
    final _entry = _log(
      prefix: "🟢",
      message: _messageAsString,
      l: l,
      f: f,
      output: output,
    );
    allEntries.add(_entry);
    noteEntries.add(_entry);
  }

  /// Logs a warning 🟠
  ///
  /// `l` line number as a prep String.
  /// `f` file name as a prep String.
  static void warnings(
    final dynamic message, {
    required final String l,
    required final String f,
    final OutputFn? output,
  }) {
    final _messageAsString = message.toString();
    final _entry = _log(
      prefix: "🟠",
      message: _messageAsString,
      l: l,
      f: f,
      output: output,
    );
    allEntries.add(_entry);
    warningEntries.add(_entry);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension _DateTime_Subtraction on DateTime {
  /// Computes the difference in [Duration] between two dates/times.
  Duration operator -(final DateTime other) => Duration(
        microseconds:
            this.microsecondsSinceEpoch - other.microsecondsSinceEpoch,
      );
}
