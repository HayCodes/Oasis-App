import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int _activeIndex = 0;

  final _items = const [
    (icon: Icons.login, label: 'LOGIN', route: RouteNames.auth),
    (icon: Icons.login, label: 'SIGNUP', route: RouteNames.signup),
    (icon: Icons.category, label: 'CATEGORIES', route: RouteNames.categories),
    (icon: Icons.help, label: 'HELP', route: RouteNames.support),
  ];

  void _handleItemClick(int index, String route) {
    setState(() => _activeIndex = index);
    GoRouter.of(context).pop();
    GoRouter.of(context).pushNamed(route);
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
            ...List.generate(_items.length, (i) {
              final isActive = i == _activeIndex;
              return InkWell(
                onTap: () => _handleItemClick(i, _items[i].route),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Icon(
                        _items[i].icon,
                        size: 28,
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          _items[i].label,
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
          ],
        ),
      ),
    );
  }
}
