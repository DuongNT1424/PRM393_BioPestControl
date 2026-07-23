import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;

/// Entry point của ứng dụng BioPest Control.
/// Luồng Cart (Giỏ hàng): 
/// - Tại đây [di.init()] sẽ đăng ký các Dependencies cho Cart bao gồm: 
///   CartBloc, UseCases (AddToCart, GetCart, ...), CartRepository, và CartLocalDataSource.
/// - Các thành phần này được quản lý tập trung và tiêm (inject) vào ứng dụng.
/// File này chịu trách nhiệm khởi tạo các service bên ngoài và chạy ứng dụng.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Khởi tạo Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  // 2. Khởi tạo Dependency Injection (GetIt Service Locator)
  // Trong phương thức này, các đối tượng liên quan đến Cart (Bloc, Usecase, Repository, Datasource) 
  // sẽ được khởi tạo như các Singleton hoặc Factory để sử dụng ở mọi nơi.
  await di.init();

  // 3. Khởi tạo locale data cho intl (DateFormat)
  await initializeDateFormatting('vi_VN', null);

  // 4. Chạy ứng dụng
  runApp(const MyApp());
}
