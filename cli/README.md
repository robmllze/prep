# A Simple Prep CLI

## Arguments

```text
help            Take a guess!
new             Generates the new config file prep.yaml
<CONFIG>        Use config file CONFIG.yaml instead
--new <CONFIG>  Generates a new config file called CONFIG.yaml
--path PATH     Prep from PATH instead of current path
--skip          Skip prepping
```
## Developer

### Running:
    dart run bin/cli.dart --new prep.yaml
    ./bin/windows/prep.exe

### Compiling:
    dart compile exe bin/cli.dart -o bin/windows/prep.exe --save-debugging-info=bin/windows/debug

### Add a Folder to PATH (Windows):
    set PATH=%PATH%;C:\prep\