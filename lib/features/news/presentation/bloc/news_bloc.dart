import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_news_list_usecase.dart';
import '../../domain/usecases/search_news_usecase.dart';
import '../../domain/usecases/filter_news_usecase.dart';
import '../../domain/usecases/create_news_usecase.dart';
import '../../domain/usecases/update_news_usecase.dart';
import '../../domain/usecases/delete_news_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import 'news_event.dart';
import 'news_state.dart';

/// [NewsBloc] quản lý trạng thái của tính năng Tin tức/Bài viết.
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsListUseCase getNewsListUseCase;
  final SearchNewsUseCase searchNewsUseCase;
  final FilterNewsUseCase filterNewsUseCase;
  final CreateNewsUseCase createNewsUseCase;
  final UpdateNewsUseCase updateNewsUseCase;
  final DeleteNewsUseCase deleteNewsUseCase;

  NewsBloc({
    required this.getNewsListUseCase,
    required this.searchNewsUseCase,
    required this.filterNewsUseCase,
    required this.createNewsUseCase,
    required this.updateNewsUseCase,
    required this.deleteNewsUseCase,
  }) : super(NewsInitial()) {
    on<LoadNewsListEvent>(_onLoadNewsList);
    on<SearchNewsEvent>(_onSearchNews);
    on<FilterNewsEvent>(_onFilterNews);
    on<CreateNewsEvent>(_onCreateNews);
    on<UpdateNewsEvent>(_onUpdateNews);
    on<DeleteNewsEvent>(_onDeleteNews);
  }

  Future<void> _onLoadNewsList(
      LoadNewsListEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await getNewsListUseCase(NoParams());
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (newsList) => emit(NewsLoaded(newsList)),
    );
  }

  Future<void> _onSearchNews(
      SearchNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await searchNewsUseCase(event.query);
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (newsList) => emit(NewsLoaded(newsList)),
    );
  }

  Future<void> _onFilterNews(
      FilterNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await filterNewsUseCase(FilterNewsParams(
      category: event.category,
      isPublished: event.isPublished,
    ));
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (newsList) => emit(NewsLoaded(newsList)),
    );
  }

  Future<void> _onCreateNews(
      CreateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await createNewsUseCase(event.news);
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (_) {
        emit(const NewsActionSuccess('Tạo tin tức thành công'));
        add(LoadNewsListEvent());
      },
    );
  }

  Future<void> _onUpdateNews(
      UpdateNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await updateNewsUseCase(event.news);
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (_) {
        emit(const NewsActionSuccess('Cập nhật tin tức thành công'));
        add(LoadNewsListEvent());
      },
    );
  }

  Future<void> _onDeleteNews(
      DeleteNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await deleteNewsUseCase(event.id);
    result.fold(
      (failure) => emit(NewsError(failure.message)),
      (_) {
        emit(const NewsActionSuccess('Xóa tin tức thành công'));
        add(LoadNewsListEvent());
      },
    );
  }
}
