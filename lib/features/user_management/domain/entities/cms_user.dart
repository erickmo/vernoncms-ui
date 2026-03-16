import 'package:equatable/equatable.dart';

/// Entity user CMS.
class CmsUser extends Equatable {
  /// ID unik user.
  final String id;

  /// Username untuk login.
  final String username;

  /// Alamat email.
  final String email;

  /// Nama lengkap.
  final String fullName;

  /// URL avatar (opsional).
  final String? avatarUrl;

  /// Role user (super_admin, admin, editor, viewer).
  final String role;

  /// Apakah user aktif.
  final bool isActive;

  /// Tanggal login terakhir (opsional).
  final DateTime? lastLoginAt;

  /// Tanggal dibuat.
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  final DateTime updatedAt;

  const CmsUser({
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

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        avatarUrl,
        role,
        isActive,
        lastLoginAt,
        createdAt,
        updatedAt,
      ];
}

/// Entity role user untuk display.
class UserRole extends Equatable {
  /// ID role (super_admin, admin, editor, viewer).
  final String id;

  /// Nama tampilan role.
  final String name;

  /// Deskripsi role.
  final String description;

  /// Daftar permission.
  final List<String> permissions;

  const UserRole({
    required this.id,
    required this.name,
    required this.description,
    required this.permissions,
  });

  @override
  List<Object?> get props => [id, name, description, permissions];

  /// Daftar role yang tersedia.
  static const List<UserRole> availableRoles = [
    UserRole(
      id: 'super_admin',
      name: 'Super Admin',
      description: 'Akses penuh ke seluruh sistem',
      permissions: [
        'content.create',
        'content.edit',
        'content.delete',
        'media.upload',
        'domain.manage',
        'user.manage',
      ],
    ),
    UserRole(
      id: 'admin',
      name: 'Admin',
      description: 'Mengelola konten dan pengaturan',
      permissions: [
        'content.create',
        'content.edit',
        'content.delete',
        'media.upload',
        'domain.manage',
      ],
    ),
    UserRole(
      id: 'editor',
      name: 'Editor',
      description: 'Membuat dan mengedit konten',
      permissions: [
        'content.create',
        'content.edit',
        'media.upload',
      ],
    ),
    UserRole(
      id: 'viewer',
      name: 'Viewer',
      description: 'Hanya dapat melihat konten',
      permissions: [],
    ),
  ];
}
