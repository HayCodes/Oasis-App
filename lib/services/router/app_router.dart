import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/screens/404/error_page.dart';
import 'package:oasis/screens/auth/login.dart';
import 'package:oasis/screens/auth/signup.dart';
import 'package:oasis/screens/categories_screen.dart';
import 'package:oasis/screens/home_screen.dart';
import 'package:oasis/screens/splash_screen.dart';
import 'package:oasis/screens/support.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splashScreen,
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        },
      ),
      GoRoute(
        path: '/auth',
        name: RouteNames.auth,
        pageBuilder: (context, state) {
          return MaterialPage(child: Auth());
        },
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        pageBuilder: (context, state) {
          return MaterialPage(child: SignUp());
        },
      ),
      GoRoute(
        path: '/support',
        name: RouteNames.support,
        pageBuilder: (context, state) {
          return MaterialPage(child: Support());
        },
      ),
      GoRoute(
        path: '/categories',
        name: RouteNames.categories,
        pageBuilder: (context, state) {
          return MaterialPage(child: CategoriesScreen());
        },
      ),
      GoRoute(
        path: '/shop',
        name: RouteNames.shop,
        pageBuilder: (context, state) {
          return MaterialPage(child: CategoriesScreen());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(child: ErrorPage());
    }
  );
}
