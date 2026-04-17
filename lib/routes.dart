import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/404/error_page.dart';
import 'package:oasis/app/blog/blog_screen.dart';
import 'package:oasis/app/categories/presentation/ui/categories_screen.dart';
import 'package:oasis/app/categories/presentation/ui/categories_view_page.dart';
import 'package:oasis/app/home/home_screen.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.bloc.dart';
import 'package:oasis/app/profile/profile.dart';
import 'package:oasis/app/shop/presentation/bloc/all_products/shop.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/app/shop/product_detail_screen.dart';
import 'package:oasis/app/shop/shop_screen.dart';
import 'package:oasis/app/sign_in/login.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
import 'package:oasis/app/sign_up/presentation/ui/signup.dart';
import 'package:oasis/app/support/support.dart';
import 'package:oasis/components/widgets/home_screen/bottom_nav.dart';
import 'package:oasis/components/widgets/home_screen/splash_screen.dart';
import 'package:oasis/locator.dart';
import 'package:oasis/main.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class AppRouter {
  GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
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
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const Auth(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<SignUpBloc>(),
          child: const SignUp(),
        ),
      ),
      GoRoute(
        path: '/support',
        name: RouteNames.support,
        pageBuilder: (context, state) => const MaterialPage(child: Support()),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: const Profile(),
        ),
      ),
      GoRoute(
        path: '/product/:slug',
        name: RouteNames.productDetail,
        builder: (context, state) {
          final slug = state.pathParameters['slug']!;
          return BlocProvider(
            create: (context) => sl<ProductDetailBloc>(),
            child: ProductDetailScreen(slug: slug),
          );
        },
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
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: BlocProvider(
                    create: (context) => sl<TopProductsBloc>(),
                    child: const HomeScreen(),
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
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
                builder: (context, state) => BlocProvider(
                  create: (context) => sl<AllProductsBloc>(),
                  child: const ShopScreen(),
                ),
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
                      return MaterialPage(child: CategoryViewPage(slug: slug));
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) =>
        const MaterialPage(child: ErrorPage()),
  );
}
