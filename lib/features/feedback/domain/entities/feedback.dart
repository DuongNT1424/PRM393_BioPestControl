class FeedbackEntity {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String title;
  final String content;
  final int rating;
  final String status; // 'pending' or 'replied'
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? replyContent;
  final String? replyAuthorId;
  final String? replyAuthorName;
  final DateTime? repliedAt;
  final DateTime? replyUpdatedAt;
  final int? productId;
  final String? productName;

  const FeedbackEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.title,
    required this.content,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.replyContent,
    this.replyAuthorId,
    this.replyAuthorName,
    this.repliedAt,
    this.replyUpdatedAt,
    this.productId,
    this.productName,
  });

  FeedbackEntity copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? title,
    String? content,
    int? rating,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? replyContent,
    String? replyAuthorId,
    String? replyAuthorName,
    DateTime? repliedAt,
    DateTime? replyUpdatedAt,
    int? productId,
    String? productName,
  }) {
    return FeedbackEntity(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      title: title ?? this.title,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      replyContent: replyContent ?? this.replyContent,
      replyAuthorId: replyAuthorId ?? this.replyAuthorId,
      replyAuthorName: replyAuthorName ?? this.replyAuthorName,
      repliedAt: repliedAt ?? this.repliedAt,
      replyUpdatedAt: replyUpdatedAt ?? this.replyUpdatedAt,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
    );
  }
}
