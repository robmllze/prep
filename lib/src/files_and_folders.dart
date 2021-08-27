// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// FILES AND FOLDERS
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'dart:io' show Directory;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Gets a list of all the long file names in `path`, as well as all files in
/// any subdirectories if `inclSubpaths` is true, given the following:
/// - Only files of types listed in `types` are allowed. If its empty, type
/// will be allowed.
/// - Files listed in `filesToExclude` will be excluded.
Future<List<String>> getLongFileNamesFromPath(
  final String path, {
  final List<String> types = const [],
  final bool inclSubpaths = true,
  final List<String> filesToExclude = const [],
}) async {
  final _files = <String>[];
  final _dirs = await Directory(path).list(recursive: inclSubpaths).toList();
  for (final dir in _dirs) {
    // Skip directories, only allow files.
    if (dir.toString().startsWith("D")) continue;
    // Get file path and allow only the forward slash.
    final _path = dir.path.toLowerCase().replaceAll("\\", "/");
    // Skip if _path ends with any of the excuded strings.
    final _excl = filesToExclude
        .firstWhere((__el) => _path.endsWith("/${__el.toLowerCase()}"),
            orElse: () => "")
        .isNotEmpty;
    if (_excl) continue;
    // Allow any file of no types were specified.
    if (types.isEmpty) {
      _files.add(_path);
      continue;
    }
    // Allow only files of specific types.
    for (final type in types) {
      if (_path.endsWith(".${type.toLowerCase()}")) {
        _files.add(_path);
      }
    }
  }
  return _files;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the shortened file name, e.g."C:\\prep\\README.md" becomes
/// "README.md"
String getShortFileName(final String longFileName) {
  return longFileName
      .replaceAll("\\", "/")
      .substring(longFileName.lastIndexOf("/") + 1);
}
