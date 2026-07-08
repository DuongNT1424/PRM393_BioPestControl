import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import '../bloc/chemical_bloc.dart';
import '../bloc/chemical_event.dart';
import '../bloc/chemical_state.dart';
import '../widgets/chemical_card.dart';
import '../widgets/chemical_filter_dialog.dart';
import 'chemical_detail_page.dart';

class CustomerChemicalPage extends StatefulWidget {
  const CustomerChemicalPage({super.key});

  @override
  State<CustomerChemicalPage> createState() => _CustomerChemicalPageState();
}

class _CustomerChemicalPageState extends State<CustomerChemicalPage> {
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
    return BlocProvider(
      create: (_) => di.sl<ChemicalBloc>()..add(LoadChemicalsEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            title: const Text(
              'Tra cứu An toàn Hóa chất',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce =
                        Timer(const Duration(milliseconds: 500), () {
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
                    hintText: 'Tìm theo tên hoặc mã CAS...',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
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
          body: BlocBuilder<ChemicalBloc, ChemicalState>(
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
                      const Icon(Icons.wifi_off,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('Không thể tải dữ liệu hóa chất',
                          style: TextStyle(color: Colors.grey)),
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
                          'Chưa có dữ liệu hóa chất nào',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 16),
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ChemicalDetailPage(chemical: chemical),
                          ),
                        ),
                        onEdit: null,
                        onDelete: null,
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
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
