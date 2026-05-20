import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/bloc/profile_event.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/bloc/profile_state.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/widgets/profile_info_tile.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/widgets/change_password_bottom_sheet.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;

class ProfilePage extends StatefulWidget {
  final AuthEntity user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthEntity _currentUser;
  bool _isEditingName = false;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _nameController.text = _currentUser.name ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitProfileUpdate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            UpdateProfileRequested(
              name: _nameController.text.trim(),
            ),
          );
    }
  }

  void _showChangePasswordBottomSheet(BuildContext pageContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider<ProfileBloc>.value(
          value: BlocProvider.of<ProfileBloc>(pageContext),
          child: const ChangePasswordBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isCustomer = _currentUser.role?.toLowerCase() == 'customer';
    final bool canPop = Navigator.of(context).canPop();

    return BlocProvider<ProfileBloc>(
      create: (context) => di.sl<ProfileBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ),
                );
              } else {
                // Ẩn Loading dialog nếu đang hiển thị
                if (ModalRoute.of(context)?.isCurrent == false) {
                  final isLoaderShowing = Navigator.of(context).canPop();
                  if (isLoaderShowing) {
                    Navigator.pop(context);
                  }
                }
              }

              if (state is ProfileUpdateSuccess) {
                setState(() {
                  // Cập nhật local state với thông tin mới
                  _currentUser = AuthEntity(
                    id: state.user.id,
                    email: state.user.email,
                    name: state.user.name,
                    photoUrl: state.user.photoUrl,
                    role: state.user.role,
                  );
                  _isEditingName = false;
                });
                // Đồng bộ hóa trạng thái tài khoản toàn cục ở AuthBloc
                context.read<AuthBloc>().add(AuthCheckRequested());
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cập nhật hồ sơ thành công!'),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              } else if (state is ChangePasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đổi mật khẩu thành công!'),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lỗi: ${state.message}'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  'Hồ Sơ Của Tôi',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.primaryColor),
                leading: (isCustomer || canPop)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1.0),
                  child: Divider(height: 1, color: AppColors.primaryColor),
                ),
              ),
              drawer: (!isCustomer && !canPop)
                  ? ManagementDrawer(
                      user: _currentUser,
                      isAdmin: _currentUser.role?.toLowerCase() == 'admin',
                      onLogout: () {
                        context.read<AuthBloc>().add(LogoutRequested());
                      },
                    )
                  : null,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // Avatar Section
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  blurRadius: 16,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 54,
                              backgroundColor: AppColors.primaryColor.withOpacity(0.08),
                              child: Text(
                                _currentUser.name?.isNotEmpty == true
                                    ? _currentUser.name![0].toUpperCase()
                                    : 'U',
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _currentUser.role?.toUpperCase() ?? 'CUSTOMER',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Account Details Card
                    Form(
                      key: _formKey,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey[200]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Thông tin tài khoản',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const Divider(height: 24),
                              
                              // Email (Chỉ đọc)
                              ProfileInfoTile(
                                icon: Icons.email_outlined,
                                label: 'Email tài khoản',
                                value: _currentUser.email ?? 'Không có email',
                                isEditable: false,
                              ),
                              const SizedBox(height: 20),

                              // Tên hiển thị (Có thể sửa trực tiếp)
                              _isEditingName
                                  ? TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Họ và tên',
                                        prefixIcon: const Icon(Icons.person_outline),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.close, color: Colors.redAccent),
                                              onPressed: () {
                                                setState(() {
                                                  _isEditingName = false;
                                                  _nameController.text = _currentUser.name ?? '';
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.check, color: AppColors.primaryColor),
                                              onPressed: () => _submitProfileUpdate(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Họ tên không được để trống';
                                        }
                                        return null;
                                      },
                                    )
                                  : ProfileInfoTile(
                                      icon: Icons.person_outline,
                                      label: 'Họ và tên',
                                      value: _currentUser.name ?? 'Chưa cập nhật',
                                      isEditable: true,
                                      onEditTap: () {
                                        setState(() {
                                          _isEditingName = true;
                                        });
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Security & Settings Options
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: [
                          ListTile(
                            leading: const Icon(Icons.lock_outline, color: AppColors.primaryColor),
                            title: const Text(
                              'Đổi mật khẩu tài khoản',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                            onTap: () => _showChangePasswordBottomSheet(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
