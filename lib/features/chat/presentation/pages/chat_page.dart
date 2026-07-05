import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class MessageModel {
  final String sender; // 'user' or 'support'
  final String text;
  final DateTime time;

  MessageModel({
    required this.sender,
    required this.text,
    required this.time,
  });
}

class ChatPage extends StatefulWidget {
  final AuthEntity user;
  final String? productName;

  const ChatPage({
    super.key,
    required this.user,
    this.productName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<MessageModel> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeWelcomeMessage();
  }

  void _initializeWelcomeMessage() {
    final String greetingText;
    if (widget.productName != null) {
      greetingText =
          'Chào ${widget.user.name ?? 'bạn'}, mình là trợ lý kỹ thuật của BioPest Control. Mình có thể hỗ trợ giải đáp thắc mắc gì cho bạn về sản phẩm "${widget.productName}" không ạ?';
    } else {
      greetingText =
          'Chào ${widget.user.name ?? 'bạn'}, cảm ơn bạn đã liên hệ BioPest Control. Bạn cần tư vấn về kỹ thuật nuôi trồng, sâu bệnh hay thông tin đơn hàng nào không ạ?';
    }

    _messages.add(MessageModel(
      sender: 'support',
      text: greetingText,
      time: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
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

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(MessageModel(
        sender: 'user',
        text: text,
        time: DateTime.now(),
      ));
      _controller.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulated response delay
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      if (!mounted) return;

      String replyText = '';
      final lowerText = text.toLowerCase();

      if (lowerText.contains('giá') || lowerText.contains('bao nhiêu') || lowerText.contains('tiền')) {
        replyText =
            'Dạ, các sản phẩm sinh học của BioPest luôn được niêm yết giá công khai cực kỳ cạnh tranh trên chợ ứng dụng ạ. Đặc biệt, bạn có thể áp dụng thêm mã giảm giá ở tab Đơn hàng để nhận giá ưu đãi tốt nhất!';
      } else if (lowerText.contains('ship') || lowerText.contains('giao') || lowerText.contains('vận chuyển')) {
        replyText =
            'Dạ, BioPest hỗ trợ ship COD nhanh toàn quốc. Khu vực Tiền Giang và các tỉnh lân cận miền Tây thường nhận hàng sau 1-2 ngày, các tỉnh khác từ 2-4 ngày làm việc ạ!';
      } else if (lowerText.contains('bệnh') || lowerText.contains('sâu') || lowerText.contains('rầy') || lowerText.contains('cây')) {
        replyText =
            'Đối với tình trạng sâu bệnh, bạn vui lòng chụp ảnh thực tế cây bị tổn hại và gửi cho chuyên gia qua tab "CHUYÊN GIA" ở màn hình chính nhé. Chuyên gia sẽ chẩn đoán và kê đơn thuốc sinh học phù hợp nhất cho vườn của bạn.';
      } else {
        replyText =
            'Cảm ơn bạn đã phản hồi. Trợ lý kỹ thuật BioPest đã ghi nhận thắc mắc và sẽ chuyển thông tin đến kỹ sư phụ trách khu vực của bạn để liên hệ hỗ trợ trực tiếp sớm nhất!';
      }

      setState(() {
        _messages.add(MessageModel(
          sender: 'support',
          text: replyText,
          time: DateTime.now(),
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.support_agent,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hỗ trợ BioPest',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message.sender == 'user';
                return _buildMessageBubble(message, isMe);
              },
            ),
          ),
          if (_isTyping) _buildTypingIndicator(),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: isMe ? Colors.white60 : Colors.grey[400],
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Trợ lý đang nhập',
              style: TextStyle(fontSize: 12, color: Colors.grey[500], fontStyle: FontStyle.italic),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor.withValues(alpha: 0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
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
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn tư vấn...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
