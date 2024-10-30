
# rust_file

`rust_file` is a high-performance Dart and Flutter-compatible package for file and directory management, powered by Rust. This package provides a complete solution for performing various file and directory tasks—including creating, updating, deleting, and more. By leveraging Rust’s speed, `rust_file` ensures faster file operations than pure Dart implementations, making it ideal for applications requiring efficient file system handling.

## Features

- **Comprehensive File Operations**: Easily create, read, write, delete, and update files.
- **Directory Management**: Support for creating, listing, deleting, and manipulating directories.
- **Cross-Platform**: Compatible with Android, iOS, macOS, Windows, and Linux.
- **High Performance**: Built using Rust, ensuring optimal speed and efficiency for intensive file operations.
- **Dart & Flutter Support**: Designed for use in both Dart and Flutter projects.

## Getting Started

### Prerequisites

To use `rust_file`, ensure you have:

### Installation

Add `rust_file` to your Dart or Flutter project:

```yaml
dependencies:
  rust_file:
    git: https://github.com/blackshadow-software/rust_file.git
```

Run the following to get the dependencies:

```bash
dart pub get
# or for Flutter
flutter pub get
```

### Rust Setup

1. **Install Rust and cargo-kit**:

### Importing and Loading the Library

In your Dart or Flutter code, load the Rust library based on the platform:
 
### Example Functions

#### 1. Creating a File

#### 2. Reading a File

#### 3. Deleting a File

## Platform-Specific Details

For mobile (Android & iOS), ensure you set up cross-compilation correctly. Use **cargo-ndk** for Android and configure Rust with the appropriate targets for iOS.

## Contributing

Contributions are welcome! Feel free to submit a pull request to improve functionality or add features.

## License

MIT License. See [LICENSE](./LICENSE) for more details.
