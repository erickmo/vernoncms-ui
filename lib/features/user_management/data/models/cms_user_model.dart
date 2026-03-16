import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/cms_user.dart';

part 'cms_user_model.g.dart';

/// Model response user dari API.
@JsonSerializable()
class CmsUserModel {
  /// ID unik user.
  final String id;

  /// Username untuk login.
  final String username;

  /// Alamat email.
  final String email;

  /// Nama lengkap.
  @JsonKey(name: 'full_name')
  final String fullName;

  /// URL avatar.
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  /// Role user.
  final String role;

  /// Apakah user aktif.
  @JsonKey(name: 'is_active')
  final bool isActive;

  /// Tanggal login terakhir.
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;

  /// Tanggal dibuat.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const CmsUserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    this.avatarUrl,
    required this.role,
    this.isActive = true,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Parse dari JSON.
  factory CmsUserModel.fromJson(Map<String, dynamic> json) =>
      _$CmsUserModelFromJson(json);

  /// Convert ke JSON.
  Map<String, dynamic> toJson() => _$CmsUserModelToJson(this);

  /// Convert ke domain entity.
  CmsUser toEntity() => CmsUser(
        id: id,
        username: username,
        email: email,
        fullName: fullName,
        avatarUrl: avatarUrl,
        role: role,
        isActive: isActive,
        lastLoginAt: lastLoginAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Buat model dari domain entity.
  factory CmsUserModel.fromEntity(CmsUser entity) {
    return CmsUserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      fullName: entity.fullName,
      avatarUrl: entity.avatarUrl,
      role: entity.role,
      isActive: entity.isActive,
      lastLoginAt: entity.lastLoginAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
