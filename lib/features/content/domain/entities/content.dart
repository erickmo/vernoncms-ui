import 'package:equatable/equatable.dart';

/// Entity konten (artikel/post).
class Content extends Equatable {
  /// ID unik konten (uuid).
  final String id;

  /// Judul konten.
  final String title;

  /// Slug URL-friendly (unik).
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
  final bool isFeatured;

  /// Apakah konten di-pin di atas.
  final bool isPinned;

  /// ID penulis.
  final String? authorId;

  /// Nama penulis (untuk display).
  final String? authorName;

  /// ID kategori utama.
  final String? categoryId;

  /// Nama kategori utama (untuk display).
  final String? categoryName;

  /// Daftar nama tag.
  final List<String> tags;

  /// URL gambar utama.
  final String? featuredImageUrl;

  /// Alt text gambar utama.
  final String? featuredImageAlt;

  /// URL thumbnail.
  final String? thumbnailUrl;

  /// Judul SEO.
  final String? metaTitle;

  /// Deskripsi SEO.
  final String? metaDescription;

  /// Keywords SEO.
  final List<String> metaKeywords;

  /// Open Graph title.
  final String? ogTitle;

  /// Open Graph description.
  final String? ogDescription;

  /// Open Graph image URL.
  final String? ogImageUrl;

  /// Apakah halaman tidak di-index oleh search engine.
  final bool noIndex;

  /// Apakah link di halaman tidak di-follow oleh search engine.
  final bool noFollow;

  /// Apakah komentar diperbolehkan.
  final bool allowComments;

  /// Template yang digunakan.
  final String? template;

  /// Estimasi waktu baca dalam menit (read-only).
  final int? readingTimeMinutes;

  /// Versi konten.
  final int version;

  /// Tanggal dipublikasikan.
  final DateTime? publishedAt;

  /// Tanggal dijadwalkan untuk publikasi.
  final DateTime? scheduledAt;

  /// Tanggal dibuat.
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  final DateTime updatedAt;

  const Content({
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

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        excerpt,
        body,
        status,
        visibility,
        isFeatured,
        isPinned,
        authorId,
        authorName,
        categoryId,
        categoryName,
        tags,
        featuredImageUrl,
        featuredImageAlt,
        thumbnailUrl,
        metaTitle,
        metaDescription,
        metaKeywords,
        ogTitle,
        ogDescription,
        ogImageUrl,
        noIndex,
        noFollow,
        allowComments,
        template,
        readingTimeMinutes,
        version,
        publishedAt,
        scheduledAt,
        createdAt,
        updatedAt,
      ];
}
