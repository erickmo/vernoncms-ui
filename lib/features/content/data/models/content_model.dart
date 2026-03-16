import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/content.dart';

part 'content_model.g.dart';

/// Model response konten dari API.
@JsonSerializable()
class ContentModel {
  /// ID unik konten.
  final String id;

  /// Judul konten.
  final String title;

  /// Slug URL-friendly.
  final String slug;

  /// Ringkasan singkat konten.
  final String? excerpt;

  /// Isi konten (rich text).
  final String? body;

  /// Status konten: draft, published, archived.
  final String status;

  /// Visibilitas: public, private, password_protected.
  final String visibility;

  /// Apakah konten ditandai sebagai featured.
  @JsonKey(name: 'is_featured')
  final bool isFeatured;

  /// Apakah konten di-pin di atas.
  @JsonKey(name: 'is_pinned')
  final bool isPinned;

  /// ID penulis.
  @JsonKey(name: 'author_id')
  final String? authorId;

  /// Nama penulis (untuk display).
  @JsonKey(name: 'author_name')
  final String? authorName;

  /// ID kategori utama.
  @JsonKey(name: 'category_id')
  final String? categoryId;

  /// Nama kategori utama (untuk display).
  @JsonKey(name: 'category_name')
  final String? categoryName;

  /// Daftar nama tag.
  final List<String> tags;

  /// URL gambar utama.
  @JsonKey(name: 'featured_image_url')
  final String? featuredImageUrl;

  /// Alt text gambar utama.
  @JsonKey(name: 'featured_image_alt')
  final String? featuredImageAlt;

  /// URL thumbnail.
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;

  /// Judul SEO.
  @JsonKey(name: 'meta_title')
  final String? metaTitle;

  /// Deskripsi SEO.
  @JsonKey(name: 'meta_description')
  final String? metaDescription;

  /// Keywords SEO.
  @JsonKey(name: 'meta_keywords')
  final List<String> metaKeywords;

  /// Open Graph title.
  @JsonKey(name: 'og_title')
  final String? ogTitle;

  /// Open Graph description.
  @JsonKey(name: 'og_description')
  final String? ogDescription;

  /// Open Graph image URL.
  @JsonKey(name: 'og_image_url')
  final String? ogImageUrl;

  /// Apakah halaman tidak di-index.
  @JsonKey(name: 'no_index')
  final bool noIndex;

  /// Apakah link tidak di-follow.
  @JsonKey(name: 'no_follow')
  final bool noFollow;

  /// Apakah komentar diperbolehkan.
  @JsonKey(name: 'allow_comments')
  final bool allowComments;

  /// Template yang digunakan.
  final String? template;

  /// Estimasi waktu baca dalam menit (read-only).
  @JsonKey(name: 'reading_time_minutes')
  final int? readingTimeMinutes;

  /// Versi konten.
  final int version;

  /// Tanggal dipublikasikan.
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  /// Tanggal dijadwalkan untuk publikasi.
  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;

  /// Tanggal dibuat.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const ContentModel({
    required this.id,
    required this.title,
    required this.slug,
    this.excerpt,
    this.body,
    this.status = 'draft',
    this.visibility = 'public',
    this.isFeatured = false,
    this.isPinned = false,
    this.authorId,
    this.authorName,
    this.categoryId,
    this.categoryName,
    this.tags = const [],
    this.featuredImageUrl,
    this.featuredImageAlt,
    this.thumbnailUrl,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords = const [],
    this.ogTitle,
    this.ogDescription,
    this.ogImageUrl,
    this.noIndex = false,
    this.noFollow = false,
    this.allowComments = true,
    this.template,
    this.readingTimeMinutes,
    this.version = 1,
    this.publishedAt,
    this.scheduledAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Parse dari JSON.
  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);

  /// Convert ke JSON.
  Map<String, dynamic> toJson() => _$ContentModelToJson(this);

  /// Convert ke domain entity.
  Content toEntity() => Content(
        id: id,
        title: title,
        slug: slug,
        excerpt: excerpt,
        body: body,
        status: status,
        visibility: visibility,
        isFeatured: isFeatured,
        isPinned: isPinned,
        authorId: authorId,
        authorName: authorName,
        categoryId: categoryId,
        categoryName: categoryName,
        tags: tags,
        featuredImageUrl: featuredImageUrl,
        featuredImageAlt: featuredImageAlt,
        thumbnailUrl: thumbnailUrl,
        metaTitle: metaTitle,
        metaDescription: metaDescription,
        metaKeywords: metaKeywords,
        ogTitle: ogTitle,
        ogDescription: ogDescription,
        ogImageUrl: ogImageUrl,
        noIndex: noIndex,
        noFollow: noFollow,
        allowComments: allowComments,
        template: template,
        readingTimeMinutes: readingTimeMinutes,
        version: version,
        publishedAt: publishedAt,
        scheduledAt: scheduledAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Buat model dari domain entity.
  factory ContentModel.fromEntity(Content entity) {
    return ContentModel(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      excerpt: entity.excerpt,
      body: entity.body,
      status: entity.status,
      visibility: entity.visibility,
      isFeatured: entity.isFeatured,
      isPinned: entity.isPinned,
      authorId: entity.authorId,
      authorName: entity.authorName,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      tags: entity.tags,
      featuredImageUrl: entity.featuredImageUrl,
      featuredImageAlt: entity.featuredImageAlt,
      thumbnailUrl: entity.thumbnailUrl,
      metaTitle: entity.metaTitle,
      metaDescription: entity.metaDescription,
      metaKeywords: entity.metaKeywords,
      ogTitle: entity.ogTitle,
      ogDescription: entity.ogDescription,
      ogImageUrl: entity.ogImageUrl,
      noIndex: entity.noIndex,
      noFollow: entity.noFollow,
      allowComments: entity.allowComments,
      template: entity.template,
      readingTimeMinutes: entity.readingTimeMinutes,
      version: entity.version,
      publishedAt: entity.publishedAt,
      scheduledAt: entity.scheduledAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
