import 'package:flutter/material.dart';

enum MaterialThemeProviderType {
  system,
  light,
  dark;

  static MaterialThemeProviderType fromName(String type) {
    if (type == light.name) return light;
    if (type == dark.name) return dark;
    return system;
  }
}

class MaterialThemeProvider extends StatefulWidget {
  final MaterialThemeProviderType value;
  final void Function(MaterialThemeProviderType value) onChanged;
  final Widget child;
  const MaterialThemeProvider({
    super.key,
    required this.child,
    required this.value,
    required this.onChanged,
  });

  @override
  State<MaterialThemeProvider> createState() => _MaterialThemeProviderState();

  static final themeTypeNotifier = ValueNotifier<MaterialThemeProviderType>(
    .system,
  );
}

class _MaterialThemeProviderState extends State<MaterialThemeProvider>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    MaterialThemeProvider.themeTypeNotifier.value = widget.value;
    MaterialThemeProvider.themeTypeNotifier.addListener(() {
      widget.onChanged(MaterialThemeProvider.themeTypeNotifier.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (MaterialThemeProvider.themeTypeNotifier.value == .system) {
      setState(() {});
    }
  }

  ThemeMode get currentThemeMode {
    final themeType = MaterialThemeProvider.themeTypeNotifier.value;
    return switch (themeType) {
      .dark => .dark,
      .light => .light,
      _ => .system,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MaterialThemeProvider.themeTypeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentThemeMode,
          home: widget.child,
        );
      },
    );
  }
}

class MaterialThemeProviderChooser extends StatelessWidget {
  MaterialThemeProviderChooser({super.key});

  final items = MaterialThemeProviderType.values.map((e) {
    final upper = e.name[0].toUpperCase();
    final name = '$upper${e.name.toLowerCase().substring(1, e.name.length)}';
    return DropdownMenuItem(value: e, child: Text(name));
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 5),
          Expanded(
            child: Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: MaterialThemeProvider.themeTypeNotifier,
            builder: (context, value, child) {
              return DropdownButton(
                padding: EdgeInsets.all(4),
                borderRadius: BorderRadius.circular(4),
                value: MaterialThemeProvider.themeTypeNotifier.value,
                items: items,
                onChanged: (value) {
                  MaterialThemeProvider.themeTypeNotifier.value = value!;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
