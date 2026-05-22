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
import 'package:prm393_biopestcontrol/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:prm393_biopestcontrol/features/profile/domain/repositories/profile_repository.dart';
import 'package:prm393_biopestcontrol/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:prm393_biopestcontrol/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:prm393_biopestcontrol/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/bloc/profile_bloc.dart';
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

import 'package:prm393_biopestcontrol/features/staff/domain/repositories/staff_repository.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/add_staff_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/update_staff_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/delete_staff_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/search_staffs_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/domain/usecases/send_password_reset_usecase.dart';
import 'package:prm393_biopestcontrol/features/staff/data/repositories/staff_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/staff/data/datasources/staff_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/staff/presentation/bloc/staff_bloc.dart';

import 'package:prm393_biopestcontrol/features/customer/domain/repositories/customer_repository.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/get_customers_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/get_customer_detail_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/update_customer_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/lock_customer_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/unlock_customer_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/search_customers_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/filter_customers_usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/customer/data/datasources/customer_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/customer/presentation/bloc/customer_bloc.dart';

import 'package:prm393_biopestcontrol/features/discount/domain/repositories/discount_repository.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/get_discounts_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/add_discount_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/update_discount_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/delete_discount_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/search_discounts_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/usecases/filter_discounts_usecase.dart';
import 'package:prm393_biopestcontrol/features/discount/data/repositories/discount_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/discount/data/datasources/discount_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/discount/presentation/bloc/discount_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:prm393_biopestcontrol/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/cart/data/datasources/cart_local_data_source.dart';

import 'package:prm393_biopestcontrol/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/repositories/notification_repository.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/usecases/get_notifications.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/usecases/mark_as_read_usecase.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/usecases/mark_all_as_read_usecase.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/usecases/delete_notification_usecase.dart';
import 'package:prm393_biopestcontrol/features/notification/domain/usecases/send_notification_usecase.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/bloc/notification_bloc.dart';

// Features - Order
import 'package:prm393_biopestcontrol/features/order/data/datasources/order_remote_data_source.dart';
import 'package:prm393_biopestcontrol/features/order/data/repositories/order_repository_impl.dart';
import 'package:prm393_biopestcontrol/features/order/domain/repositories/order_repository.dart';
import 'package:prm393_biopestcontrol/features/order/domain/usecases/create_order.dart';
import 'package:prm393_biopestcontrol/features/order/domain/usecases/get_orders.dart';
import 'package:prm393_biopestcontrol/features/order/domain/usecases/get_order_detail.dart';
import 'package:prm393_biopestcontrol/features/order/domain/usecases/update_order_status.dart';
import 'package:prm393_biopestcontrol/features/order/presentation/bloc/order_bloc.dart';

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
      forgotPasswordUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ProfileBloc(
      updateProfileUseCase: sl(),
      changePasswordUseCase: sl(),
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
  sl.registerFactory(() => StaffBloc(
        getStaffsUseCase: sl(),
        addStaffUseCase: sl(),
        updateStaffUseCase: sl(),
        deleteStaffUseCase: sl(),
        searchStaffsUseCase: sl(),
        sendPasswordResetUseCase: sl(),
      ));

  // --- Tính năng: Quản lý khách hàng (Customer Management) ---
  sl.registerFactory<CustomerBloc>(() => CustomerBloc(
        getCustomersUseCase: sl(),
        getCustomerDetailUseCase: sl(),
        updateCustomerUseCase: sl(),
        lockCustomerUseCase: sl(),
        unlockCustomerUseCase: sl(),
        searchCustomersUseCase: sl(),
        filterCustomersUseCase: sl(),
      ));
  sl.registerFactory(() => DiscountBloc(
        getDiscountsUseCase: sl(),
        addDiscountUseCase: sl(),
        updateDiscountUseCase: sl(),
        deleteDiscountUseCase: sl(),
        searchDiscountsUseCase: sl(),
        filterDiscountsUseCase: sl(),
      ));

  sl.registerFactory(() => CartBloc(
        getCartUseCase: sl(),
        addToCartUseCase: sl(),
        removeFromCartUseCase: sl(),
        updateCartQuantityUseCase: sl(),
        clearCartUseCase: sl(),
      ));

  sl.registerFactory(() => NotificationBloc(
        getNotificationsUseCase: sl(),
        markAsReadUseCase: sl(),
        markAllAsReadUseCase: sl(),
        deleteNotificationUseCase: sl(),
        sendNotificationUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetStatisticsUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => MarkAsReadUseCase(sl()));
  sl.registerLazySingleton(() => MarkAllAsReadUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNotificationUseCase(sl()));
  sl.registerLazySingleton(() => SendNotificationUseCase(sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));

  // News Use Cases
  sl.registerLazySingleton(() => GetNewsListUseCase(sl()));
  sl.registerLazySingleton(() => GetNewsByIdUseCase(sl()));
  sl.registerLazySingleton(() => SearchNewsUseCase(sl()));
  sl.registerLazySingleton(() => FilterNewsUseCase(sl()));
  sl.registerLazySingleton(() => CreateNewsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNewsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNewsUseCase(sl()));
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
  sl.registerLazySingleton(() => GetStaffsUseCase(sl()));
  sl.registerLazySingleton(() => AddStaffUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStaffUseCase(sl()));
  sl.registerLazySingleton(() => DeleteStaffUseCase(sl()));
  sl.registerLazySingleton(() => SearchStaffsUseCase(sl()));
  sl.registerLazySingleton(() => SendPasswordResetUseCase(sl()));
  sl.registerLazySingleton(() => GetCustomersUseCase(sl()));
  sl.registerLazySingleton(() => GetCustomerDetailUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCustomerUseCase(sl()));
  sl.registerLazySingleton(() => LockCustomerUseCase(sl()));
  sl.registerLazySingleton(() => UnlockCustomerUseCase(sl()));
  sl.registerLazySingleton(() => SearchCustomersUseCase(sl()));
  sl.registerLazySingleton(() => FilterCustomersUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscountsUseCase(sl()));
  sl.registerLazySingleton(() => AddDiscountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDiscountUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDiscountUseCase(sl()));
  sl.registerLazySingleton(() => SearchDiscountsUseCase(sl()));
  sl.registerLazySingleton(() => FilterDiscountsUseCase(sl()));

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
  sl.registerLazySingleton<StaffRepository>(
    () => StaffRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<DiscountRepository>(
    () => DiscountRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSourceImpl(dbHelper: sl(), firestore: sl()),
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
  sl.registerLazySingleton<StaffRemoteDataSource>(
    () => StaffRemoteDataSourceImpl(
      firestore: sl<FirebaseFirestore>(),
      firebaseAuth: sl<FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<CustomerRemoteDataSource>(
    () => CustomerRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<DiscountLocalDataSource>(
    () => DiscountLocalDataSourceImpl(dbHelper: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );

  // Features - Order
  // Bloc
  sl.registerFactory(
    () => OrderBloc(
      createOrderUseCase: sl(),
      getOrdersUseCase: sl(),
      getOrderDetailUseCase: sl(),
      updateOrderStatusUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderDetailUseCase(sl()));
  sl.registerLazySingleton(() => UpdateOrderStatusUseCase(sl()));

  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(firestore: sl()),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => DatabaseHelper.instance);
}
