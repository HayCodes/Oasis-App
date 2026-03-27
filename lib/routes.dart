import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/404/error_page.dart';
import 'package:oasis/app/blog/blog_screen.dart';
import 'package:oasis/app/categories/categories_screen.dart';
import 'package:oasis/app/categories/categories_view_page.dart';
import 'package:oasis/app/home/home_screen.dart';
import 'package:oasis/app/profile/profile.dart';
import 'package:oasis/app/shop/shop_screen.dart';
import 'package:oasis/app/sign_in/login.dart';
import 'package:oasis/app/sign_up/presentation/ui/signup.dart';
import 'package:oasis/app/support/support.dart';
import 'package:oasis/components/widgets/home_screen/bottom_nav.dart';
import 'package:oasis/components/widgets/splash_screen.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // ── Outside the shell (no bottom nav) ──
      GoRoute(
        path: '/',
        name: RouteNames.splashScreen,
        pageBuilder: (context, state) =>
        const MaterialPage(child: SplashScreen()),
      ),
      GoRoute(
        path: '/auth',
        name: RouteNames.auth,
        pageBuilder: (context, state) =>
        const MaterialPage(child: Auth()),
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        pageBuilder: (context, state) =>
        const MaterialPage(child: SignUp()),
      ),
      GoRoute(
        path: '/support',
        name: RouteNames.support,
        pageBuilder: (context, state) =>
        const MaterialPage(child: Support()),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        pageBuilder: (context, state) =>
        const MaterialPage(child: Profile()),
      ),

      // ── Inside the shell (has bottom nav) ──
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomNav(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                pageBuilder: (context, state) =>
                    CustomTransitionPage(
                      child: const HomeScreen(),
                      transitionsBuilder: (context, animation,
                          secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                      transitionDuration: const Duration(milliseconds: 800),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shop',
                name: RouteNames.shop,
                pageBuilder: (context, state) =>
                const MaterialPage(child: ShopScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/blog',
                name: RouteNames.blog,
                pageBuilder: (context, state) =>
                const MaterialPage(child: BlogScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/categories',
                name: RouteNames.categories,
                pageBuilder: (context, state) =>
                const MaterialPage(child: CategoryPage()),
                routes: [
                  GoRoute(
                    path: ':slug',
                    name: RouteNames.categoryView,
                    pageBuilder: (context, state) {
                      final slug = state.pathParameters['slug']!;
                      final item = CategoryPage.categories.firstWhere(
                            (cat) => cat.slug == slug,
                      );
                      return MaterialPage(child: CategoryViewPage(item: item));
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state,) =>
    const MaterialPage(child: ErrorPage()),
  );
}