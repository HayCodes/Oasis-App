import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/locator.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late Future<bool> _isLoggedIn;
  final sessionService = sl<SessionService>();

  int _activeIndex = 0;

  final _authItems = const [
    (icon: Icons.shopping_cart, label: 'MY ORDERS', route: null),
    (icon: Icons.person, label: 'PROFILE', route: RouteNames.profile),
    (icon: Icons.help, label: 'HELP', route: RouteNames.support),
    (icon: Icons.logout, label: 'LOGOUT', route: null),
  ];

  final _guestItems = const [
    (icon: Icons.login, label: 'LOGIN', route: RouteNames.auth),
    (icon: Icons.help, label: 'HELP', route: RouteNames.support),
  ];

  void _handleItemClick(int index, List items) {
    final item = items[index];

    if (item.route == null && item.label == 'LOGOUT') {
      sessionService.logout();
      GoRouter.of(context).pop();
      return;
    }

    setState(() => _activeIndex = index);
    GoRouter.of(context).pop();
    GoRouter.of(context).pushNamed(item.route!);
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn = sessionService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: GestureDetector(
                onTap: () => GoRouter.of(context).pop(),
                child: const Icon(Icons.close, size: 28),
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder<bool>(
              future: _isLoggedIn,
              builder: (context, snapshot) {
                final loggedIn = snapshot.data ?? false;
                final items = loggedIn ? _authItems : _guestItems;

                return Column(
                  children: List.generate(items.length, (i) {
                    final isActive = i == _activeIndex;
                    return InkWell(
                      onTap: () => _handleItemClick(i, items),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Icon(
                              items[i].icon,
                              size: 28,
                              color: isActive
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                items[i].label,
                                style: TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1.2,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isActive
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
