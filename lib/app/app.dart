import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_state.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/pages/login_page.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/pages/customer_page.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/pages/management_page.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_event.dart';

import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/order/presentation/bloc/order_bloc.dart';

/// [MyApp] là widget gốc của toàn bộ ứng dụng.
/// Nó khởi tạo MaterialApp, cung cấp theme và AuthBloc cho toàn bộ widget tree.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()..add(AuthCheckRequested())),
        BlocProvider(create: (_) => di.sl<CartBloc>()),
        BlocProvider(create: (_) => di.sl<OrderBloc>()),
      ],
      child: MaterialApp(
        title: 'BioPest Control',
        debugShowCheckedModeBanner: false,
        theme: _buildAppTheme(),
        home: const AuthWrapper(),
      ),
    );
  }

  /// Xây dựng hệ thống Theme thống nhất cho toàn ứng dụng.
  /// Tách riêng để dễ bảo trì và mở rộng.
  ThemeData _buildAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        surface: AppColors.backgroundColor,
      ),
      useMaterial3: true,
      // Ép tất cả các Dialog và Menu dùng nền trắng nhất quán
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.backgroundColor),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.surfaceColor),
          surfaceTintColor: WidgetStateProperty.all(AppColors.surfaceColor),
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.surfaceColor),
          surfaceTintColor: WidgetStateProperty.all(AppColors.surfaceColor),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.surfaceColor,
        surfaceTintColor: AppColors.surfaceColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF3F3F3),
      ),
    );
  }
}

/// [AuthWrapper] là widget điều phối điều hướng dựa trên trạng thái xác thực.
/// Lắng nghe [AuthBloc] và chuyển hướng sang trang phù hợp với vai trò người dùng.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Người dùng đã đăng nhập: điều hướng theo vai trò
        if (state is Authenticated) {
          final role = state.user.role?.toLowerCase() ?? 'customer';
          switch (role) {
            case 'admin':
            case 'staff':
              return BlocProvider(
                create: (context) =>
                    di.sl<StatisticsBloc>()..add(const LoadStatisticsEvent()),
                child: ManagementPage(user: state.user),
              );
            case 'customer':
            default:
              return CustomerPage(user: state.user);
          }
        }

        // Chưa đăng nhập hoặc có lỗi: về trang Login
        if (state is Unauthenticated || state is AuthError) {
          return const LoginPage();
        }

        // Đang kiểm tra trạng thái: hiển thị loading
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
