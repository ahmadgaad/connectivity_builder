# connectivity_builder

# Need a great Flutter developer? [I'm available](https://www.linkedin.com/in/ahmed-gad-435635197/)

The `connectivity_builder` package provides a simple and convenient way to manage different UI states based on the network connectivity status of your Flutter app.

## Features

- **Effortless UI Adaptation:** Build distinct widgets for online and offline scenarios without manual network checks.
- **Real-time Network Monitoring:** Automatically detect and respond to network connectivity changes, ensuring a seamless user experience.
- **Lightweight and Easy to Use:** Integrate the package seamlessly into your existing Flutter app with minimal effort.

## Getting Started

### Installation

1. Add the `connectivity_builder` package to your pubspec.yaml file:

```yaml
dependencies:
  connectivity_builder: ^latest_version
```

2. Run `flutter pub get` to install the package.

### Usage

The `ConnectivityBuilder` widget provides a simple way to manage UI states based on network connectivity:

```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ConnectivityBuilder(
          onlineBuilder: (context) => Center(child: Text('ONLINE 🌍')),
          offlineBuilder: (context) => Center(child: Text('OFFLINE 🚫')),
        ),
      ),
    );
  }
```

This will display a "No internet connection available" message when the device is offline and your app's main content when the device is online.

## Additional Information

### Contributing

Contributions to the `connectivity_builder` package are welcome! Please read the [contributing guidelines](CONTRIBUTING.md) for more information.

### Reporting Issues

If you encounter any bugs or have suggestions for improvements, please file an issue on the GitHub repository.

## License

This project is licensed under the MIT License.
