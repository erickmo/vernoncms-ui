import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../domain/entities/media_file.dart';

/// Card tunggal untuk menampilkan file media dalam grid.
class MediaCard extends StatelessWidget {
  /// File media yang ditampilkan.
  final MediaFile file;

  /// Callback saat card ditekan.
  final VoidCallback onTap;

  const MediaCard({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildThumbnail(),
            ),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (_isImage) {
      final url = file.thumbnailUrl ?? file.fileUrl;
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => _buildIconPlaceholder(),
      );
    }
    return _buildIconPlaceholder();
  }

  Widget _buildIconPlaceholder() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Icon(
          _mimeTypeIcon,
          size: AppDimensions.avatarL,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            file.fileName,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimensions.spacingXS),
          Row(
            children: [
              Text(
                _formatFileSize(file.fileSize),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(file.createdAt),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get _isImage => file.mimeType.startsWith('image/');

  IconData get _mimeTypeIcon {
    if (file.mimeType.startsWith('image/')) return Icons.photo;
    if (file.mimeType == 'application/pdf') return Icons.picture_as_pdf;
    if (file.mimeType.startsWith('video/')) return Icons.videocam;
    if (file.mimeType.contains('word') ||
        file.mimeType.contains('document') ||
        file.mimeType.contains('text/')) {
      return Icons.description;
    }
    return Icons.insert_drive_file;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
