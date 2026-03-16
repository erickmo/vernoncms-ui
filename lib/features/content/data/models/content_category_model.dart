import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/content_category.dart';

part 'content_category_model.g.dart';

/// Model response kategori konten dari API.
@JsonSerializable()
class ContentCategoryModel {
  /// ID unik kategori.
  final String id;

  /// Nama kategori.
  final String name;

  /// Slug URL-friendly.
  final String slug;

  /// Deskripsi kategori.
  final String? description;

  /// ID kategori induk.
  @JsonKey(name: 'parent_category_id')
  final String? parentCategoryId;

  /// Nama kategori induk.
  @JsonKey(name: 'parent_category_name')
  final String? parentCategoryName;

  /// Urutan tampil.
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  /// Nama icon atau emoji.
  final String? icon;

  /// Warna hex.
  final String? color;

  /// URL thumbnail kategori.
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Judul SEO.
  @JsonKey(name: 'meta_title')
  final String? metaTitle;

  /// Deskripsi SEO.
  @JsonKey(name: 'meta_description')
  final String? metaDescription;

  /// Apakah kategori tampil di publik.
  @JsonKey(name: 'is_visible')
  final bool isVisible;

  /// Apakah kategori ditandai sebagai featured.
  @JsonKey(name: 'is_featured')
  final bool isFeatured;

  /// Jumlah konten dalam kategori.
  @JsonKey(name: 'content_count')
  final int contentCount;

  /// Tanggal dibuat.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const ContentCategoryModel({
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

  /// Parse dari JSON.
  factory ContentCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ContentCategoryModelFromJson(json);

  /// Convert ke JSON.
  Map<String, dynamic> toJson() => _$ContentCategoryModelToJson(this);

  /// Convert ke domain entity.
  ContentCategory toEntity() => ContentCategory(
        id: id,
        name: name,
        slug: slug,
        description: description,
        parentCategoryId: parentCategoryId,
        parentCategoryName: parentCategoryName,
        sortOrder: sortOrder,
        icon: icon,
        color: color,
        imageUrl: imageUrl,
        metaTitle: metaTitle,
        metaDescription: metaDescription,
        isVisible: isVisible,
        isFeatured: isFeatured,
        contentCount: contentCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Buat model dari domain entity.
  factory ContentCategoryModel.fromEntity(ContentCategory entity) {
    return ContentCategoryModel(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      description: entity.description,
      parentCategoryId: entity.parentCategoryId,
      parentCategoryName: entity.parentCategoryName,
      sortOrder: entity.sortOrder,
      icon: entity.icon,
      color: entity.color,
      imageUrl: entity.imageUrl,
      metaTitle: entity.metaTitle,
      metaDescription: entity.metaDescription,
      isVisible: entity.isVisible,
      isFeatured: entity.isFeatured,
      contentCount: entity.contentCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
