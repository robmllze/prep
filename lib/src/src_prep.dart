// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// SRC PREP
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com,>
// <#Date = 8/26/2021>
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

import 'dart:io' show File, FileSystemException;
import 'package:yaml/yaml.dart';
import 'package:prep/src/prep_example.yaml.dart';
import 'package:prep/src/src_files_and_folders.dart';
import 'package:prep/src/src_parser.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> prep({
  final String? path,
  final List<String> types = const [],
  final List<String> exclude = const [],
  final Map<String, Object> replace = const {},
  final bool? includeEnv,
}) async {
  try {
    // pubspec.yaml
    final _pubspec = await () {
      try {
        return File("pubspec.yaml").readAsString();
      } on FileSystemException catch (_) {
        print("🟠 Prep Warning: pubspec.yaml is missing.");
      }
    }();
    final _pubspecDecoded =
        ((_pubspec != null ? loadYaml(_pubspec) : null) ?? {}) as Map;
    final _package = (_pubspecDecoded["name"]) as String?;
    final _version = (_pubspecDecoded["version"]) as String?;
    final _homepage = (_pubspecDecoded["homepage"]) as String?;

    // Generate an example.
    await genPrepExampleYaml();

    // prep.yaml
    final _prep = await () {
      try {
        return File("prep.yaml").readAsString();
      } on FileSystemException catch (_) {
        print("🟡 Prep Suggestion: prep.yaml is missing. Consider adding it.");
      }
    }();
    final _prepDecoded =
        ((_prep != null ? loadYaml(_prep) : null) ?? {}) as Map;
    final _prepSyntaxBeg = (_prepDecoded["syntax_beg"] ?? "`") as String;
    final _prepSyntaxEnd = (_prepDecoded["syntax_end"] ?? "`") as String;
    final _prepSyntaxSep = (_prepDecoded["syntax_sep"] ?? "=") as String;
    final _prepIncludeEnv = (_prepDecoded["include_env"]) as bool?;
    final _prepPath = (_prepDecoded["path"] ?? ".") as String;
    final _prepReplace = (_prepDecoded["update_these_fields"] ?? {}) as Map;
    final _prepExclude = (_prepDecoded["dont_parse_these_files"] ?? []) as List;
    final _prepTypes = (_prepDecoded["parse_these_file_types"] ?? []) as List;

    final _files = await getFileNamesFromPath(
      path ?? _prepPath,
      types: [...types, ..._prepTypes.cast()],
      exclude: [...exclude, ..._prepExclude.cast()],
    );
    PrepParser.instance.syntax(
      beg: _prepSyntaxBeg,
      end: _prepSyntaxEnd,
      sep: _prepSyntaxSep,
    );
    for (final file in _files) {
      await PrepParser.instance.parse(
        file,
        fields: {
          ..._prepReplace.cast(),
          ...replace,
          // pubspec.yaml
          if (_package != null) "package": _package,
          if (_version != null) "version": _version,
          if (_homepage != null) "homepage": _homepage,
        },
        includeEnv: includeEnv ?? _prepIncludeEnv ?? false,
      );
    }
  } on YamlException catch (e) {
    print("🔴 Prep Error: Error in prep.yaml: $e");
  } catch (e) {
    print("🔴 Prep Error: $e");
  }
}