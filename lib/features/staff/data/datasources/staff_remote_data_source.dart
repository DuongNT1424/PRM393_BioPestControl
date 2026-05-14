import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/staff_model.dart';

abstract class StaffRemoteDataSource {
  Future<List<StaffModel>> getStaffs();
  Future<void> addStaff(StaffModel staff, String password);
  Future<void> updateStaff(StaffModel staff, [String? password]);
  Future<void> deleteStaff(String id);
  Future<List<StaffModel>> searchStaffs(String query);
  Future<void> sendPasswordReset(String email);
}

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  StaffRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<List<StaffModel>> getStaffs() async {
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'staff')
        .get();
    return snapshot.docs.map((doc) => StaffModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> addStaff(StaffModel staff, String password) async {
    // Tên app phụ để tránh xung đột với main app
    const String secondaryAppName = 'StaffCreator';
    FirebaseApp? secondaryApp;

    try {
      // 1. Khởi tạo hoặc lấy app phụ
      try {
        secondaryApp = Firebase.app(secondaryAppName);
      } catch (_) {
        secondaryApp = await Firebase.initializeApp(
          name: secondaryAppName,
          options: Firebase.app().options,
        );
      }

      FirebaseAuth secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

      // 2. Tạo tài khoản nhân viên bằng app phụ (không ảnh hưởng Admin đang login)
      final credential = await secondaryAuth.createUserWithEmailAndPassword(
        email: staff.email,
        password: password,
      );

      final uid = credential.user!.uid;

      // 3. Lưu vào Firestore
      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': staff.name,
        'email': staff.email,
        'role': staff.role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 4. Đăng xuất app phụ và xóa app để giải phóng bộ nhớ
      await secondaryAuth.signOut();
      // Không delete app vì có thể dùng lại ở lần sau
      
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateStaff(StaffModel staff, [String? password]) async {
    // 1. Cập nhật thông tin cơ bản lên Firestore
    await firestore.collection('users').doc(staff.id).update({
      'name': staff.name,
      'role': staff.role,
    });

    // 2. Xử lý đổi mật khẩu
    if (password != null && password.isNotEmpty) {
      final currentUser = firebaseAuth.currentUser;
      
      // Nếu User đang sửa là chính mình, có quyền đổi mật khẩu trực tiếp
      if (currentUser != null && currentUser.uid == staff.id) {
        await currentUser.updatePassword(password);
      } else {
        // Nếu Admin sửa cho Staff khác, Firebase Client SDK không hỗ trợ đổi trực tiếp
        throw Exception(
          "Firebase Auth không cho phép Admin đổi trực tiếp mật khẩu cho người khác trên Client. "
          "Vui lòng sử dụng tính năng 'Gửi email đặt lại mật khẩu'."
        );
      }
    }
  }

  @override
  Future<void> deleteStaff(String id) async {
    await firestore.collection('users').doc(id).delete();
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<List<StaffModel>> searchStaffs(String query) async {
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'staff')
        .get();

    return snapshot.docs
        .map((doc) => StaffModel.fromFirestore(doc))
        .where((staff) =>
            staff.name.toLowerCase().contains(query.toLowerCase()) ||
            staff.email.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
