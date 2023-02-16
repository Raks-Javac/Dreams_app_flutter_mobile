import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/features/views/home_view.dart';
import 'src/shared/res/assets.dart';
import 'src/shared/res/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(themeProvider);
    return LayoutBuilder(builder: (context, constraint) {
      return MaterialApp(
        title: TAssets.appName,
        theme: ref.watch(themeProvider.notifier).returnThemeBasedOnBool(),
        themeMode: ThemeMode.system,
        home: HomeView(
          constraint: constraint,
        ),
      );
    });
  }
}
