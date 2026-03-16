/// String yang tampil ke user.
/// Selalu gunakan konstanta ini untuk memudahkan lokalisasi.
class AppStrings {
  AppStrings._();

  // Common
  static const String loading = 'Memuat...';
  static const String retry = 'Coba Lagi';
  static const String cancel = 'Batal';
  static const String save = 'Simpan';
  static const String delete = 'Hapus';
  static const String confirm = 'Konfirmasi';
  static const String back = 'Kembali';
  static const String next = 'Lanjut';
  static const String submit = 'Kirim';

  // Auth - Login
  static const String loginSubtitle = 'Masuk ke akun Anda';
  static const String usernameLabel = 'Username';
  static const String usernameHint = 'Masukkan username';
  static const String usernameRequired = 'Username wajib diisi';
  static const String passwordLabel = 'Password';
  static const String passwordHint = 'Masukkan password';
  static const String passwordRequired = 'Password wajib diisi';
  static const String loginButton = 'Masuk';
  static const String rememberMe = 'Ingat saya';
  static const String forgotPassword = 'Lupa Password?';
  static const String logout = 'Keluar';

  // Auth - Forgot Password
  static const String forgotPasswordTitle = 'Lupa Password';
  static const String forgotPasswordSubtitle =
      'Masukkan email Anda untuk menerima link reset password.';
  static const String emailLabel = 'Email';
  static const String emailHint = 'Masukkan email';
  static const String emailRequired = 'Email wajib diisi';
  static const String sendResetLink = 'Kirim Link Reset';
  static const String backToLogin = 'Kembali ke Login';
  static const String resetLinkSent = 'Link Reset Terkirim';
  static const String resetLinkSentSubtitle =
      'Silakan cek email Anda untuk link reset password.';

  // Sidebar Menu
  static const String menuDashboard = 'Dashboard';
  static const String sectionContent = 'Konten';
  static const String menuContentList = 'Daftar Konten';
  static const String menuContentCategory = 'Kategori Konten';
  static const String sectionPages = 'Halaman';
  static const String menuPageList = 'Daftar Halaman';

  // Dashboard
  static const String dashboardWelcome = 'Selamat datang di Vernon CMS';
  static const String totalPosts = 'Total Post';
  static const String totalVisits = 'Total Kunjungan';
  static const String todayVisits = 'Kunjungan Hari Ini';
  static const String dailyContentChart = 'Konten Per Hari';
  static const String last7Days = '7 hari terakhir';

  // Common Actions
  static const String edit = 'Edit';
  static const String search = 'Cari';

  // Visibility
  static const String visible = 'Tampil';
  static const String hidden = 'Tersembunyi';

  // Placeholder Pages
  static const String contentListTitle = 'Daftar Konten';
  static const String contentCategoryTitle = 'Kategori Konten';
  static const String pageListTitle = 'Daftar Halaman';
  static const String comingSoon = 'Segera hadir';

  // Content Category
  static const String addCategory = 'Tambah Kategori';
  static const String editCategory = 'Edit Kategori';
  static const String deleteCategory = 'Hapus Kategori';
  static const String deleteCategoryConfirm =
      'Apakah Anda yakin ingin menghapus kategori';
  static const String searchCategory = 'Cari kategori...';
  static const String categoryName = 'Nama Kategori';
  static const String categoryNameHint = 'Masukkan nama kategori';
  static const String categoryNameRequired = 'Nama kategori wajib diisi';
  static const String categorySlug = 'Slug';
  static const String categorySlugHint = 'slug-kategori';
  static const String categorySlugRequired = 'Slug wajib diisi';
  static const String categoryDescription = 'Deskripsi';
  static const String categoryDescriptionHint = 'Deskripsi kategori (opsional)';
  static const String parentCategory = 'Kategori Induk';
  static const String noParentCategory = 'Tanpa Induk (Root)';
  static const String sortOrder = 'Urutan';
  static const String categoryIcon = 'Icon';
  static const String categoryIconHint = 'Nama icon atau emoji';
  static const String categoryColor = 'Warna';
  static const String categoryColorHint = '#FF5722';
  static const String categoryVisible = 'Tampilkan';
  static const String categoryFeatured = 'Featured';
  static const String seoSection = 'SEO';
  static const String metaTitle = 'Meta Title';
  static const String metaTitleHint = 'Judul untuk SEO';
  static const String metaDescriptionLabel = 'Meta Description';
  static const String metaDescriptionHint = 'Deskripsi untuk SEO';

  // Content Category Table Columns
  static const String columnName = 'Nama';
  static const String columnSlug = 'Slug';
  static const String columnContentCount = 'Jumlah Konten';
  static const String columnVisible = 'Visibilitas';
  static const String columnActions = 'Aksi';

  // Content Category Messages
  static const String categoryCreated = 'Kategori berhasil dibuat';
  static const String categoryUpdated = 'Kategori berhasil diperbarui';
  static const String categoryDeleted = 'Kategori berhasil dihapus';

  // Error Messages
  static const String errorGeneral = 'Terjadi kesalahan. Silakan coba lagi.';
  static const String errorNetwork = 'Tidak ada koneksi internet.';
  static const String errorServer = 'Server sedang bermasalah. Coba lagi nanti.';
  static const String errorUnauthorized = 'Sesi Anda telah berakhir. Silakan login kembali.';
  static const String errorNotFound = 'Data tidak ditemukan.';
  static const String errorTimeout = 'Koneksi timeout. Coba lagi.';

  // Empty States
  static const String emptyData = 'Belum ada data.';
  static const String emptySearch = 'Hasil pencarian tidak ditemukan.';

  // Page Management
  static const String addPage = 'Tambah Halaman';
  static const String editPage = 'Edit Halaman';
  static const String deletePage = 'Hapus Halaman';
  static const String deletePageConfirm =
      'Apakah Anda yakin ingin menghapus halaman';
  static const String searchPage = 'Cari halaman...';
  static const String pageCreated = 'Halaman berhasil dibuat';
  static const String pageUpdated = 'Halaman berhasil diperbarui';
  static const String pageDeleted = 'Halaman berhasil dihapus';

  // Page Management - Table Columns
  static const String pageColumnTitle = 'Judul';
  static const String pageColumnPageKey = 'Page Key';
  static const String pageColumnStatus = 'Status';
  static const String pageColumnShowInNav = 'Navigasi';

  // Page Management - Status
  static const String pageStatusLabel = 'Status';
  static const String pageStatusDraft = 'Draft';
  static const String pageStatusPublished = 'Published';
  static const String pageStatusArchived = 'Archived';

  // Page Management - Visibility
  static const String pageVisibilityLabel = 'Visibilitas';
  static const String pageVisibilityPublic = 'Public';
  static const String pageVisibilityPrivate = 'Private';

  // Page Management - Form Tabs
  static const String pageTabContent = 'Konten';
  static const String pageTabHero = 'Hero';
  static const String pageTabSeoSettings = 'SEO & Settings';

  // Page Management - Content Fields
  static const String pageTitleLabel = 'Judul Halaman';
  static const String pageTitleHint = 'Masukkan judul halaman';
  static const String pageTitleRequired = 'Judul halaman wajib diisi';
  static const String pageKeyLabel = 'Page Key';
  static const String pageKeyHint = 'contoh: homepage, about, contact';
  static const String pageKeyRequired = 'Page key wajib diisi';
  static const String pageSlugLabel = 'Slug';
  static const String pageSlugHint = 'slug-halaman';
  static const String pageSlugRequired = 'Slug wajib diisi';
  static const String pageCaptionLabel = 'Caption';
  static const String pageCaptionHint = 'Subtitle atau tagline (opsional)';
  static const String pageBodyLabel = 'Konten';
  static const String pageBodyHint = 'Tulis konten halaman di sini...';

  // Page Management - Hero Fields
  static const String pageHeroTitleLabel = 'Hero Title';
  static const String pageHeroTitleHint = 'Judul hero section';
  static const String pageHeroSubtitleLabel = 'Hero Subtitle';
  static const String pageHeroSubtitleHint = 'Subtitle hero section';
  static const String pageHeroImageUrlLabel = 'Hero Image URL';
  static const String pageHeroImageUrlHint = 'https://example.com/image.jpg';
  static const String pageHeroCtaTextLabel = 'CTA Text';
  static const String pageHeroCtaTextHint = 'Label tombol CTA';
  static const String pageHeroCtaUrlLabel = 'CTA URL';
  static const String pageHeroCtaUrlHint = 'https://example.com';

  // Page Management - SEO Fields
  static const String pageMetaKeywordsLabel = 'Meta Keywords';
  static const String pageMetaKeywordsHint = 'keyword1, keyword2, keyword3';
  static const String pageNoIndexLabel = 'No Index';
  static const String pageNoFollowLabel = 'No Follow';

  // Page Management - OG Fields
  static const String pageOgSection = 'Open Graph';
  static const String pageOgTitleLabel = 'OG Title';
  static const String pageOgTitleHint = 'Judul untuk Open Graph';
  static const String pageOgDescriptionLabel = 'OG Description';
  static const String pageOgDescriptionHint = 'Deskripsi untuk Open Graph';
  static const String pageOgImageUrlLabel = 'OG Image URL';
  static const String pageOgImageUrlHint = 'https://example.com/og-image.jpg';

  // Page Management - Layout Settings
  static const String pageLayoutSection = 'Layout';
  static const String pageTemplateLabel = 'Template';
  static const String pageTemplateDefault = 'Default';
  static const String pageTemplateLanding = 'Landing';
  static const String pageTemplateSidebar = 'Sidebar';
  static const String pageShowHeaderLabel = 'Tampilkan Header';
  static const String pageShowFooterLabel = 'Tampilkan Footer';
  static const String pageShowBreadcrumbsLabel = 'Tampilkan Breadcrumbs';
  static const String pageCustomCssLabel = 'Custom CSS';
  static const String pageCustomCssHint = '.hero { color: red; }';

  // Page Management - Navigation Settings
  static const String pageNavSection = 'Navigasi';
  static const String pageShowInNavLabel = 'Tampilkan di Navigasi';
  static const String pageNavLabelLabel = 'Label Navigasi';
  static const String pageNavLabelHint = 'Label override untuk navigasi';
  static const String pageParentPageLabel = 'Halaman Induk';
  static const String pageParentPageHint = 'ID halaman induk (opsional)';

  // Page Management - Featured Image
  static const String pageFeaturedImageSection = 'Gambar Featured';
  static const String pageFeaturedImageUrlLabel = 'Featured Image URL';
  static const String pageFeaturedImageUrlHint = 'https://example.com/image.jpg';
  static const String pageFeaturedImageAltLabel = 'Alt Text';
  static const String pageFeaturedImageAltHint = 'Deskripsi gambar';

  // Page Management - Redirect
  static const String pageRedirectSection = 'Redirect';
  static const String pageRedirectUrlLabel = 'Redirect URL';
  static const String pageRedirectUrlHint = 'https://example.com/target';
  static const String pageRedirectTypeLabel = 'Tipe Redirect';
  static const String pageRedirectTypeNone = 'Tidak Ada';
  static const String pageRedirectType301 = '301 - Permanent';
  static const String pageRedirectType302 = '302 - Temporary';

  // Content (Articles/Posts)
  static const String addContent = 'Tambah Konten';
  static const String editContent = 'Edit Konten';
  static const String deleteContent = 'Hapus Konten';
  static const String deleteContentConfirm =
      'Apakah Anda yakin ingin menghapus konten';
  static const String searchContent = 'Cari konten...';
  static const String contentTitle = 'Judul';
  static const String contentTitleHint = 'Masukkan judul konten';
  static const String contentTitleRequired = 'Judul wajib diisi';
  static const String contentSlug = 'Slug';
  static const String contentSlugHint = 'slug-konten';
  static const String contentSlugRequired = 'Slug wajib diisi';
  static const String contentExcerpt = 'Ringkasan';
  static const String contentExcerptHint = 'Ringkasan singkat konten (opsional)';
  static const String contentBody = 'Isi Konten';
  static const String contentBodyHint = 'Tulis isi konten di sini...';
  static const String contentStatus = 'Status';
  static const String contentStatusDraft = 'Draft';
  static const String contentStatusPublished = 'Published';
  static const String contentStatusArchived = 'Archived';
  static const String contentAllStatuses = 'Semua Status';
  static const String contentVisibility = 'Visibilitas';
  static const String contentVisibilityPublic = 'Public';
  static const String contentVisibilityPrivate = 'Private';
  static const String contentVisibilityPasswordProtected = 'Password Protected';
  static const String contentCategory = 'Kategori';
  static const String contentNoCategory = 'Tanpa Kategori';
  static const String contentAllCategories = 'Semua Kategori';
  static const String contentTags = 'Tags';
  static const String contentTagsHint = 'tag1, tag2, tag3';
  static const String contentFeaturedImage = 'Gambar Utama';
  static const String contentFeaturedImageUrl = 'URL Gambar';
  static const String contentFeaturedImageUrlHint = 'https://example.com/image.jpg';
  static const String contentFeaturedImageAlt = 'Alt Text';
  static const String contentFeaturedImageAltHint = 'Deskripsi gambar';
  static const String contentFeatured = 'Featured';
  static const String contentPinned = 'Pinned';
  static const String contentAllowComments = 'Izinkan Komentar';
  static const String contentTemplate = 'Template';
  static const String contentTemplateHint = 'Nama template (opsional)';
  static const String contentNoIndex = 'No Index';
  static const String contentNoFollow = 'No Follow';
  static const String contentMetaKeywords = 'Meta Keywords';
  static const String contentMetaKeywordsHint = 'keyword1, keyword2, keyword3';
  static const String contentOgSection = 'Open Graph';
  static const String contentOgTitle = 'OG Title';
  static const String contentOgTitleHint = 'Judul Open Graph';
  static const String contentOgDescription = 'OG Description';
  static const String contentOgDescriptionHint = 'Deskripsi Open Graph';
  static const String contentOgImageUrl = 'OG Image URL';
  static const String contentOgImageUrlHint = 'https://example.com/og-image.jpg';
  static const String contentPublishSection = 'Publikasi';
  static const String contentCategorySection = 'Kategori';
  static const String contentTagsSection = 'Tags';
  static const String contentSettingsSection = 'Pengaturan';
  static const String contentSaveAsDraft = 'Simpan Draft';
  static const String contentPublish = 'Publikasikan';
  static const String contentCreated = 'Konten berhasil dibuat';
  static const String contentUpdated = 'Konten berhasil diperbarui';
  static const String contentDeleted = 'Konten berhasil dihapus';

  // Content Table Columns
  static const String contentColumnTitle = 'Judul';
  static const String contentColumnCategory = 'Kategori';
  static const String contentColumnStatus = 'Status';
  static const String contentColumnPublishedAt = 'Tanggal Terbit';

  // Sidebar - Settings
  static const String sectionSettings = 'Pengaturan';
  static const String menuDomainBuilder = 'Domain Builder';

  // Domain Builder
  static const String domainBuilderTitle = 'Domain Builder';
  static const String domainAdd = 'Tambah Domain';
  static const String domainEdit = 'Edit Domain';
  static const String domainDelete = 'Hapus Domain';
  static const String domainDeleteConfirm =
      'Apakah Anda yakin ingin menghapus domain';
  static const String domainCreated = 'Domain berhasil dibuat';
  static const String domainUpdated = 'Domain berhasil diperbarui';
  static const String domainDeleted = 'Domain berhasil dihapus';

  // Domain Builder - Form
  static const String domainBasicInfo = 'Informasi Dasar';
  static const String domainName = 'Nama Domain';
  static const String domainNameHint = 'Contoh: Cabang Bisnis';
  static const String domainNameRequired = 'Nama domain wajib diisi';
  static const String domainSlug = 'Slug';
  static const String domainSlugHint = 'cabang-bisnis';
  static const String domainSlugRequired = 'Slug wajib diisi';
  static const String domainDescription = 'Deskripsi';
  static const String domainDescriptionHint = 'Deskripsi domain (opsional)';
  static const String domainIcon = 'Icon';
  static const String domainIconHint = 'Nama icon Material (contoh: store)';
  static const String domainPluralName = 'Nama Jamak';
  static const String domainPluralNameHint = 'Contoh: Cabang Bisnis';

  // Domain Builder - Sidebar Config
  static const String domainSidebarConfig = 'Konfigurasi Sidebar';
  static const String domainSidebarSection = 'Bagian Sidebar';
  static const String domainSidebarOrder = 'Urutan Sidebar';

  // Domain Builder - Table Columns
  static const String domainColumnIcon = 'Icon';
  static const String domainColumnName = 'Nama';
  static const String domainColumnFieldCount = 'Jumlah Field';
  static const String domainColumnSidebar = 'Sidebar';

  // Domain Builder - Fields
  static const String domainFieldsSection = 'Daftar Field';
  static const String domainAddField = 'Tambah Field';
  static const String domainNoFields = 'Belum ada field. Tambahkan field pertama.';
  static const String domainFieldNewField = 'Field Baru';
  static const String domainFieldLabel = 'Label';
  static const String domainFieldName = 'Nama Field (snake_case)';
  static const String domainFieldType = 'Tipe Field';
  static const String domainFieldRequired = 'Wajib';
  static const String domainFieldPlaceholder = 'Placeholder';
  static const String domainFieldDefaultValue = 'Nilai Default';
  static const String domainFieldHelpText = 'Teks Bantuan';
  static const String domainFieldOptions = 'Opsi';
  static const String domainFieldAddOption = 'Tambah Opsi';
  static const String domainFieldNoOptions = 'Belum ada opsi.';
  static const String domainFieldOptionLabel = 'Label Opsi';
  static const String domainFieldOptionValue = 'Nilai Opsi';
  static const String domainFieldRelatedDomain = 'Domain Terkait';

  // Media Manager
  static const String mediaTitle = 'Media Manager';
  static const String menuMedia = 'Media';
  static const String mediaUpload = 'Upload Media';
  static const String mediaSearch = 'Cari media...';
  static const String mediaDelete = 'Hapus Media';
  static const String mediaDeleteConfirm =
      'Apakah Anda yakin ingin menghapus media';
  static const String mediaUploaded = 'Media berhasil diunggah';
  static const String mediaUpdated = 'Media berhasil diperbarui';
  static const String mediaDeleted = 'Media berhasil dihapus';
  static const String mediaAltText = 'Alt Text';
  static const String mediaAltTextHint = 'Deskripsi alternatif gambar';
  static const String mediaCaption = 'Caption';
  static const String mediaCaptionHint = 'Caption file (opsional)';
  static const String mediaFolder = 'Folder';
  static const String mediaFolderHint = 'Nama folder (opsional)';
  static const String mediaFileUrl = 'URL File';
  static const String mediaFileUrlHint = 'https://example.com/file.jpg';
  static const String mediaFileUrlRequired = 'URL file wajib diisi';
  static const String mediaFileName = 'Nama File';
  static const String mediaFileNameHint = 'gambar.jpg';
  static const String mediaFileNameRequired = 'Nama file wajib diisi';
  static const String mediaFileSize = 'Ukuran';
  static const String mediaDimensions = 'Dimensi';
  static const String mediaMimeType = 'Tipe';
  static const String mediaCopyUrl = 'Salin URL';
  static const String mediaUrlCopied = 'URL berhasil disalin';
  static const String mediaTypeFilter = 'Tipe File';
  static const String mediaAllTypes = 'Semua Tipe';
  static const String mediaImages = 'Gambar';
  static const String mediaDocuments = 'Dokumen';
  static const String mediaVideos = 'Video';
  static const String mediaAllFolders = 'Semua Folder';
  static const String mediaPickerTitle = 'Pilih Media';

  // Domain Records
  static const String domainRecordAdd = 'Tambah';
  static const String domainRecordEdit = 'Edit';
  static const String domainRecordDelete = 'Hapus Record';
  static const String domainRecordDeleteConfirm =
      'Apakah Anda yakin ingin menghapus record ini?';
  static const String domainRecordSearch = 'Cari';
  static const String domainRecordCreated = 'Record berhasil dibuat';
  static const String domainRecordUpdated = 'Record berhasil diperbarui';
  static const String domainRecordDeleted = 'Record berhasil dihapus';

  // User Management
  static const String menuUserManagement = 'Pengguna';
  static const String userManagementTitle = 'Manajemen Pengguna';
  static const String userAdd = 'Tambah User';
  static const String userEdit = 'Edit User';
  static const String userDelete = 'Hapus User';
  static const String userDeleteConfirm =
      'Apakah Anda yakin ingin menghapus user';
  static const String userSearch = 'Cari pengguna...';
  static const String userCreated = 'User berhasil dibuat';
  static const String userUpdated = 'User berhasil diperbarui';
  static const String userDeleted = 'User berhasil dihapus';

  // User Management - Table Columns
  static const String userColumnName = 'Nama';
  static const String userColumnEmail = 'Email';
  static const String userColumnRole = 'Role';
  static const String userColumnStatus = 'Status';
  static const String userColumnLastLogin = 'Login Terakhir';

  // User Management - Form
  static const String userInfoSection = 'Informasi User';
  static const String userFullNameLabel = 'Nama Lengkap';
  static const String userFullNameHint = 'Masukkan nama lengkap';
  static const String userFullNameRequired = 'Nama lengkap wajib diisi';
  static const String userAvatarUrlLabel = 'Avatar URL';
  static const String userAvatarUrlHint = 'https://example.com/avatar.jpg';
  static const String userRoleLabel = 'Role';
  static const String userActiveLabel = 'Status Aktif';
  static const String userAllRoles = 'Semua Role';
  static const String userAllStatuses = 'Semua Status';

  // User Management - Status
  static const String userStatusActive = 'Aktif';
  static const String userStatusInactive = 'Nonaktif';
  static const String userActivate = 'Aktifkan';
  static const String userDeactivate = 'Nonaktifkan';

  // User Management - Password
  static const String userResetPassword = 'Reset Password';
  static const String userNewPasswordLabel = 'Password Baru';
  static const String userNewPasswordHint = 'Masukkan password baru';
  static const String userConfirmPasswordLabel = 'Konfirmasi Password';
  static const String userConfirmPasswordHint = 'Masukkan ulang password';
  static const String userConfirmPasswordRequired =
      'Konfirmasi password wajib diisi';
  static const String userPasswordMismatch = 'Password tidak cocok';
  static const String userPasswordResetSuccess = 'Password berhasil direset';

  // ─── Settings (Pengaturan Situs) ───
  static const String settingsTitle = 'Pengaturan Situs';
  static const String menuSettings = 'Pengaturan Situs';
  static const String settingsSaved = 'Pengaturan berhasil disimpan';

  // Settings - Section Titles
  static const String settingsSectionGeneral = 'Umum';
  static const String settingsSectionSeo = 'SEO Default';
  static const String settingsSectionAppearance = 'Tampilan';
  static const String settingsSectionIntegration = 'Integrasi';
  static const String settingsSectionMaintenance = 'Maintenance';

  // Settings - General
  static const String settingsSiteName = 'Nama Situs';
  static const String settingsSiteNameHint = 'Masukkan nama situs';
  static const String settingsSiteNameRequired = 'Nama situs wajib diisi';
  static const String settingsSiteDescription = 'Deskripsi Situs';
  static const String settingsSiteDescriptionHint = 'Deskripsi singkat situs';
  static const String settingsSiteUrl = 'URL Situs';
  static const String settingsSiteUrlHint = 'https://example.com';
  static const String settingsLogoUrl = 'URL Logo';
  static const String settingsLogoUrlHint = 'https://example.com/logo.png';
  static const String settingsFaviconUrl = 'URL Favicon';
  static const String settingsFaviconUrlHint = 'https://example.com/favicon.ico';

  // Settings - SEO
  static const String settingsDefaultMetaTitle = 'Meta Title Default';
  static const String settingsDefaultMetaTitleHint = 'Judul default untuk SEO';
  static const String settingsDefaultMetaDescription = 'Meta Description Default';
  static const String settingsDefaultMetaDescriptionHint =
      'Deskripsi default untuk SEO';
  static const String settingsDefaultOgImage = 'OG Image Default';
  static const String settingsDefaultOgImageHint =
      'https://example.com/og-image.jpg';

  // Settings - Appearance
  static const String settingsPrimaryColor = 'Warna Primer';
  static const String settingsPrimaryColorHint = '#1565C0';
  static const String settingsSecondaryColor = 'Warna Sekunder';
  static const String settingsSecondaryColorHint = '#00897B';
  static const String settingsFooterText = 'Teks Footer';
  static const String settingsFooterTextHint = 'Copyright 2024 Vernon CMS';

  // Settings - Integration
  static const String settingsGoogleAnalyticsId = 'Google Analytics ID';
  static const String settingsGoogleAnalyticsIdHint = 'UA-XXXXXXXXX-X atau G-XXXXXXXXXX';
  static const String settingsCustomHeadCode = 'Custom Head Code';
  static const String settingsCustomHeadCodeHint =
      'Kode yang akan diinjeksi ke <head>';
  static const String settingsCustomBodyCode = 'Custom Body Code';
  static const String settingsCustomBodyCodeHint =
      'Kode yang akan diinjeksi sebelum </body>';

  // Settings - Maintenance
  static const String settingsMaintenanceMode = 'Mode Maintenance';
  static const String settingsMaintenanceModeHint =
      'Aktifkan untuk menonaktifkan situs sementara';
  static const String settingsMaintenanceMessage = 'Pesan Maintenance';
  static const String settingsMaintenanceMessageHint =
      'Situs sedang dalam perbaikan. Silakan coba lagi nanti.';

  // ─── Activity Log ───
  static const String activityLogTitle = 'Log Aktivitas';
  static const String menuActivityLog = 'Log Aktivitas';
  static const String activityLogSearch = 'Cari log...';
  static const String activityLogAction = 'Aksi';
  static const String activityLogAllActions = 'Semua Aksi';
  static const String activityLogEntityType = 'Tipe Entitas';
  static const String activityLogAllEntityTypes = 'Semua Tipe';

  // ─── API Token ───
  static const String apiTokenTitle = 'API Token';
  static const String menuApiToken = 'API Token';
  static const String apiTokenCreate = 'Buat Token';
  static const String apiTokenEdit = 'Edit Token';
  static const String apiTokenRevoke = 'Cabut Token';
  static const String apiTokenRevokeConfirm =
      'Apakah Anda yakin ingin mencabut token';
  static const String apiTokenCreated = 'Token Berhasil Dibuat';
  static const String apiTokenUpdated = 'Token berhasil diperbarui';
  static const String apiTokenDeleted = 'Token berhasil dihapus';
  static const String apiTokenWarning =
      'Token hanya ditampilkan sekali. Salin dan simpan token ini di tempat yang aman.';
  static const String apiTokenCopyButton = 'Salin Token';
  static const String apiTokenCopied = 'Token berhasil disalin';
  static const String apiTokenName = 'Nama Token';
  static const String apiTokenNameHint = 'Contoh: Mobile App Token';
  static const String apiTokenNameRequired = 'Nama token wajib diisi';
  static const String apiTokenPermissions = 'Permissions';
  static const String apiTokenExpiry = 'Tanggal Kedaluwarsa';
  static const String apiTokenNoExpiry = 'Tanpa Batas';
  static const String apiTokenActive = 'Aktif';
  static const String apiTokenInactive = 'Nonaktif';
  static const String apiTokenActivate = 'Aktifkan';
  static const String apiTokenDeactivate = 'Nonaktifkan';

  // API Token - Table Columns
  static const String apiTokenColumnName = 'Nama';
  static const String apiTokenColumnPrefix = 'Token Prefix';
  static const String apiTokenColumnPermissions = 'Permissions';
  static const String apiTokenColumnStatus = 'Status';
  static const String apiTokenColumnLastUsed = 'Terakhir Digunakan';
  static const String apiTokenColumnExpires = 'Kedaluwarsa';
}
