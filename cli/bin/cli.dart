// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// CLI
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:io' show FileSystemException;
import 'package:prep/prep.dart';
import 'package:prep/src/prep_example.yaml.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main(final List<String> args) async {
  var _prepYaml = "prep.yaml";
  String? _path;
  bool _skip = false;
  final _length = args.length;
  try {
    // Single arg.
    if (_length == 1) {
      final _arg = args.last.toLowerCase();
      switch (_arg) {
        case "help":
          printHelp();
          return;
        case "new":
          print("→ Generating $_prepYaml...");
          await genPrepExampleYamlEmpty(_prepYaml);
          print("→ Done!");
          _skip = true;
          print("→ Skipping prep...");
          break;
        default:
          _prepYaml = _arg.endsWith(".yaml") ? _arg : "$_arg.yaml";
          print("→ As per $_prepYaml");
      }
    } else
    // Multiple args.
    if (_length > 1) {
      for (int i = 0; i < _length - 1; i++) {
        final _key = args[i].toLowerCase();
        final _value = args[i + 1].toLowerCase();
        if (_key == "--use") {
          _prepYaml = _value.endsWith(".yaml") ? _value : "$_value.yaml";
          print("→ As per $_prepYaml...");
        }
        if (!_skip && _value == "--skip") {
          _skip = true;
          print("→ Skipping prep...");
        }
        if (_key == "--path") {
          _path = _value;
          print("→ Parsing from path $_value");
        }
        if (_key == "--new") {
          _prepYaml = _value == "." ? _prepYaml : "$_value.yaml";
          print("→ Generating $_prepYaml...");
          await genPrepExampleYamlEmpty(_prepYaml);
          print("→ Done!");
        }
      }
    }
    final _success = _skip
        ? true
        : await prep(
            path: _path,
            prepYaml: _prepYaml,
            //pubspecYaml: "",
            generateExample: false,
          );
    if (!_success) throw FileSystemException();
    print("→ Success!");
  } on FileSystemException catch (_) {
    print("→ Error: Cannot find $_prepYaml!");
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void printHelp() {
  print("→ Displaying help...\n\n"
      "help\t\tTake a guess!\n"
      "new\t\tGenerates the new config file prep.yaml\n"
      "<CONFIG>\tUse config file CONFIG.yaml instead\n"
      "--new <CONFIG>\tGenerates a new config file called CONFIG.yaml\n"
      "--use <CONFIG>\tUse config file CONFIG.yaml instead\n"
      "--path PATH\tPrep from PATH instead of current path\n"
      "--skip\t\tSkip prepping\n");
}