import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> updateProfile({required String name, String? photoUrl});
  Future<void> changePassword({required String oldPassword, required String newPassword});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<ProfileModel> updateProfile({required String name, String? photoUrl}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) throw Exception("User not logged in");

      await user.updateDisplayName(name);
      if (photoUrl != null && photoUrl.isNotEmpty) {
        await user.updatePhotoURL(photoUrl);
      }

      // Cập nhật thông tin trong Firestore
      final Map<String, dynamic> updateData = {
        'name': name,
      };
      if (photoUrl != null) {
        updateData['photoUrl'] = photoUrl;
      }
      await firestore.collection('users').doc(user.uid).update(updateData);

      final doc = await firestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      final role = (doc.exists && data != null) ? data['role'] as String? : 'customer';

      return ProfileModel.fromFirebase(firebaseAuth.currentUser!, role: role);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Bắt buộc xác thực lại vì lý do bảo mật trước khi thay đổi mật khẩu
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Cập nhật mật khẩu mới
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
