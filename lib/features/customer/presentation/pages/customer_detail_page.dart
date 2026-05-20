import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer_entity.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import 'customer_form_page.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:intl/intl.dart';

class CustomerDetailPage extends StatelessWidget {
  final String customerId;
  const CustomerDetailPage({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CustomerBloc>()..add(GetCustomerDetail(customerId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer Details'),
          actions: [
            BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
                if (state is CustomerDetailLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _navigateToEdit(context, state.customer),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocListener<CustomerBloc, CustomerState>(
          listener: (context, state) {
            if (state is CustomerOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
              context.read<CustomerBloc>().add(GetCustomerDetail(customerId));
            }
            if (state is CustomerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          child: BlocBuilder<CustomerBloc, CustomerState>(
            buildWhen: (previous, current) =>
                current is CustomerLoading ||
                current is CustomerDetailLoaded ||
                current is CustomerError,
            builder: (context, state) {
              if (state is CustomerLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CustomerDetailLoaded) {
                final customer = state.customer;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                          child: Text(
                            customer.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(fontSize: 40, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoTile(Icons.person, 'Full Name', customer.name),
                      _buildInfoTile(Icons.email, 'Email Address', customer.email),
                      _buildInfoTile(Icons.phone, 'Phone Number', customer.phone ?? 'Not provided'),
                      _buildInfoTile(Icons.location_on, 'Address', customer.address ?? 'Not provided'),
                      _buildInfoTile(
                        customer.isLocked ? Icons.lock : Icons.lock_open,
                        'Account Status',
                        customer.isLocked ? 'Locked' : 'Active',
                        valueColor: customer.isLocked ? Colors.red : Colors.green,
                      ),
                      if (customer.createdAt != null)
                        _buildInfoTile(
                          Icons.calendar_today,
                          'Member Since',
                          DateFormat('dd/MM/yyyy HH:mm').format(customer.createdAt!),
                        ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<CustomerBloc>().add(ToggleCustomerLock(customer.id, !customer.isLocked));
                          },
                          icon: Icon(customer.isLocked ? Icons.lock_open : Icons.lock),
                          label: Text(customer.isLocked ? 'Unlock Customer' : 'Lock Customer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customer.isLocked ? Colors.green : Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CustomerError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(BuildContext context, CustomerEntity customer) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomerFormPage(customer: customer),
      ),
    );

    if (result != null) {
      context.read<CustomerBloc>().add(UpdateCustomer(result as CustomerEntity));
    }
  }
}
