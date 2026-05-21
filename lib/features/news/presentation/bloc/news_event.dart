import 'package:equatable/equatable.dart';
import '../../domain/entities/news_entity.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

/// Tải danh sách tất cả tin tức.
class LoadNewsListEvent extends NewsEvent {}

/// Tìm kiếm tin tức theo từ khóa.
class SearchNewsEvent extends NewsEvent {
  final String query;
  const SearchNewsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Lọc tin tức theo danh mục và/hoặc trạng thái.
class FilterNewsEvent extends NewsEvent {
  final String? category;
  final bool? isPublished;
  const FilterNewsEvent({this.category, this.isPublished});

  @override
  List<Object?> get props => [category, isPublished];
}

/// Tạo tin tức mới.
class CreateNewsEvent extends NewsEvent {
  final NewsEntity news;
  const CreateNewsEvent(this.news);

  @override
  List<Object?> get props => [news];
}

/// Cập nhật tin tức.
class UpdateNewsEvent extends NewsEvent {
  final NewsEntity news;
  const UpdateNewsEvent(this.news);

  @override
  List<Object?> get props => [news];
}

/// Xóa tin tức.
class DeleteNewsEvent extends NewsEvent {
  final String id;
  const DeleteNewsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
