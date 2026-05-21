import 'package:equatable/equatable.dart';
import '../../domain/entities/news_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái khởi tạo.
class NewsInitial extends NewsState {}

/// Đang tải dữ liệu.
class NewsLoading extends NewsState {}

/// Tải danh sách tin tức thành công.
class NewsLoaded extends NewsState {
  final List<NewsEntity> newsList;
  const NewsLoaded(this.newsList);

  @override
  List<Object?> get props => [newsList];
}

/// Thao tác (tạo/sửa/xóa) thành công.
class NewsActionSuccess extends NewsState {
  final String message;
  const NewsActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Lỗi xảy ra.
class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
