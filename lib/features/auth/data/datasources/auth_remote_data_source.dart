import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/auth_model.dart';

/// Giao diện nguồn dữ liệu từ xa (Remote Data Source).
/// Định nghĩa các tương tác trực tiếp với Firebase Auth và Google Sign-In.
abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String email, String password, String name, [String phone = '']);
  Future<AuthModel> loginWithGoogle();
  Future<void> logout();
  Future<AuthModel?> getCurrentUser();
  Future<void> forgotPassword(String email);
}

/// Triển khai thực tế các phương thức xác thực sử dụng Firebase SDK.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  // Đăng nhập bằng email/password thông qua Firebase
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        // Lấy role từ Firestore
        final doc = await firestore.collection('users').doc(response.user!.uid).get();
        final data = doc.data();
        final role = (doc.exists && data != null) ? data['role'] as String? : 'customer';
        
        return AuthModel.fromFirebase(response.user!, role: role);
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  // Đăng ký tài khoản và cập nhật tên hiển thị
  Future<AuthModel> register(String email, String password, String name, [String phone = '']) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await response.user!.updateDisplayName(name);
        
        // Lưu thông tin role vào Firestore (mặc định là customer)
        const role = 'customer';
        await firestore.collection('users').doc(response.user!.uid).set({
          'uid': response.user!.uid,
          'email': email,
          'name': name,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });

        final user = firebaseAuth.currentUser!;
        return AuthModel.fromFirebase(user, role: role);
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  // Quy trình đăng nhập bằng Google (Lấy token và tạo credential cho Firebase)
  Future<AuthModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception("Google Sign In cancelled");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        // Kiểm tra xem user đã có trong Firestore chưa, nếu chưa thì tạo mới với role customer
        final userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();
        String role = 'customer';
        
        if (!userDoc.exists) {
          await firestore.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email': userCredential.user!.email,
            'name': userCredential.user!.displayName,
            'role': role,
            'createdAt': FieldValue.serverTimestamp(),
          });
        } else {
          role = userDoc.data()?['role'] ?? 'customer';
        }

        return AuthModel.fromFirebase(userCredential.user!, role: role);
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  // Thực hiện đăng xuất ở cả Google Sign-In và Firebase
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  @override
  // Lấy thông tin người dùng đang đăng nhập trong phiên hiện tại
  Future<AuthModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final doc = await firestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      final role = (doc.exists && data != null) ? data['role'] as String? : 'customer';
      return AuthModel.fromFirebase(user, role: role);
    }
    return null;
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
