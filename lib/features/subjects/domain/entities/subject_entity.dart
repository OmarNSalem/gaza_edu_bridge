import 'package:equatable/equatable.dart';

enum SchoolLevel { primary, middle, high }

enum SubjectBranch { science, arts }

class SubjectEntity extends Equatable {
  const SubjectEntity({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.level,
    required this.grade,
    required this.icon,
    required this.colorHex,
    required this.resourceCount,
    this.branch,
  });

  final String id;
  final String name;
  final String nameEn;
  final SchoolLevel level;
  final int grade;
  final String icon;
  final String colorHex;
  final int resourceCount;
  final SubjectBranch? branch;

  @override
  List<Object?> get props => [id, name, level, grade, branch];
}
