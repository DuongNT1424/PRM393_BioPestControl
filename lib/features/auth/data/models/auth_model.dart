import '../../domain/entities/auth_entity.dart';

/// Lớp Model kế thừa từ AuthEntity ở tầng Domain.
/// Model chịu trách nhiệm chuyển đổi dữ liệu từ các định dạng khác nhau (JSON, Firebase User)
/// sang đối tượng mà hệ thống có thể hiểu được.
class AuthModel extends AuthEntity {
  const AuthModel({
    super.id,
    super.email,
    super.name,
    super.photoUrl,
    super.role,
  });

  // Chuyển đổi từ dữ liệu JSON (thường từ API) sang AuthModel
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      role: json['role'],
    );
  }

  // Chuyển đổi từ AuthModel sang định dạng JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
    };
  }

  // Chuyển đổi từ đối tượng User của Firebase SDK sang AuthModel
  factory AuthModel.fromFirebase(dynamic user, {String? role}) {
    return AuthModel(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
      role: role,
    );
  }
}
