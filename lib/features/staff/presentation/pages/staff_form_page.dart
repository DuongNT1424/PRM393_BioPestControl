import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/staff_entity.dart';
import '../../../../app/theme/app_colors.dart';
import '../widgets/staff_form_widgets.dart';
import '../bloc/staff_bloc.dart';
import '../bloc/staff_event.dart';
import '../bloc/staff_state.dart';

class StaffFormPage extends StatefulWidget {
  final StaffEntity? staff;
  const StaffFormPage({super.key, this.staff});

  @override
  State<StaffFormPage> createState() => _StaffFormPageState();
}

class _StaffFormPageState extends State<StaffFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String _selectedRole = 'staff';
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staff?.name ?? '');
    _emailController = TextEditingController(text: widget.staff?.email ?? '');
    _passwordController = TextEditingController();
    _selectedRole = widget.staff?.role ?? 'staff';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.staff != null;

    return BlocListener<StaffBloc, StaffState>(
      listener: (context, state) {
        if (state is StaffActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
          );
        } else if (state is StaffError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(isEditing ? 'Chỉnh sửa nhân viên' : 'Thêm nhân viên mới',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StaffFieldLabel('Họ và tên *'),
                StaffInputField(
                  controller: _nameController,
                  hintText: 'Nhập họ và tên nhân viên',
                  icon: Icons.person_outline,
                  validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập họ tên' : null,
                ),
                const SizedBox(height: 20),
                const StaffFieldLabel('Địa chỉ Email *'),
                StaffInputField(
                  controller: _emailController,
                  readOnly: isEditing,
                  hintText: 'Nhập địa chỉ email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: isEditing ? const Icon(Icons.lock_outline, size: 18) : null,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) return 'Email không hợp lệ';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const StaffFieldLabel('Mật khẩu'),
                StaffInputField(
                  controller: _passwordController,
                  hintText: isEditing ? 'Để trống nếu không muốn đổi' : 'Tối thiểu 6 ký tự',
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) {
                    if (!isEditing && (v == null || v.isEmpty)) return 'Vui lòng nhập mật khẩu';
                    if (v != null && v.isNotEmpty && v.length < 6) return 'Mật khẩu tối thiểu 6 ký tự';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const StaffFieldLabel('Vai trò'),
                _buildRoleDropdown(),
                const SizedBox(height: 20),
                if (isEditing)
                  BlocBuilder<StaffBloc, StaffState>(
                    builder: (context, state) {
                      return StaffResetPasswordSection(
                        isLoading: state is StaffLoading,
                        onReset: () => _sendPasswordReset(context),
                      );
                    },
                  ),
                const SizedBox(height: 40),
                _buildSubmitButton(isEditing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedRole,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.primaryColor),
      ),
      items: const [
        DropdownMenuItem(value: 'staff', child: Text('Staff')),
        DropdownMenuItem(value: 'admin', child: Text('Admin')),
      ],
      onChanged: (v) { if (v != null) setState(() => _selectedRole = v); },
    );
  }

  Widget _buildSubmitButton(bool isEditing) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: _submitForm,
        icon: Icon(isEditing ? Icons.save : Icons.person_add, color: Colors.white),
        label: Text(isEditing ? 'Lưu thay đổi' : 'Tạo tài khoản nhân viên',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, StaffEntity(
        id: widget.staff?.id ?? '',
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
        role: _selectedRole,
        createdAt: widget.staff?.createdAt,
      ));
    }
  }

  void _sendPasswordReset(BuildContext context) {
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      context.read<StaffBloc>().add(SendPasswordResetEvent(email));
    }
  }
}
