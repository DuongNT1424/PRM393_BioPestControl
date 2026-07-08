import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import '../bloc/chemical_bloc.dart';
import '../bloc/chemical_event.dart';
import '../bloc/chemical_state.dart';
import '../widgets/chemical_card.dart';
import '../widgets/chemical_filter_dialog.dart';
import '../../domain/entities/chemical_entity.dart';
import 'chemical_detail_page.dart';
import 'chemical_form_page.dart';

class ChemicalPage extends StatefulWidget {
  final AuthEntity user;
  const ChemicalPage({super.key, required this.user});

  @override
  State<ChemicalPage> createState() => _ChemicalPageState();
}

class _ChemicalPageState extends State<ChemicalPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedSignalWord;
  bool? _selectedIsBanned;
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.user.role?.toLowerCase() == 'admin';

    return BlocProvider(
      create: (context) => di.sl<ChemicalBloc>()..add(LoadChemicalsEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Quản lý An toàn Hóa chất',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
                tooltip: 'Lọc hóa chất',
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      if (value.isEmpty) {
                        context
                            .read<ChemicalBloc>()
                            .add(LoadChemicalsEvent());
                      } else {
                        context
                            .read<ChemicalBloc>()
                            .add(SearchChemicalsEvent(value));
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm hóa chất...',
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<ChemicalBloc>()
                                  .add(LoadChemicalsEvent());
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
          ),
          drawer: ManagementDrawer(
            user: widget.user,
            isAdmin: isAdmin,
            onLogout: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
                (route) => false,
              );
            },
          ),
          body: BlocConsumer<ChemicalBloc, ChemicalState>(
            listener: (context, state) {
              if (state is ChemicalActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ChemicalLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor),
                );
              }

              if (state is ChemicalError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<ChemicalBloc>()
                            .add(LoadChemicalsEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Thử lại',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              if (state is ChemicalLoaded) {
                final chemicals = state.chemicals;

                if (chemicals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.science_outlined,
                            size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Không tìm thấy hóa chất nào',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _selectedSignalWord = null;
                              _selectedIsBanned = null;
                            });
                            context
                                .read<ChemicalBloc>()
                                .add(LoadChemicalsEvent());
                          },
                          child: const Text('Đặt lại bộ lọc'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    context.read<ChemicalBloc>().add(LoadChemicalsEvent());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: chemicals.length,
                    itemBuilder: (ctx, index) {
                      final chemical = chemicals[index];
                      return ChemicalCard(
                        chemical: chemical,
                        onTap: () => _navigateToDetail(
                            context, chemical, isAdmin),
                        onEdit: isAdmin
                            ? () =>
                                _navigateToForm(context, chemical: chemical)
                            : null,
                        onDelete: isAdmin
                            ? () => _confirmDelete(context, chemical)
                            : null,
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          floatingActionButton: isAdmin
              ? FloatingActionButton.extended(
                  onPressed: () => _navigateToForm(context),
                  backgroundColor: AppColors.primaryColor,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Thêm hóa chất',
                      style: TextStyle(color: Colors.white)),
                )
              : null,
        ),
      ),
    );
  }

  void _navigateToDetail(
      BuildContext context, ChemicalEntity chemical, bool isAdmin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChemicalDetailPage(
          chemical: chemical,
          onEdit: isAdmin
              ? () => _navigateToForm(context, chemical: chemical)
              : null,
          onDelete:
              isAdmin ? () => _confirmDelete(context, chemical) : null,
        ),
      ),
    );
  }

  void _navigateToForm(BuildContext context, {ChemicalEntity? chemical}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChemicalFormPage(
          chemical: chemical,
          user: widget.user,
          onSave: (c) {
            if (chemical == null) {
              context.read<ChemicalBloc>().add(CreateChemicalEvent(c));
            } else {
              context.read<ChemicalBloc>().add(UpdateChemicalEvent(c));
            }
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, ChemicalEntity chemical) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xác nhận xóa'),
        content: Text(
            'Bạn có chắc muốn xóa hóa chất "${chemical.commonName}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<ChemicalBloc>()
                  .add(DeleteChemicalEvent(chemical.id!));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final chemicalBloc = context.read<ChemicalBloc>();
    showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => ChemicalFilterDialog(
        initialSignalWord: _selectedSignalWord,
        initialIsBanned: _selectedIsBanned,
      ),
    ).then((result) {
      if (result != null) {
        setState(() {
          _selectedSignalWord = result['signalWord'];
          _selectedIsBanned = result['isBanned'];
        });
        if (_selectedSignalWord == null && _selectedIsBanned == null) {
          chemicalBloc.add(LoadChemicalsEvent());
        } else {
          chemicalBloc.add(FilterChemicalsEvent(
            signalWord: _selectedSignalWord,
            isBanned: _selectedIsBanned,
          ));
        }
      }
    });
  }
}
