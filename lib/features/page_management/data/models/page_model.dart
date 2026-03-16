import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/page_entity.dart';

part 'page_model.g.dart';

/// Model response halaman dari API.
@JsonSerializable()
class PageModel {
  /// ID unik halaman.
  final String id;

  /// Identifier unik halaman.
  @JsonKey(name: 'page_key')
  final String pageKey;

  /// Judul halaman.
  final String title;

  /// Slug URL-friendly.
  final String slug;

  /// Subtitle/tagline halaman.
  final String? caption;

  /// Konten rich text halaman.
  final String? body;

  /// Judul hero section.
  @JsonKey(name: 'hero_title')
  final String? heroTitle;

  /// Subtitle hero section.
  @JsonKey(name: 'hero_subtitle')
  final String? heroSubtitle;

  /// URL gambar hero.
  @JsonKey(name: 'hero_image_url')
  final String? heroImageUrl;

  /// Label tombol CTA hero.
  @JsonKey(name: 'hero_cta_text')
  final String? heroCtaText;

  /// URL tombol CTA hero.
  @JsonKey(name: 'hero_cta_url')
  final String? heroCtaUrl;

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

  /// Apakah halaman tidak diindex.
  @JsonKey(name: 'no_index')
  final bool noIndex;

  /// Apakah halaman tidak difollow.
  @JsonKey(name: 'no_follow')
  final bool noFollow;

  /// Template layout.
  final String? template;

  /// Apakah menampilkan header.
  @JsonKey(name: 'show_header')
  final bool showHeader;

  /// Apakah menampilkan footer.
  @JsonKey(name: 'show_footer')
  final bool showFooter;

  /// Apakah menampilkan breadcrumbs.
  @JsonKey(name: 'show_breadcrumbs')
  final bool showBreadcrumbs;

  /// Custom CSS.
  @JsonKey(name: 'custom_css')
  final String? customCss;

  /// Status halaman.
  final String status;

  /// Visibilitas halaman.
  final String visibility;

  /// ID halaman induk.
  @JsonKey(name: 'parent_page_id')
  final String? parentPageId;

  /// Urutan tampil.
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  /// Apakah ditampilkan di navigasi.
  @JsonKey(name: 'show_in_nav')
  final bool showInNav;

  /// Label override di navigasi.
  @JsonKey(name: 'nav_label')
  final String? navLabel;

  /// URL gambar featured.
  @JsonKey(name: 'featured_image_url')
  final String? featuredImageUrl;

  /// Alt text gambar featured.
  @JsonKey(name: 'featured_image_alt')
  final String? featuredImageAlt;

  /// URL redirect.
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;

  /// Tipe redirect 301/302.
  @JsonKey(name: 'redirect_type')
  final String? redirectType;

  /// Tanggal dipublikasikan.
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  /// Tanggal dibuat.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Tanggal terakhir diperbarui.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const PageModel({
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

  /// Parse dari JSON.
  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  /// Convert ke JSON.
  Map<String, dynamic> toJson() => _$PageModelToJson(this);

  /// Convert ke domain entity.
  PageEntity toEntity() => PageEntity(
        id: id,
        pageKey: pageKey,
        title: title,
        slug: slug,
        caption: caption,
        body: body,
        heroTitle: heroTitle,
        heroSubtitle: heroSubtitle,
        heroImageUrl: heroImageUrl,
        heroCtaText: heroCtaText,
        heroCtaUrl: heroCtaUrl,
        metaTitle: metaTitle,
        metaDescription: metaDescription,
        metaKeywords: metaKeywords,
        ogTitle: ogTitle,
        ogDescription: ogDescription,
        ogImageUrl: ogImageUrl,
        noIndex: noIndex,
        noFollow: noFollow,
        template: template,
        showHeader: showHeader,
        showFooter: showFooter,
        showBreadcrumbs: showBreadcrumbs,
        customCss: customCss,
        status: status,
        visibility: visibility,
        parentPageId: parentPageId,
        sortOrder: sortOrder,
        showInNav: showInNav,
        navLabel: navLabel,
        featuredImageUrl: featuredImageUrl,
        featuredImageAlt: featuredImageAlt,
        redirectUrl: redirectUrl,
        redirectType: redirectType,
        publishedAt: publishedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Buat model dari domain entity.
  factory PageModel.fromEntity(PageEntity entity) {
    return PageModel(
      id: entity.id,
      pageKey: entity.pageKey,
      title: entity.title,
      slug: entity.slug,
      caption: entity.caption,
      body: entity.body,
      heroTitle: entity.heroTitle,
      heroSubtitle: entity.heroSubtitle,
      heroImageUrl: entity.heroImageUrl,
      heroCtaText: entity.heroCtaText,
      heroCtaUrl: entity.heroCtaUrl,
      metaTitle: entity.metaTitle,
      metaDescription: entity.metaDescription,
      metaKeywords: entity.metaKeywords,
      ogTitle: entity.ogTitle,
      ogDescription: entity.ogDescription,
      ogImageUrl: entity.ogImageUrl,
      noIndex: entity.noIndex,
      noFollow: entity.noFollow,
      template: entity.template,
      showHeader: entity.showHeader,
      showFooter: entity.showFooter,
      showBreadcrumbs: entity.showBreadcrumbs,
      customCss: entity.customCss,
      status: entity.status,
      visibility: entity.visibility,
      parentPageId: entity.parentPageId,
      sortOrder: entity.sortOrder,
      showInNav: entity.showInNav,
      navLabel: entity.navLabel,
      featuredImageUrl: entity.featuredImageUrl,
      featuredImageAlt: entity.featuredImageAlt,
      redirectUrl: entity.redirectUrl,
      redirectType: entity.redirectType,
      publishedAt: entity.publishedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
