import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../router/route_names.dart';

/// الـ Shell الرئيسي يحتوي BottomNavigationBar بـ 4 تابات
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => _onTabTap(context, index),
            backgroundColor: AppColors.card,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.mutedForeground,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedLabelStyle:
                AppTextStyles.mini.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: AppTextStyles.mini,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                activeIcon: Icon(Icons.menu_book),
                label: 'المواد',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                activeIcon: Icon(Icons.assignment),
                label: 'اختبار',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.download_outlined),
                activeIcon: Icon(Icons.download),
                label: 'تنزيلاتي',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// تحويل المسار الحالي لـ index التاب المقابل
  int _locationToIndex(String location) {
    if (location.startsWith(RouteNames.browse)) return 1;
    if (location.startsWith(RouteNames.quiz)) return 2;
    if (location.startsWith(RouteNames.downloads)) return 3;
    return 0;
  }

  /// التنقل عند الضغط على تاب
  void _onTabTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
      case 1:
        context.go(RouteNames.browse);
      case 2:
        context.go(RouteNames.quiz);
      case 3:
        context.go(RouteNames.downloads);
    }
  }
}
