import 'package:equatable/equatable.dart';

/// Entity kategori konten.
class ContentCategory extends Equatable {
  /// ID unik kategori (uuid).
  final String id;

  /// Nama kategori.
  final String name;

  /// Slug URL-friendly (unik).
  final String slug;

  /// Deskripsi kategori (opsional).
  final String? description;

  /// ID kategori induk (nullable, untuk hierarki).
  final String? parentCategoryId;

  /// Nama kategori induk (untuk display).
  final String? parentCategoryName;

  /// Urutan tampil.
  final int sortOrder;

  /// Nama icon atau emoji (opsional).
  final String? icon;

  /// Warna hex (opsional).
  final String? color;

  /// URL thumbnail kategori (opsional).
  final String? imageUrl;

  /// Judul SEO (opsional).
  final String? metaTitle;

  /// Deskripsi SEO (opsional).
  final String? metaDescription;

  /// Apakah kategori tampil di publik.
  final bool isVisible;

  /// Apakah kategori ditandai sebagai featured.
  final bool isFeatured;

  /// Jumlah konten dalam kategori (read-only).
  final int contentCount;

  /// Tanggal dibuat.
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  final DateTime updatedAt;

  const ContentCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.parentCategoryId,
    this.parentCategoryName,
    this.sortOrder = 0,
    this.icon,
    this.color,
    this.imageUrl,
    this.metaTitle,
    this.metaDescription,
    this.isVisible = true,
    this.isFeatured = false,
    this.contentCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        description,
        parentCategoryId,
        parentCategoryName,
        sortOrder,
        icon,
        color,
        imageUrl,
        metaTitle,
        metaDescription,
        isVisible,
        isFeatured,
        contentCount,
        createdAt,
        updatedAt,
      ];
}
