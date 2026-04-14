import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.bloc.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.events.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.states.dart';
import 'package:oasis/app/profile/presentation/ui/profile_widgets.dart';
import 'package:oasis/common/common.dart';
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
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const FetchProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(title: 'Profile', textStyle: textStyle),
                const Header(),
                BuildTabBar(
                  selected: _tab,
                  onTap: (i) => setState(() => _tab = i),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _tab,
                    children: [
                      _MyProfileTab(
                        name: state.name,
                        email: state.email,
                        avatar: state.avatar,
                        isLoading: state.status == FetchStatus.loading,
                      ),
                      const AddressesTab(),
                      const SettingsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}


// ─── My Profile Tab ──────────────────────────────────────────────────────────
class _MyProfileTab extends StatefulWidget {
  const _MyProfileTab({
    required this.name,
    required this.email,
    required this.isLoading,
    required this.avatar,
  });

  final String name;
  final String email;
  final String avatar;
  final bool isLoading;

  @override
  State<_MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<_MyProfileTab> {
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  final _phoneController = TextEditingController(text: '+123412341234');

  @override
  void didUpdateWidget(_MyProfileTab old) {
    super.didUpdateWidget(old);
    // Sync controllers when BLoC data arrives
    if (old.name != widget.name) _nameController.text = widget.name;
    if (old.email != widget.email) _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
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
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: AppColors.accent,
                            backgroundImage: widget.avatar.isNotEmpty
                                ? NetworkImage(widget.avatar)
                                : null,
                            child: widget.avatar.isEmpty
                                ? Text(
                                    widget.name.isNotEmpty
                                        ? widget.name[0].toUpperCase()
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
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
}