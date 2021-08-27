:: 0. Exists current folder
cd ..
:: 1. Preps your source code as per prep.yaml
prep prep.yaml
:: 2. Serves your application in Chrome on port 8080
flutter run -d web-server --web-port 8080