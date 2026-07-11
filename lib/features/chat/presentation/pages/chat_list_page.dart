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
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_card.dart';
import 'chat_page.dart';

class ChatListPage extends StatefulWidget {
  final AuthEntity user;
  const ChatListPage({super.key, required this.user});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final TextEditingController _searchController = TextEditingController();
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
      create: (context) => di.sl<ChatBloc>()..add(LoadChatsEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Chat Hỗ trợ Khách hàng',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
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
                        context.read<ChatBloc>().add(LoadChatsEvent());
                      } else {
                        context
                            .read<ChatBloc>()
                            .add(SearchChatsEvent(value));
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm theo tên khách hàng...',
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<ChatBloc>()
                                  .add(LoadChatsEvent());
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
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor),
                );
              }

              if (state is ChatError) {
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
                            .read<ChatBloc>()
                            .add(LoadChatsEvent()),
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

              if (state is ChatsLoaded) {
                final chats = state.chats;

                if (chats.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Chưa có hộp thoại nào',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    context.read<ChatBloc>().add(LoadChatsEvent());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: chats.length,
                    itemBuilder: (ctx, index) {
                      final chat = chats[index];
                      return ChatCard(
                        chat: chat,
                        onTap: () {
                          final chatBloc = context.read<ChatBloc>();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                user: widget.user,
                                chatId: chat.id,
                                chatTitle: chat.customerName,
                              ),
                            ),
                          ).then((_) {
                            if (mounted) {
                              chatBloc.add(LoadChatsEvent());
                            }
                          });
                        },
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
}
