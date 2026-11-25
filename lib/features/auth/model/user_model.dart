import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? avatarUrl;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.avatarUrl,
    this.createdAt,
  });

  String get displayName {
    if (fullName != null && fullName!.trim().isNotEmpty) {
      return fullName!;
    }
    if (firstName != null && firstName!.trim().isNotEmpty) {
      return '$firstName ${lastName ?? ''}'.trim();
    }
    return email.split('@').first;
  }

  factory UserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};
    final firstName = metadata['first_name'] as String?;
    final lastName = metadata['last_name'] as String?;
    final fullName = metadata['full_name'] as String?;
    final avatarUrl = metadata['avatar_url'] as String?;

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      firstName: firstName,
      lastName: lastName,
      fullName: fullName ?? (firstName != null ? '$firstName ${lastName ?? ''}'.trim() : null),
      avatarUrl: avatarUrl,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        fullName,
        avatarUrl,
        createdAt,
      ];
}
