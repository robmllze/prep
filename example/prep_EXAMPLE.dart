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
  print("The time now is " + "<#t=08:45>".prepValue);
  print("This package is " + "<#Package = prep>".prepValue);
  print("The package version is " + "<#Version = 0.2.2>".prepValue);
  print("Let's print the USERNAME environment variable: " +
      "<#ENV USERNAME = r0bm0>".prepValue);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
  OUTPUT:
  
  Follow me on Instagram @robmllze
  This file is prep_example.dart
  This line is number 24
  The time now is 13:07
  This package is prep
  The package version is 0.2.2
  Let's print the USERNAME environment variable: guest

 */