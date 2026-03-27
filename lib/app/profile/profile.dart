import 'package:flutter/material.dart';
import 'package:oasis/app/profile/presentation/ui/profile_widgets.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/page_header.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(title: 'Profile', textStyle: textStyle),
            _Header(),
            BuildTabBar(selected: _tab, onTap: (i) => setState(() => _tab = i)),
            Expanded(
              child: IndexedStack(
                index: _tab,
                children: const [
                  _MyProfileTab(),
                  _AddressesTab(),
                  _SettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage your personal information and preferences.',
          style: TextStyle(fontSize: 14, color: AppColors.textMuted),
        ),
      ],
    ),
  );
}

// ─── My Profile Tab ──────────────────────────────────────────────────────────
class _MyProfileTab extends StatefulWidget {
  const _MyProfileTab();

  @override
  State<_MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<_MyProfileTab> {
  final _nameController = TextEditingController(text: 'Hussein');
  final _emailController = TextEditingController(text: 'acedey4you@gmail.com');
  final _phoneController = TextEditingController(text: '+123412341234');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        children: [
          BuildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section title
                const Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Update your photo and personal details.',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
                const SizedBox(height: 20),

                // ── Avatar row
                Row(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: AppColors.accent,
                          child: Text(
                            'H',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.inputBorder,
                                width: 1.5,
                              ),
                            ),
                            child: GestureDetector(
                              // TO-DO add image picker
                              onTap: () {},
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 14,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile Photo',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'JPG, PNG or GIF. Max 1MB.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            OutlineButton(label: 'Change', onTap: () {}),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Remove',
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const BuildDivider(),

                // ── Fields
                const FieldLabel('Name'),
                BuildInputField(controller: _nameController),
                const SizedBox(height: 16),
                const FieldLabel('Email'),
                BuildInputField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                const FieldLabel('Phone Number'),
                BuildInputField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ActionButton(label: 'Save Changes', onTap: () {}),
          ),
        ],
      ),
    );
  }
}

// ─── Addresses Tab ────────────────────────────────────────────────────────────
class _AddressesTab extends StatelessWidget {
  const _AddressesTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Saved Addresses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              ActionButton(label: '+ Add New', onTap: () {}, compact: true),
            ],
          ),
          const SizedBox(height: 16),
          const AddressCard(
            tag: 'Home',
            tagActive: true,
            isDefault: true,
            address: '123 Oasis Blvd, Lagos, LA 100001, Nigeria',
          ),
          const SizedBox(height: 12),
          const AddressCard(
            tag: 'Work',
            tagActive: false,
            isDefault: false,
            address: '123 Oasis Blvd, Lagos, LA 100001, Nigeria',
          ),
        ],
      ),
    );
  }
}

// ─── Settings Tab ─────────────────────────────────────────────────────────────
class _SettingsTab extends StatefulWidget {
  const _SettingsTab();

  @override
  State<_SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<_SettingsTab> {
  bool _orderUpdates = true;
  bool _promotions = false;
  bool _securityAlerts = true;
  bool _smsNotifications = false;
  bool _twoFA = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        children: [
          // ── Notifications card
          BuildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 22,
                      color: AppColors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ToggleRow(
                  title: 'Order Updates',
                  subtitle: 'Receive alerts regarding this category.',
                  value: _orderUpdates,
                  onChanged: (v) => setState(() => _orderUpdates = v),
                ),
                const BuildDivider(),
                ToggleRow(
                  title: 'Promotions',
                  subtitle: 'Receive alerts regarding this category.',
                  value: _promotions,
                  onChanged: (v) => setState(() => _promotions = v),
                ),
                const BuildDivider(),
                ToggleRow(
                  title: 'Security Alerts',
                  subtitle: 'Receive alerts regarding this category.',
                  value: _securityAlerts,
                  onChanged: (v) => setState(() => _securityAlerts = v),
                ),
                const BuildDivider(),
                ToggleRow(
                  title: 'Sms Notifications',
                  subtitle: 'Receive alerts regarding this category.',
                  value: _smsNotifications,
                  onChanged: (v) => setState(() => _smsNotifications = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Security card
          BuildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 22,
                      color: AppColors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ToggleRow(
                  title: 'Two-Factor Authentication',
                  subtitle: 'Secure your account with 2FA.',
                  value: _twoFA,
                  onChanged: (v) => setState(() => _twoFA = v),
                ),
                const BuildDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Last changed 3 months ago',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    ActionButton(label: 'Update', onTap: () {}, compact: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
