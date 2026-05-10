import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/auth_model.dart';

/// Giao diện nguồn dữ liệu từ xa (Remote Data Source).
/// Định nghĩa các tương tác trực tiếp với Firebase Auth và Google Sign-In.
abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String email, String password, String name);
  Future<AuthModel> loginWithGoogle();
  Future<void> logout();
  Future<AuthModel?> getCurrentUser();
}

/// Triển khai thực tế các phương thức xác thực sử dụng Firebase SDK.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
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
        // Chuyển đổi User của Firebase sang AuthModel của hệ thống
        return AuthModel.fromFirebase(response.user!);
      } else {
        throw Exception("User is null");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  // Đăng ký tài khoản và cập nhật tên hiển thị
  Future<AuthModel> register(String email, String password, String name) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        // Cập nhật thuộc tính DisplayName của User trong Firebase
        await response.user!.updateDisplayName(name);
        // Lấy lại user hiện tại để đảm bảo tên đã được cập nhật
        final user = firebaseAuth.currentUser!;
        return AuthModel.fromFirebase(user);
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
      // 1. Kích hoạt hộp thoại chọn tài khoản Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception("Google Sign In cancelled");

      // 2. Lấy thông tin xác thực (token) từ tài khoản Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // 3. Tạo credential để Firebase hiểu được đây là login từ Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Đăng nhập vào Firebase bằng credential Google
      final userCredential = await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return AuthModel.fromFirebase(userCredential.user!);
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
      return AuthModel.fromFirebase(user);
    }
    return null;
  }
}
