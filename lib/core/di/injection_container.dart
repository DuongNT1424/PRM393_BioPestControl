import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prm393_biopestcontrol/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/repositories/auth_repository.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/login_usecase.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/logout_usecase.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/register_usecase.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:prm393_biopestcontrol/features/statistics/domain/usecases/get_statistics_usecase.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:prm393_biopestcontrol/core/database/database_helper.dart';
import 'package:prm393_biopestcontrol/features/statistics/data/datasources/statistics_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/product/domain/repositories/product_repository.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/get_products_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/get_product_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/search_products_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/filter_products_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/add_product_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/update_product_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/data/repositories/product_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/product/data/datasources/product_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_bloc.dart';
import 'package:prm393_biopestcontrol/features/category/domain/repositories/category_repository.dart';
import 'package:prm393_biopestcontrol/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:prm393_biopestcontrol/features/category/domain/usecases/add_category_usecase.dart';
import 'package:prm393_biopestcontrol/features/category/domain/usecases/update_category_usecase.dart';
import 'package:prm393_biopestcontrol/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:prm393_biopestcontrol/features/category/data/repositories/category_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/category/data/datasources/category_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_bloc.dart';

import 'package:prm393_biopestcontrol/features/warehouse/domain/repositories/warehouse_repository.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/get_warehouses_usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/search_warehouse_inventory_usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/data/repositories/warehouse_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/warehouse/data/datasources/warehouse_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/bloc/warehouse_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      loginWithGoogleUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  // Features - Statistics
  sl.registerFactory(() => StatisticsBloc(getStatisticsUseCase: sl()));
  sl.registerFactory(() => ProductBloc(
        getProductsUseCase: sl(),
        getProductUseCase: sl(),
        searchProductsUseCase: sl(),
        filterProductsUseCase: sl(),
        addProductUseCase: sl(),
        updateProductUseCase: sl(),
        deleteProductUseCase: sl(),
      ));
  sl.registerFactory<CategoryBloc>(() => CategoryBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => WarehouseBloc(
        getWarehousesUseCase: sl(),
        searchInventoryUseCase: sl(),
        importProductUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetStatisticsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => FilterProductsUseCase(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetWarehousesUseCase(sl()));
  sl.registerLazySingleton(() => SearchWarehouseInventoryUseCase(sl()));
  sl.registerLazySingleton(() => ImportProductUseCase(sl()));

  sl.registerLazySingleton<StatisticsRepository>(
    () => StatisticsRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<WarehouseRepository>(
    () => WarehouseRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSourceImpl(dbHelper: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(dbHelper: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(dbHelper: sl()),
  );
  sl.registerLazySingleton<WarehouseLocalDataSource>(
    () => WarehouseLocalDataSourceImpl(dbHelper: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => DatabaseHelper.instance);
}
