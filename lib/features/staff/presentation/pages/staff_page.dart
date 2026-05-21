import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/entities/staff_entity.dart';
import 'package:prm393_biopestcontrol/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:prm393_biopestcontrol/features/staff/presentation/bloc/staff_event.dart';
import 'package:prm393_biopestcontrol/features/staff/presentation/bloc/staff_state.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'staff_form_page.dart';
import '../widgets/staff_card.dart';

class StaffPage extends StatefulWidget {
  final AuthEntity user;
  const StaffPage({super.key, required this.user});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<StaffBloc>()..add(LoadStaffsEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Staff Management'),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryColor,
              elevation: 0,
            ),
            drawer: ManagementDrawer(
              user: widget.user,
              isAdmin: widget.user.role == 'admin',
              onLogout: () {
                context.read<AuthBloc>().add(LogoutRequested());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search staff by name or email...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (query) {
                      context.read<StaffBloc>().add(SearchStaffsEvent(query));
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocConsumer<StaffBloc, StaffState>(
                      listener: (context, state) {
                        if (state is StaffActionSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                          );
                        }
                        if (state is StaffError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is StaffLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is StaffLoaded) {
                          if (state.staffs.isEmpty) {
                            return const Center(child: Text('No staff members found.'));
                          }
                          return ListView.builder(
                            itemCount: state.staffs.length,
                            itemBuilder: (context, index) {
                              final staff = state.staffs[index];
                              return StaffCard(
                                staff: staff,
                                onEdit: () => _navigateToForm(context, staff: staff),
                                onDelete: () => _showDeleteDialog(context, staff),
                              );
                            },
                          );
                        }
                        return const Center(child: Text('Start managing your team!'));
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _navigateToForm(context),
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        }
      ),
    );
  }

  void _navigateToForm(BuildContext context, {StaffEntity? staff}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StaffFormPage(staff: staff),
      ),
    );

    if (result != null && mounted) {
      if (staff == null) {
        context.read<StaffBloc>().add(AddStaffEvent(result as StaffEntity));
      } else {
        context.read<StaffBloc>().add(UpdateStaffEvent(result as StaffEntity));
      }
    }
  }

  void _showDeleteDialog(BuildContext context, StaffEntity staff) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Staff'),
        content: Text('Are you sure you want to delete ${staff.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<StaffBloc>().add(DeleteStaffEvent(staff.id));
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
