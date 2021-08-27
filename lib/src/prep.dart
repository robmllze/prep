// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PREP
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library prep;

import 'dart:io' show File, FileSystemException;
import 'package:yaml/yaml.dart';
import 'prep_example.yaml.dart';
import 'files_and_folders.dart';
import 'parser.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Parses all files of types `parseTheseFileTypes` from the `path` directory,
/// as well as all subdirectories, except for files specified in
/// `dontParseTheseFiles`.
///
/// To include environment variables, set `includeEnv` to true.
///
/// To update custom fields, set `updateTheseFields`.
///
/// Note: These arguments will overwrite those specified in the files
/// `prepYaml` and `pubspecYaml`.
/// The example file prep_example.yaml will be generated in the project
/// directory if `prepYaml` doesn't exist.
///
/// Completes with `true` if there were no errors.
Future<bool> prep({
  final String? path,
  final List<String> parseTheseFileTypes = const [],
  final List<String> dontParseTheseFiles = const [],
  final Map<String, Object> updateTheseFields = const {},
  final bool? includeEnv,
  final String prepYaml = "prep.yaml",
  final String pubspecYaml = "pubspec.yaml",
  final bool generateExample = true,
}) {
  return Future<bool>(() async {
    try {
      // Generate prep_example.yaml if necessary.
      if (generateExample) {
        await genPrepExampleYaml();
      }

      // Parse pubspec.yaml.
      final _pubspec = await File(pubspecYaml).readAsString().catchError((e) {
        print("→ Prep Warning: $pubspecYaml is missing.");
        return "";
      });

      final _pubspecDecoded =
          ((_pubspec.isNotEmpty ? loadYaml(_pubspec) : null) ?? {}) as Map;
      final _package = (_pubspecDecoded["name"]) as String?;
      final _version = (_pubspecDecoded["version"]) as String?;
      final _homepage = (_pubspecDecoded["homepage"]) as String?;

      // Parse prep.yaml.
      final _prep = await File(prepYaml).readAsString().catchError((e) {
        print("→ Prep Suggestion: $prepYaml is missing. Consider adding it.");
        return "";
      });
      final _prepDecoded =
          ((_prep.isNotEmpty ? loadYaml(_prep) : null) ?? {}) as Map;
      final _prepSyntaxBeg = (_prepDecoded["syntax_beg"] ?? "`") as String;
      final _prepSyntaxEnd = (_prepDecoded["syntax_end"] ?? "`") as String;
      final _prepSyntaxSep = (_prepDecoded["syntax_sep"] ?? "=") as String;
      final _prepIncludeEnv = (_prepDecoded["include_env"]) as bool?;
      final _prepPath = (_prepDecoded["path"] ?? ".") as String;
      final _prepUpdateTheseFields =
          (_prepDecoded["update_these_fields"] ?? {}) as Map;
      final _prepDontParseTheseFiles =
          (_prepDecoded["dont_parse_these_files"] ?? []) as List;
      final _prepParseTheseFileTypes =
          (_prepDecoded["parse_these_file_types"] ?? []) as List;

      // Find paths of all parsable files.
      final _parsables = await getLongFileNamesFromPath(
        path ?? _prepPath,
        types: [
          ...parseTheseFileTypes,
          ..._prepParseTheseFileTypes.cast(),
        ],
        filesToExclude: [
          ...dontParseTheseFiles,
          ..._prepDontParseTheseFiles.cast(),
        ],
      );

      // Tweak syntax if necessary.
      PrepParser.instance.syntax(
        beg: _prepSyntaxBeg,
        end: _prepSyntaxEnd,
        sep: _prepSyntaxSep,
      );

      // Parse each parsable file.
      for (final parsable in _parsables) {
        await PrepParser.instance.parse(
          parsable,
          fields: {
            // Fields from prep.yaml.
            ..._prepUpdateTheseFields.cast(),
            // Frields from arguments.
            ...updateTheseFields,
            // Fields from pubspec.yaml.
            if (_package != null) "Package": _package,
            if (_version != null) "Version": _version,
            if (_homepage != null) "Homepage": _homepage,
          },
          includeEnv: includeEnv ?? _prepIncludeEnv ?? false,
        );
      }
    } on YamlException catch (e) {
      print("→ Prep ERROR: Error in prep.yaml: $e");
      return false;
    } on FileSystemException catch (_) {
      // Ignore these exceptions. May be thrown if file encoding isn't compatible.
      return false;
    } catch (e) {
      print("→ Prep ERROR: $e");
      return false;
    }
    return true;
  });
}