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
  // Process source files as per prep.yaml.
  prep();
  print("Follow me on Instagram " + "<#Instagram = @robmllze>".value);
  print("This file is " + "<#f=prep_example.dart>".value);
  print("This line is number " + "<#l=20>".value);
  print("The time now is " + "<#t=13:11>".value);
  print("This package is " + "<#Package = prep>".value);
  print("The package version is " + "<#Version = 0.1.1+1>".value);
  print("Let's print the USERNAME environment variable: " +
      "<#ENV USERNAME = r0bm0>".value);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
OUTPUT:
  Follow me on Instagram @robmllze
  This file is prep_example.dart
  This line is number 20
  The time now is 11:54
  This package is prep
  The package version is 0.1.1
  Let's print the USERNAME environment variable: guest
 */