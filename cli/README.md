# A Simple Prep CLI

## Basics

### Instructions
1. Compile prep to produce an executable and place it somewhere like C:\prep\bin\windows.
2. Add executable path to PATH system environment variable
    - On Windows run: `set PATH=%PATH% C:\prep\bin\windows` or type "env" in the start menu search box then click on "Edit the system environment variables".
3. Run the command `prep` each time before running your application, or better, if using Windows, automate this with a batch script:

``` batch
:: NB: First ensure prep.yaml exists. Run "prep new" to create.
:: 1. Preps your source code as per prep.yaml
prep prep.yaml
:: 2. Serves your application in Chrome on port 8080
flutter run -d web-server --web-port 8080
```

*See the "run_scripts" folder for more examples.*

## Developer

### Compiling
    dart compile exe bin/cli.dart -o bin/windows/prep.exe --save-debugging-info=bin/windows/debug

    OR

    dart compile exe bin/cli.dart -o bin/macos/prep --save-debugging-info=bin/macos/debug

### Running
    dart run bin/cli.dart --new prep.yaml
    ./bin/windows/prep.exe

### CLI Options

```text
help            Take a guess!
new             Generates the new config file prep.yaml
<CONFIG>        Use config file CONFIG.yaml instead
--new <CONFIG>  Generates a new config file called CONFIG.yaml
--path PATH     Prep from PATH instead of current path
--skip          Skip prepping
```


