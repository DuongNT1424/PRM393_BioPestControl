import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/entities/discount_entity.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import '../bloc/discount_bloc.dart';
import '../bloc/discount_event.dart';
import '../bloc/discount_state.dart';
import '../widgets/discount_card.dart';
import 'discount_form_page.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class DiscountManagementPage extends StatefulWidget {
  final AuthEntity user;
  const DiscountManagementPage({super.key, required this.user});

  @override
  State<DiscountManagementPage> createState() => _DiscountManagementPageState();
}

class _DiscountManagementPageState extends State<DiscountManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<DiscountBloc>()..add(LoadDiscounts()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Discount Management'),
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            drawer: ManagementDrawer(
              user: widget.user,
              isAdmin: widget.user.role == 'admin',
              onLogout: () {
                // Handle logout if needed or let the drawer handle it via state
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search discounts or products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<DiscountBloc>().add(LoadDiscounts());
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      context.read<DiscountBloc>().add(SearchDiscounts(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // List
                  Expanded(
                    child: BlocConsumer<DiscountBloc, DiscountState>(
                      listener: (context, state) {
                        if (state is DiscountOperationSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                          );
                        }
                        if (state is DiscountError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is DiscountLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        
                        if (state is DiscountsLoaded) {
                          if (state.discounts.isEmpty) {
                            return const Center(child: Text('No discounts found.'));
                          }
                          return ListView.builder(
                            itemCount: state.discounts.length,
                            itemBuilder: (context, index) {
                              final discount = state.discounts[index];
                              return DiscountCard(
                                discount: discount,
                                // Chỉ Admin mới có quyền sửa/xóa
                                onEdit: widget.user.role == 'admin' 
                                  ? () => _navigateToForm(context, discount: discount)
                                  : null,
                                onDelete: widget.user.role == 'admin'
                                  ? () => _confirmDelete(context, discount.id!)
                                  : null,
                              );
                            },
                          );
                        }
                        return const Center(child: Text('Press refresh to load data.'));
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Chỉ hiện nút thêm mới nếu là Admin
            floatingActionButton: widget.user.role == 'admin' 
              ? FloatingActionButton(
                  onPressed: () => _navigateToForm(context),
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
          );
        }
      ),
    );
  }

  void _navigateToForm(BuildContext context, {DiscountEntity? discount}) async {
    final discountBloc = context.read<DiscountBloc>();
    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: discountBloc,
          child: DiscountFormPage(discount: discount),
        ),
      ),
    );

    if (result == true && mounted) {
      // Bloc đã tự trigger load lại sau khi success, 
      // nhưng nếu cần xử lý thêm sau khi quay về thì code ở đây.
    }
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (diagContext) => AlertDialog(
        title: const Text('Delete Discount'),
        content: const Text('Are you sure you want to delete this discount?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(diagContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<DiscountBloc>().add(DeleteDiscount(id));
              Navigator.pop(diagContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
