// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// SRC FILES AND FOLDERS
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com,>
// <#Date = 8/26/2021>
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'dart:io' show Directory;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<List<String>> getFileNamesFromPath(
  final String path, {
  final List<String> types = const [],
  final bool recursive = true,
  final List<String> exclude = const [],
}) async {
  final _files = <String>[];
  final _dirs = await Directory(path).list(recursive: recursive).toList();
  for (final dir in _dirs) {
    // Skip directories.
    if (dir.toString().startsWith("D")) continue;
    // Get file path and allow only the forward slash.
    final _path = dir.path.toLowerCase().replaceAll("\\", "/");
    // Skip if _path ends with any of the excuded strings.
    final _excludeMe = exclude
        .firstWhere((__el) => _path.endsWith("/${__el.toLowerCase()}"),
            orElse: () => "")
        .isNotEmpty;
    if (_excludeMe) continue;
    // Allow any file of no types were specified.
    if (types.isEmpty) {
      _files.add(_path);
      continue;
    }
    // Allow only files of types.
    for (final type in types) {
      if (_path.endsWith(".${type.toLowerCase()}")) {
        _files.add(_path);
      }
    }
  }
  return _files;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String getShortFileName(final String longFileName) {
  return longFileName.substring(longFileName.lastIndexOf("/") + 1);
}