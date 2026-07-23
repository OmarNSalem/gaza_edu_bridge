import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import 'package:gaza_edu_bridge/features/resources/domain/entities/resource_entity.dart';
import 'package:gaza_edu_bridge/shared/widgets/app_header.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  // قائمة تجريبية بالملفات المحمّلة محلياً
  final List<ResourceEntity> _downloadedFiles = [
    const ResourceEntity(
      id: 'res-1',
      subjectId: 'math-h12-sci',
      title: 'كتاب الرياضيات - الجزء الأول (الوزاري)',
      description: 'الكتاب المدرسي المعتمد لوزارة التربية والتعليم للفرع العلمي.',
      category: ResourceCategory.book,
      fileSizeMb: 14.2,
      pageCount: 180,
      downloadUrl: 'https://example.com/math1.pdf',
      isDownloaded: true,
    ),
    const ResourceEntity(
      id: 'res-2',
      subjectId: 'math-h12-sci',
      title: 'ملخص وحلول وحدة التفاضل والتكامل',
      description: 'شرح مفصل بالأمثلة والحلول النموذجية.',
      category: ResourceCategory.summary,
      fileSizeMb: 5.8,
      pageCount: 45,
      downloadUrl: 'https://example.com/math_summary.pdf',
      isDownloaded: true,
    ),
    const ResourceEntity(
      id: 'res-4',
      subjectId: 'physics-h12-sci',
      title: 'كتاب الفيزياء الوزاري - توجيهي',
      description: 'الكتاب المعتمد شاملاً فصول الميكانيكا والكهرباء.',
      category: ResourceCategory.book,
      fileSizeMb: 16.5,
      pageCount: 210,
      downloadUrl: 'https://example.com/physics_book.pdf',
      isDownloaded: true,
    ),
  ];

  double get _totalStorageMb {
    return _downloadedFiles.fold(0.0, (sum, item) => sum + item.fileSizeMb);
  }

  void _deleteFile(ResourceEntity file) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.roundedXl,
          ),
          title: const Text('حذف الملف المحمّل'),
          content: Text('هل أنت تأكد من حذف "${file.title}"؟ ستحتاج إلى إنترنت لإعادة تنزيله.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _downloadedFiles.removeWhere((item) => item.id == file.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم حذف ${file.title} من الجهاز'),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }

  void _clearAll() {
    if (_downloadedFiles.isEmpty) return;
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.roundedXl,
          ),
          title: const Text('حذف جميع التنزيلات'),
          content: const Text('هل تريد حذف جميع الملفات المحمّلة وإخلاء المساحة؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _downloadedFiles.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إخلاء جميع التنزيلات بنجاح'),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('حذف الكل'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'تنزيلاتي',
        subtitle: 'المكتبة المحلية أوفلاين',
        actions: [
          if (_downloadedFiles.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.error),
              tooltip: 'حذف الكل',
              onPressed: _clearAll,
            ),
        ],
      ),
      body: Column(
        children: [
          // ── Storage Bar Banner ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.cardBg,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: AppBorderRadius.roundedXl,
                  ),
                  child: const Icon(Icons.offline_pin_outlined, size: 24, color: AppColors.success),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('جميع الملفات تعمل بدون إنترنت',
                          style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(
                        'المساحة المستهلكة: ${_totalStorageMb.toStringAsFixed(1)} ميجابايت (${_downloadedFiles.length} ملفات)',
                        style: AppTextStyles.badgeText.copyWith(color: AppColors.mutedText, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Downloaded Files List ──
          Expanded(
            child: _downloadedFiles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.download_for_offline_outlined,
                              size: 36, color: AppColors.mutedText),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('لا توجد ملفات محمّلة حالياً', style: AppTextStyles.cardTitle),
                        const SizedBox(height: 4),
                        Text(
                          'تصفح المواد وقُم بتنزيل الكتب والملخصات لقراءتها بدون اتصال بالإنترنت',
                          style: AppTextStyles.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _downloadedFiles.length,
                    itemBuilder: (context, index) {
                      final file = _downloadedFiles[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _DownloadedFileCard(
                          file: file,
                          onOpen: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('جاري قراءة: ${file.title} (أوفلاين)'),
                                backgroundColor: AppColors.primary,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onDelete: () => _deleteFile(file),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Downloaded File Card Widget ─────────────────────────────────────────────

class _DownloadedFileCard extends StatelessWidget {
  const _DownloadedFileCard({
    required this.file,
    required this.onOpen,
    required this.onDelete,
  });

  final ResourceEntity file;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: AppBorderRadius.roundedXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: AppBorderRadius.roundedLg,
                ),
                child: const Icon(Icons.picture_as_pdf_rounded, size: 20, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.title,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      file.description,
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                onPressed: onDelete,
                tooltip: 'حذف الملف',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: AppBorderRadius.roundedSm,
                    ),
                    child: Text(
                      '${file.fileSizeMb} MB',
                      style: AppTextStyles.badgeText.copyWith(fontSize: 10, color: AppColors.mutedText),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: AppBorderRadius.roundedSm,
                    ),
                    child: Text(
                      'جاهز أوفلاين',
                      style: AppTextStyles.badgeText.copyWith(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onOpen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.roundedLg,
                  ),
                ),
                icon: const Icon(Icons.menu_book_rounded, size: 16),
                label: Text('قراءة', style: AppTextStyles.badgeText.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
