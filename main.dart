import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

// Uncomment once `flutterfire configure` has generated firebase_options.dart:
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: PrepZoneApp()));
}

class PrepZoneApp extends ConsumerWidget {
  const PrepZoneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'PrepZone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
