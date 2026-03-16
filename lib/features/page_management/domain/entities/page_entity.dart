import 'package:equatable/equatable.dart';

/// Entity halaman CMS (homepage, about, contact, dll).
/// Dinamakan PageEntity untuk menghindari konflik dengan Flutter's Page.
class PageEntity extends Equatable {
  /// ID unik halaman (uuid).
  final String id;

  /// Identifier unik halaman (e.g. 'homepage', 'about', 'contact').
  final String pageKey;

  /// Judul halaman.
  final String title;

  /// Slug URL-friendly (unik).
  final String slug;

  /// Subtitle/tagline halaman (opsional).
  final String? caption;

  /// Konten rich text halaman (opsional).
  final String? body;

  /// Judul hero section (opsional).
  final String? heroTitle;

  /// Subtitle hero section (opsional).
  final String? heroSubtitle;

  /// URL gambar hero (opsional).
  final String? heroImageUrl;

  /// Label tombol CTA hero (opsional).
  final String? heroCtaText;

  /// URL tombol CTA hero (opsional).
  final String? heroCtaUrl;

  /// Judul SEO (opsional).
  final String? metaTitle;

  /// Deskripsi SEO (opsional).
  final String? metaDescription;

  /// Keywords SEO.
  final List<String> metaKeywords;

  /// Open Graph title (opsional).
  final String? ogTitle;

  /// Open Graph description (opsional).
  final String? ogDescription;

  /// Open Graph image URL (opsional).
  final String? ogImageUrl;

  /// Apakah halaman tidak diindex oleh mesin pencari.
  final bool noIndex;

  /// Apakah halaman tidak difollow oleh mesin pencari.
  final bool noFollow;

  /// Template layout (e.g. default/landing/sidebar).
  final String? template;

  /// Apakah menampilkan header.
  final bool showHeader;

  /// Apakah menampilkan footer.
  final bool showFooter;

  /// Apakah menampilkan breadcrumbs.
  final bool showBreadcrumbs;

  /// Custom CSS (opsional).
  final String? customCss;

  /// Status halaman (draft/published/archived).
  final String status;

  /// Visibilitas halaman (public/private).
  final String visibility;

  /// ID halaman induk (untuk hierarki).
  final String? parentPageId;

  /// Urutan tampil.
  final int sortOrder;

  /// Apakah ditampilkan di navigasi.
  final bool showInNav;

  /// Label override di navigasi (opsional).
  final String? navLabel;

  /// URL gambar featured (opsional).
  final String? featuredImageUrl;

  /// Alt text gambar featured (opsional).
  final String? featuredImageAlt;

  /// URL redirect jika halaman redirect (opsional).
  final String? redirectUrl;

  /// Tipe redirect 301/302 (opsional).
  final String? redirectType;

  /// Tanggal dipublikasikan.
  final DateTime? publishedAt;

  /// Tanggal dibuat.
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  final DateTime updatedAt;

  const PageEntity({
    required this.id,
    required this.pageKey,
    required this.title,
    required this.slug,
    this.caption,
    this.body,
    this.heroTitle,
    this.heroSubtitle,
    this.heroImageUrl,
    this.heroCtaText,
    this.heroCtaUrl,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords = const [],
    this.ogTitle,
    this.ogDescription,
    this.ogImageUrl,
    this.noIndex = false,
    this.noFollow = false,
    this.template,
    this.showHeader = true,
    this.showFooter = true,
    this.showBreadcrumbs = true,
    this.customCss,
    this.status = 'draft',
    this.visibility = 'public',
    this.parentPageId,
    this.sortOrder = 0,
    this.showInNav = true,
    this.navLabel,
    this.featuredImageUrl,
    this.featuredImageAlt,
    this.redirectUrl,
    this.redirectType,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        pageKey,
        title,
        slug,
        caption,
        body,
        heroTitle,
        heroSubtitle,
        heroImageUrl,
        heroCtaText,
        heroCtaUrl,
        metaTitle,
        metaDescription,
        metaKeywords,
        ogTitle,
        ogDescription,
        ogImageUrl,
        noIndex,
        noFollow,
        template,
        showHeader,
        showFooter,
        showBreadcrumbs,
        customCss,
        status,
        visibility,
        parentPageId,
        sortOrder,
        showInNav,
        navLabel,
        featuredImageUrl,
        featuredImageAlt,
        redirectUrl,
        redirectType,
        publishedAt,
        createdAt,
        updatedAt,
      ];
}
