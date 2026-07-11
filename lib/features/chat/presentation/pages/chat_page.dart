import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../../domain/entities/message.dart';

class ChatPage extends StatefulWidget {
  final AuthEntity user;
  final String? productName;
  final String? chatId;
  final String? chatTitle;

  const ChatPage({
    super.key,
    required this.user,
    this.productName,
    this.chatId,
    this.chatTitle,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  String _searchQuery = '';

  String get _chatId => widget.chatId ?? widget.user.id ?? '';

  bool get _isSupportView =>
      widget.chatId != null && widget.chatId != widget.user.id;

  String get _customerName {
    if (_isSupportView) {
      return widget.chatTitle ?? 'Khách hàng';
    }
    return widget.user.name ?? widget.user.email ?? 'Khách hàng';
  }

  @override
  void initState() {
    super.initState();
    if (widget.productName != null) {
      _controller.text =
          'Tôi cần tư vấn về sản phẩm "${widget.productName}"';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ChatBloc>()..add(LoadMessagesEvent(_chatId)),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFFF9FBF9),
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is MessagesLoaded && _searchQuery.isEmpty) {
                      _scrollToBottom();
                    }
                    if (state is ChatActionFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is ChatLoading ||
                      current is MessagesLoaded ||
                      current is ChatError,
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
                            const Icon(Icons.wifi_off,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(state.message,
                                style:
                                    const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<ChatBloc>()
                                  .add(LoadMessagesEvent(_chatId)),
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

                    if (state is MessagesLoaded) {
                      final messages = _searchQuery.isEmpty
                          ? state.messages
                          : state.messages
                              .where((m) => m.text
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                              .toList();

                      if (messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _searchQuery.isEmpty
                                    ? Icons.chat_bubble_outline
                                    : Icons.search_off,
                                size: 64,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchQuery.isEmpty
                                    ? 'Chưa có tin nhắn nào.\nHãy gửi tin nhắn đầu tiên!'
                                    : 'Không tìm thấy tin nhắn nào',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16.0),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe =
                              message.senderId == widget.user.id;
                          return _buildMessageBubble(
                              context, message, isMe);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              _buildInputArea(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: AppColors.primaryColor),
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm tin nhắn...',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 15),
              onChanged: (value) => setState(() => _searchQuery = value),
            )
          : Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _isSupportView ? Icons.person : Icons.support_agent,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isSupportView
                            ? (widget.chatTitle ?? 'Khách hàng')
                            : 'Hỗ trợ BioPest',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Đang hoạt động',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              if (_isSearching) {
                _isSearching = false;
                _searchController.clear();
                _searchQuery = '';
              } else {
                _isSearching = true;
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildMessageBubble(
      BuildContext context, MessageEntity message, bool isMe) {
    final bool isAdmin = widget.user.role?.toLowerCase() == 'admin';
    final bool canDelete = (isMe || isAdmin) && message.id != null;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress:
            canDelete ? () => _confirmDeleteMessage(context, message) : null,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    message.senderRole == 'customer'
                        ? message.senderName
                        : '${message.senderName} • Hỗ trợ',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 14.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.createdAt != null
                      ? '${message.createdAt!.hour.toString().padLeft(2, '0')}:${message.createdAt!.minute.toString().padLeft(2, '0')}'
                      : 'Đang gửi...',
                  style: TextStyle(
                    color: isMe ? Colors.white60 : Colors.grey[400],
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteMessage(BuildContext context, MessageEntity message) {
    final chatBloc = context.read<ChatBloc>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xóa tin nhắn'),
        content: const Text('Bạn có chắc muốn xóa tin nhắn này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              chatBloc.add(DeleteMessageEvent(
                chatId: _chatId,
                messageId: message.id!,
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatBloc>().add(SendMessageEvent(
          chatId: _chatId,
          customerName: _customerName,
          message: MessageEntity(
            senderId: widget.user.id ?? '',
            senderName: widget.user.name ?? widget.user.email ?? 'Ẩn danh',
            senderRole: widget.user.role?.toLowerCase() ?? 'customer',
            text: text,
          ),
        ));
    _controller.clear();
    _scrollToBottom();
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(context),
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn tư vấn...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: () => _sendMessage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
