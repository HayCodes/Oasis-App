import 'package:flutter/material.dart';
import 'package:oasis/components/themes/app_theme.dart';

// ─── Tab Bar ─────────────────────────────────────────────────────────────────
class BuildTabBar extends StatelessWidget {
  const BuildTabBar({super.key, required this.selected, required this.onTap});

  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          _TabItem(
            icon: Icons.person_outline_rounded,
            label: 'My Profile',
            active: selected == 0,
            onTap: () => onTap(0),
          ),
          const SizedBox(width: 8),
          _TabItem(
            icon: Icons.location_on_outlined,
            label: 'Addresses',
            active: selected == 1,
            onTap: () => onTap(1),
          ),
          const SizedBox(width: 8),
          _TabItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            active: selected == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? AppColors.black : AppColors.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                color: active ? AppColors.black : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );
}

class BuildDivider extends StatelessWidget {
  const BuildDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Divider(height: 1, color: AppColors.inputBorder),
      );
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      );
}

class BuildInputField extends StatelessWidget {
  const BuildInputField({required this.controller, this.keyboardType, super.key});

  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) =>
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: AppColors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.inputBorder, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      );
}

class ToggleRow extends StatelessWidget {
  const ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    super.key
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textMuted),
              ),
            ],
          ),
          Switch(
            key: ValueKey(title),
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.accent,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.inputBorder,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.label,
    required this.onTap,
    this.compact = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 20 : 28,
            vertical: compact ? 12 : 15,
          ),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: compact ? 14 : 15,
            ),
          ),
        ),
      );
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.inputBorder, width: 1.5),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
      );
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    required this.tag,
    required this.tagActive,
    required this.isDefault,
    required this.address,
    super.key
  });

  final String tag;
  final bool tagActive;
  final bool isDefault;
  final String address;

  @override
  Widget build(BuildContext context) {
    return BuildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: tagActive ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: tagActive
                      ? null
                      : Border.all(color: AppColors.inputBorder, width: 1.5),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tagActive ? Colors.white : AppColors.black,
                  ),
                ),
              ),
              if (isDefault) ...[
                const SizedBox(width: 8),
                const Text(
                  'Default',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Text(
            address,
            style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
