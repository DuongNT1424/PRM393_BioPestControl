import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String role;

  const ProfileEntity({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.role,
  });

  @override
  List<Object?> get props => [id, email, name, photoUrl, role];
}
