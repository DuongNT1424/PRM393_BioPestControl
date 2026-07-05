import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;

/// Entry point của ứng dụng BioPest Control.
/// File này chỉ chịu trách nhiệm khởi tạo các service bên ngoài
/// và chạy ứng dụng. Logic UI được tách sang [lib/app/app.dart].
void main() async {
  try {
    debugPrint("MAIN STARTING...");
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint("WidgetsFlutterBinding initialized.");

    // 1. Khởi tạo Firebase
    try {
      debugPrint("Initializing Firebase...");
      await Firebase.initializeApp();
      debugPrint("Firebase initialized successfully.");
    } catch (e) {
      debugPrint('Firebase initialization failed: $e');
    }

    // 2. Khởi tạo Dependency Injection (GetIt Service Locator)
    debugPrint("Initializing DI container...");
    await di.init();
    debugPrint("DI container initialized.");

    // 3. Khởi tạo locale data cho intl (DateFormat)
    debugPrint("Initializing Date Formatting...");
    await initializeDateFormatting('vi_VN', null);
    debugPrint("Date Formatting initialized.");

    // 4. Chạy ứng dụng
    debugPrint("Running App...");
    runApp(const MyApp());
    debugPrint("runApp completed.");
  } catch (e, stackTrace) {
    debugPrint("FATAL EXCEPTION IN MAIN: $e");
    debugPrint("STACK TRACE:\n$stackTrace");
    try {
      final file = File('crash_log.txt');
      file.writeAsStringSync('CRASH AT STARTUP:\n$e\n\nSTACK TRACE:\n$stackTrace');
    } catch (_) {}
    rethrow;
  }
}
