import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import '../widgets/customer_card.dart';
import 'customer_detail_page.dart';
import 'customer_form_page.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/app/app.dart';

/// [CustomerManagementPage] là giao diện chính để Admin/Staff quản lý khách hàng.
/// Tích hợp các tính năng: Xem danh sách, Tìm kiếm, Lọc và Điều hướng.
class CustomerManagementPage extends StatefulWidget {
  final AuthEntity user;
  const CustomerManagementPage({super.key, required this.user});

  @override
  State<CustomerManagementPage> createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isLockedFilter;

  @override
  Widget build(BuildContext context) {
    // Sử dụng BlocProvider để cung cấp CustomerBloc cho toàn bộ trang
    return BlocProvider(
      create: (context) => di.sl<CustomerBloc>()..add(LoadCustomers()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Customer Management'),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryColor,
              elevation: 0,
              actions: [
                PopupMenuButton<bool?>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) {
                    setState(() {
                      _isLockedFilter = value;
                    });
                    context.read<CustomerBloc>().add(FilterCustomers(isLocked: value));
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: null, child: Text('All')),
                    const PopupMenuItem(value: false, child: Text('Active')),
                    const PopupMenuItem(value: true, child: Text('Locked')),
                  ],
                ),
              ],
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
                      hintText: 'Search customers...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      suffixIcon: _searchController.text.isNotEmpty 
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context.read<CustomerBloc>().add(LoadCustomers());
                            },
                          )
                        : null,
                    ),
                    onChanged: (query) {
                      context.read<CustomerBloc>().add(SearchCustomers(query));
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocConsumer<CustomerBloc, CustomerState>(
                      listener: (context, state) {
                        if (state is CustomerOperationSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                          );
                        }
                        if (state is CustomerError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CustomerLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is CustomersLoaded) {
                          if (state.customers.isEmpty) {
                            return const Center(child: Text('No customers found.'));
                          }
                          return ListView.builder(
                            itemCount: state.customers.length,
                            itemBuilder: (context, index) {
                              final customer = state.customers[index];
                              return CustomerCard(
                                customer: customer,
                                onTap: () => _navigateToDetail(context, customer),
                                onEdit: () => _navigateToForm(context, customer: customer),
                                onToggleLock: (isLocked) {
                                  context.read<CustomerBloc>().add(ToggleCustomerLock(customer.id, isLocked));
                                },
                              );
                            },
                          );
                        }
                        return const Center(child: Text('Load customers to start.'));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void _navigateToDetail(BuildContext context, CustomerEntity customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerDetailPage(customerId: customer.id),
      ),
    ).then((_) {
      if (mounted) {
         context.read<CustomerBloc>().add(LoadCustomers());
      }
    });
  }

  void _navigateToForm(BuildContext context, {CustomerEntity? customer}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerFormPage(customer: customer),
      ),
    );

    if (result != null && mounted) {
      context.read<CustomerBloc>().add(UpdateCustomer(result as CustomerEntity));
    }
  }
}
