import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const OasisApp());
}

class OasisApp extends StatelessWidget {
  const OasisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Oasis',
      debugShowCheckedModeBanner: false,
      // routeInformationParser: AppRouter().router.routeInformationParser ,
      // routeInformationProvider: AppRouter().router.routeInformationProvider ,
      // routerDelegate: AppRouter().router.routerDelegate ,
      routerConfig: AppRouter().router,
      theme: AppTheme.light,
    );
  }
}
