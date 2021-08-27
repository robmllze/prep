// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PREP EXAMPLE
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com>
// <#Date = 8/27/2021>
//
// See LICENSE file
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:prep/prep.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  // Process source files as per prep.yaml.
  prep();
  print("Follow me on Instagram " + "<#Instagram = @robmllze>".value);
  print("This file is " + "<#f=prep_example.dart>".value);
  print("This line is number " + "<#l=24>".value);
  print("The time now is " + "<#t=13:08>".value);
  print("This package is " + "<#Package = prep>".value);
  print("The package version is " + "<#Version = 0.2.0>".value);
  print("Let's print the USERNAME environment variable: " +
      "<#ENV USERNAME = guest>".value);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
  OUTPUT:
  
  Follow me on Instagram @robmllze
  This file is prep_example.dart
  This line is number 24
  The time now is 13:07
  This package is prep
  The package version is 0.2.0
  Let's print the USERNAME environment variable: guest

 */