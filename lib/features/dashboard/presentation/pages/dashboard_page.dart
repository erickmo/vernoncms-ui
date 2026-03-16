import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/jwt_decoder.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';

/// Halaman dashboard utama CMS — minimalist & elegant.
///
/// Mengambil data ringkasan dari API yang sudah ada (contents, categories,
/// pages) tanpa memerlukan endpoint dashboard khusus.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loading = true;
  int _contentCount = 0;
  int _categoryCount = 0;
  int _pageCount = 0;
  int _publishedCount = 0;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadCounts();
  }

  void _loadUserInfo() {
    final token = getIt<AuthLocalDataSource>().getAccessToken();
    if (token != null) {
      _userName = JwtDecoder.getEmail(token) ?? '';
    }
  }

  Future<void> _loadCounts() async {
    setState(() => _loading = true);
    final dio = getIt<ApiClient>().dio;

    try {
      final results = await Future.wait([
        dio.get('/api/v1/contents?page=1&limit=1').catchError((_) =>
            Response(requestOptions: RequestOptions(), data: {'data': {'total': 0}})),
        dio.get('/api/v1/content-categories?page=1&limit=1').catchError((_) =>
            Response(requestOptions: RequestOptions(), data: {'data': {'total': 0}})),
        dio.get('/api/v1/pages?page=1&limit=1').catchError((_) =>
            Response(requestOptions: RequestOptions(), data: {'data': {'total': 0}})),
        dio.get('/api/v1/contents?page=1&limit=1&status=published').catchError((_) =>
            Response(requestOptions: RequestOptions(), data: {'data': {'total': 0}})),
      ]);

      if (mounted) {
        setState(() {
          _contentCount = _extractTotal(results[0]);
          _categoryCount = _extractTotal(results[1]);
          _pageCount = _extractTotal(results[2]);
          _publishedCount = _extractTotal(results[3]);
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  int _extractTotal(Response response) {
    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final inner = data['data'];
        if (inner is Map<String, dynamic>) {
          return (inner['total'] as num?)?.toInt() ?? 0;
        }
      }
    } catch (_) {}
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _getGreeting(now);
    final dateStr = DateFormat('EEEE, d MMMM yyyy').format(now);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(greeting, dateStr),
          const SizedBox(height: AppDimensions.spacingXL),
          if (_loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.spacingXL),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else ...[
            _buildStatsRow(context),
            const SizedBox(height: AppDimensions.spacingXL),
            _buildQuickActions(context),
          ],
        ],
      ),
    );
  }

  Widget _buildGreeting(String greeting, String dateStr) {
    final displayName = _userName.split('@').first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting${displayName.isNotEmpty ? ', $displayName' : ''}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXS),
        Text(
          dateStr,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textHint,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 900;

    final items = [
      _StatItem(
        label: AppStrings.totalPosts,
        value: _contentCount.toString(),
        icon: Icons.article_outlined,
        color: AppColors.primary,
      ),
      _StatItem(
        label: 'Published',
        value: _publishedCount.toString(),
        icon: Icons.check_circle_outline,
        color: AppColors.success,
      ),
      _StatItem(
        label: AppStrings.contentCategoryTitle,
        value: _categoryCount.toString(),
        icon: Icons.category_outlined,
        color: AppColors.secondary,
      ),
      _StatItem(
        label: AppStrings.pageListTitle,
        value: _pageCount.toString(),
        icon: Icons.web_outlined,
        color: AppColors.info,
      ),
    ];

    if (isWide) {
      return Row(
        children: items
            .map((item) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: item == items.last ? 0 : AppDimensions.spacingM,
                    ),
                    child: _buildStatCard(item),
                  ),
                ))
            .toList(),
      );
    }

    return Wrap(
      spacing: AppDimensions.spacingM,
      runSpacing: AppDimensions.spacingM,
      children: items
          .map((item) => SizedBox(
                width: (screenWidth - AppDimensions.spacingXL * 2 - AppDimensions.spacingM) / 2,
                child: _buildStatCard(item),
              ))
          .toList(),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.color, size: 20),
          const SizedBox(height: AppDimensions.spacingM),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aksi Cepat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        Wrap(
          spacing: AppDimensions.spacingS,
          runSpacing: AppDimensions.spacingS,
          children: [
            _buildActionChip(
              icon: Icons.add,
              label: 'Buat Konten',
              onTap: () => context.go('/content/create'),
            ),
            _buildActionChip(
              icon: Icons.web_outlined,
              label: 'Kelola Halaman',
              onTap: () => context.go('/pages'),
            ),
            _buildActionChip(
              icon: Icons.category_outlined,
              label: 'Kategori',
              onTap: () => context.go('/content-category'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
            vertical: AppDimensions.spacingS + 2,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: AppDimensions.spacingS),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting(DateTime now) {
    final hour = now.hour;
    if (hour < 12) return 'Selamat Pagi';
    if (hour < 17) return 'Selamat Siang';
    return 'Selamat Malam';
  }
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}
