import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/daily_content.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/daily_content_chart.dart';
import '../widgets/stats_card.dart';

/// Halaman dashboard utama CMS.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>()..loadDashboard(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (stats, dailyContent) =>
            _buildContent(context, stats, dailyContent),
        error: (message) => _buildError(context, message),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    DashboardStats stats,
    List<DailyContent> dailyContent,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcome(),
          const SizedBox(height: AppDimensions.spacingL),
          _buildStatsGrid(context, stats),
          const SizedBox(height: AppDimensions.spacingL),
          DailyContentChart(data: dailyContent),
        ],
      ),
    );
  }

  Widget _buildWelcome() => const Text(
        AppStrings.dashboardWelcome,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      );

  Widget _buildStatsGrid(BuildContext context, DashboardStats stats) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth >= 1200 ? 3 : (screenWidth >= 768 ? 2 : 1);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: AppDimensions.spacingM,
      mainAxisSpacing: AppDimensions.spacingM,
      childAspectRatio: 2.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatsCard(
          icon: Icons.article_outlined,
          iconColor: AppColors.primary,
          title: AppStrings.totalPosts,
          value: _formatNumber(stats.totalPosts),
        ),
        StatsCard(
          icon: Icons.visibility_outlined,
          iconColor: AppColors.info,
          title: AppStrings.totalVisits,
          value: _formatNumber(stats.totalVisits),
        ),
        StatsCard(
          icon: Icons.trending_up,
          iconColor: AppColors.success,
          title: AppStrings.todayVisits,
          value: _formatNumber(stats.todayVisits),
          growthPercent: stats.visitGrowthPercent,
          subtitle: 'vs kemarin',
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context, String message) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimensions.avatarL,
              color: AppColors.error,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            ElevatedButton(
              onPressed: () =>
                  context.read<DashboardCubit>().loadDashboard(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
