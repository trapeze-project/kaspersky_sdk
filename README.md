# Flutter Plugin Package for Kaspersky Mobile Security SDK

This repository is a [Flutter Plugin Package](https://docs.flutter.dev/packages-and-plugins/developing-packages#types) to make the cyber security functionality from the [Kaspersky Mobile Security SDK](https://www.kaspersky.de/mobile-security-sdk) by the Cyber-Security Company  Kaspersky available for use in Flutter Mobile Applications. 

The current version 0.0.1 makes available the *EasyScanner* malware detection function for the Android software platform. 

## 1. Requirements

You require a Kaspersky Mobile Security SDK license key (format: "XXXX-XXXX-XXXX-XXXX") and three .aar archive files from the Kaspersky Mobile Security SDK.

### 1.1 Add Your License Key

The license key needs to be substituted with the placeholder ```"<ADD-YOUR-LICENSE-KEY>"``` in the file ```/android/src/main/java/de/berlin/tu/kaspersky_sdk/AntivirusController.java```. 

### 1.2 Add the .aar Archive Files

The following three archive files 

* KL_Base_SDK_Android_5.13.0.136_Release.aar
* KL_Mobile_SDK_Android_5.13.0.136_FullRelease.aar
* KL_SimWatch_Android_5.13.0.136_Release.aar

have to be copied into the ```/android/libs/``` directory.


## 2. Usage

### 2.1 Install Flutter and Dart Command-Line Programs

Download the latest stable release version of Flutter command-line program by following the official [installation steps](https://docs.flutter.dev/get-started/install). We verified the code to work for the following Flutter version:

```sh
>> flutter --version
Flutter 3.0.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision ee4e09cce0 (7 days ago) • 2022-05-09 16:45:18 -0700
Engine • revision d1b9a6938a
Tools • Dart 2.17.0 • DevTools 2.12.2
```

> Note that the installation of the Flutter command-line program includes the installation of the Dart command-line program.

### 2.2 Create Folder Structure 

Clone the ```kaspersky_sdk```repository. 

```git clone https://github.com/trapeze-project/kaspersky_sdk.git````

And copy it into the same directory as ```your_project``` in which you want to use it.

```sh
/path/to/parent/dir
|-- /kaspersky_sdk  --> this Flutter plugin package
|-- /your_project   --> your_project that uses this plugin 
```

In ```your_project``` add the following lines to `pubspec.yaml` to the `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # other dependencies

  kaspersky_sdk:
    path: ../kaspersky_sdk
```

Run `flutter clean` and `flutter pub get` and you're ready to use this plugin in your project.


### 2.2 Kaspersky Mobile Security SDK Initialization

First of all, it is required to initialize the Flutter Plugin Package as follows.

```dart
KavSdk.init(listener);
```

Listen to the `KavSdkInitListener` for the initialization to finish.

### 2.3 Easy Scanner (Malware Detection)

Run malware detection scans through the Easy Scanner as follows.

```dart
EasyScanner easyScanner = EasyScanner();

// initiate scanning
easyScanner.scan(mode, listener);
```

Listen to the `EasyListener` for events, including the end of a scan. 
More detailed information on the usage of the Kaspersky Mobile Security SDK will be made available by Kaspersky upon the purchase of a license. 


### 2.4 Example

An example project that makes use of the ```kaspersky_sdk``` Flutter Plugin Package is the TRAPEZE Mobile Application. The repository to its source code be found [here](https://github.com/trapeze-project/trapeze-mobile/).


## Contact

Please do not hesitate to direct your questions to tobias.eichinger (AT) tu-berlin.de and philip.raschke (AT) tu-berlin.de.