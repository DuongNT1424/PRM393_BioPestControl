import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;

/// Entry point của ứng dụng BioPest Control.
/// File này chỉ chịu trách nhiệm khởi tạo các service bên ngoài
/// và chạy ứng dụng. Logic UI được tách sang [lib/app/app.dart].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Khởi tạo Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  // 2. Khởi tạo Dependency Injection (GetIt Service Locator)
  await di.init();

  // 3. Khởi tạo locale data cho intl (DateFormat)
  await initializeDateFormatting('vi_VN', null);

  // 4. Chạy ứng dụng
  runApp(const MyApp());
}
