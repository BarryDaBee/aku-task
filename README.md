

# 📝 Aku test
Search page implementation



https://github.com/user-attachments/assets/3d21f9ae-9207-4f92-a5f0-df41f085d8de



## 🚀 Getting Started

This project uses **Flutter (stable channel)**. 

> 📌 You can use any device emulator or real Android/iOS device for testing.

### ✅ Requirements
- Flutter SDK (stable channel)
- Dart SDK
- Android Studio or VS Code
- Xcode (for iOS builds, optional)

### 📦 Installation

1. **Clone the Repository**

```bash
git clone git@github.com:BarryDaBee/aku-task.git
cd aku-task
```

### 🚀 Steps to Run

#### 1. 🔧 Set Up Dependencies and Generate Code

Run the following to clean the project, install dependencies, generate localization and `build_runner` outputs (e.g., `freezed`, `json_serializable`):

`make fresh` 

> Equivalent to:  
> `flutter clean && flutter pub get && dart run build_runner build -d && flutter gen-l10n`

----------

#### 2. 🔄 Regenerate Code Only

If you just need to regenerate code (e.g., after editing models or annotations):

`make runner` 

> Runs `dart run build_runner build -d`

#### 3. 👀 Watch for File Changes

Automatically regenerates code on file changes during development:
`make watch` 

> Runs `dart run build_runner watch -d`

#### 4. 📦 Build APK (for Android)

To create an APK:
`make apk` 

> Equivalent to:  
> `flutter clean && flutter build apk`


## Folder Structure :open_file_folder:

```
lib/
├── app/
├── core/
│   ├── errors/
│   ├── network/
│   └── utils/
├── di/
├── features/
│   ├── search/
│   │   ├── data/
│   │   │   ├── client/
│   │   │   ├── data_sources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── use_cases/
│   │   └── presentation/
│   │       ├── blocs/
│   │       ├── pages/
│   │       └── widgets/
```

## Running Tests :memo:

All tests are contained in the ``test`` folder.
> The ``test`` folder structure mirrors that of the ``lib`` folder with a prefix of ``_test``
i.e the test file for ``lib/filename.dart`` is ``test/filename_test.dart``

To run all tests, navigate to the root directory of the project and paste and run the following command in the terminal.


``` bash
flutter test
```

## ✨ Features

-   🔎 Debounced Search with Pagination
    
-   🧑‍💼 User Cards with Cached Network Image & Fallback
    
-   ♿️ Accessible UI with Semantics Labels
    
-   🚧 Clean Architecture for maintainability
    
-   💻 Mocked and testable data sources
    
-   📱 Responsive, simple mobile-ready design

## 📦 **Dependencies**

-   **`bloc_concurrency`** – Optimizes event handling in BLoC by controlling how events are processed concurrently or sequentially.
    
-   **`cached_network_image`** – Efficiently loads and caches network images to reduce redundant network calls and improve performance.
    
-   **`dio`** – A powerful HTTP client for making API requests with advanced features like interceptors and cancellation.
    
-   **`equatable`** – Simplifies value comparison in Dart classes, especially for state management.
    
-   **`flutter`** – The core Flutter SDK used to build beautiful, cross-platform apps from a single codebase.
    
-   **`flutter_bloc`** – Enables implementation of the BLoC (Business Logic Component) pattern for predictable state management.
    
-   **`flutter_localizations`** – Adds built-in support for localizing your Flutter app into multiple languages.
    
-   **`freezed_annotation`** – Used to generate immutable data classes with copy, equality, and JSON methods via `freezed`.
    
-   **`freezed`** – Code generation tool for creating unions/sealed classes and immutable models in Dart.
    
-   **`get_it`** – A lightweight service locator for dependency injection to manage app-wide objects easily.
    
-   **`intl`** – Supports internationalization, localization, and date/number formatting in different locales.
    
-   **`json_annotation`** – Adds annotations used with code generators like `json_serializable` for model serialization.
    
-   **`logger`** – A customizable logging utility to help you debug by printing logs in a structured way.
    
-   **`retrofit`** – A type-safe HTTP client generator for Dart inspired by Retrofit in Android/Kotlin.
    
-   **`rxdart`** – Adds functional and reactive extensions to Dart streams (in this case, used to implement debouncers.
