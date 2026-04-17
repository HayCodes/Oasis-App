import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/locator.dart';
import 'package:oasis/routes.dart';
import 'package:oasis/services/bloc/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initializeDependencies();
  await sl.allReady();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const OasisApp());
}

final _appRouter = AppRouter();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class OasisApp extends StatelessWidget {
  const OasisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
        builder: (context, child) =>
            MaterialApp.router(
              title: 'Oasis',
              debugShowCheckedModeBanner: false,
              routerConfig: _appRouter.router,
              theme: AppTheme.light,
            ),
      ),
    );
  }
}
