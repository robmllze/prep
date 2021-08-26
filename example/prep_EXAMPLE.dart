// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PREP EXAMPLE
//
// <#Author = Robert Mollentze>
// <#Email = robmllze@gmail.com,>
// <#Date = 8/26/2021>
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:prep/prep.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  prep();
  print("Follow me on Instagram " + "<#Instagram = @robmllze>".value);
  print("This file is " + "<#f=prep_example.dart>".value);
  print("This line is number " + "<#l=19>".value);
  print("The time now is " + "<#t=07:52>".value);
  print("This package is " + "<#Package = prep>".value);
  print("The package version is " + "<#Version = 0.1.0>".value);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*

OUTPUT:

  Follow me on Instagram @robmllze
  This file is prep_example.dart
  This line is number 18
  The time now is 06:56
  This package is prep
  The package version is 0.1.0

 */