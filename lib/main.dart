import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/environment.dart';
import 'package:oasis/locator.dart';
import 'package:oasis/routes.dart';
import 'package:oasis/services/bloc/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initializeDependencies();
  await sl.allReady();
  debugPrint('🌍 Base URL: ${appConfig.baseUrl}'); // ✅ add this
  debugPrint('🌍 ENV: ${appConfig.env}');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  try {
    final bloc = sl<TopProductsBloc>();
    final categoryBloc = sl<CategoryContentBloc>();
    debugPrint('✅ ShopBloc resolved: $bloc');
    debugPrint('CategoryContentBloc resolved: $categoryBloc');
  } catch (e) {
    debugPrint('❌ ShopBloc failed: $e');
  }

  runApp(const OasisApp());
}

final _appRouter = AppRouter();

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
