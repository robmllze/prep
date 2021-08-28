// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PREP EXAMPLE
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/28/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:prep/prep.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  // Process source files as per prep.yaml.
  prep();
  print("Follow me on Instagram " + "<#Instagram = @robmllze>".prepValue);
  print("This file is " + "<#f=prep_example.dart>".prepValue);
  print("This line is number " + "<#l=22>".prepValue);
  print("The time now is " + "<#t=11:30>".prepValue);
  print("This package is " + "<#Package = prep>".prepValue);
  print("The package version is " + "<#Version = 0.3.1>".prepValue);
  print("Let's print the USERNAME environment variable: " +
      "<#ENV USERNAME = r0bm0>".prepValue);
  if (int.tryParse("42") == 42) {
    // PrepLog is a great tool for debugging!
    PrepLog.note(
      "The answer to life, the Universe and everything is...42!",
      l: "<#l=32>",
      f: "<#f=prep_example.dart>",
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
  OUTPUT:
  
  Follow me on Instagram @robmllze
  This file is prep_example.dart
  This line is number 22
  The time now is 11:30
  This package is prep
  The package version is 0.3.1
  Let's print the USERNAME environment variable: r0bm0
  [0] 🟢 In FILE prep_example.dart and LINE 32 ⏳ 0.003s
  "The answer to life, The Universe and everything is...42!"

 */