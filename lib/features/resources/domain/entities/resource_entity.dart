import 'package:equatable/equatable.dart';

enum ResourceCategory { book, summary, exam }

class ResourceEntity extends Equatable {
  const ResourceEntity({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.category,
    required this.fileSizeMb,
    required this.pageCount,
    required this.downloadUrl,
    this.isDownloaded = false,
  });

  final String id;
  final String subjectId;
  final String title;
  final String description;
  final ResourceCategory category;
  final double fileSizeMb;
  final int pageCount;
  final String downloadUrl;
  final bool isDownloaded;

  ResourceEntity copyWith({bool? isDownloaded}) {
    return ResourceEntity(
      id: id,
      subjectId: subjectId,
      title: title,
      description: description,
      category: category,
      fileSizeMb: fileSizeMb,
      pageCount: pageCount,
      downloadUrl: downloadUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  @override
  List<Object?> get props => [id, subjectId, title, category, isDownloaded];
}
