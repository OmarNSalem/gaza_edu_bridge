import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';
import '../widgets/social_auth_button.dart';
import '../widgets/email_auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isEmailMode = false;
  bool _isSignUp = false;

  void _onGoogleSignIn() {
    context.go(RouteNames.home);
  }

  void _onGuestSignIn() {
    context.go(RouteNames.home);
  }

  void _onEmailSubmit(String email, String password) {
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // اللوجو والعنوان
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppBorderRadius.roundedXl,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'جسر التعليم في غزة',
                  style: AppTextStyles.headerTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'اختر طريقة الدخول لمتابعة الدروس والملفات',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                if (!_isEmailMode) ...[
                  // 1. زر الدخول عبر Google
                  SocialAuthButton(
                    label: 'المتابعة باستخدام Google',
                    icon: const Icon(Icons.g_mobiledata_rounded,
                        size: 28, color: AppColors.primary),
                    onPressed: _onGoogleSignIn,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // 2. زر الدخول عبر البريد الإلكتروني
                  SocialAuthButton(
                    label: 'الدخول بالبريد الإلكتروني',
                    icon: const Icon(Icons.mail_outline_rounded,
                        size: 20, color: AppColors.primary),
                    onPressed: () => setState(() => _isEmailMode = true),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // 3. زر وضع الضيف
                  SocialAuthButton(
                    label: 'الدخول كضيف (بدون حساب)',
                    icon: const Icon(Icons.person_outline_rounded,
                        size: 20, color: AppColors.mutedText),
                    backgroundColor: AppColors.secondary,
                    borderColor: AppColors.border,
                    onPressed: _onGuestSignIn,
                  ),
                ] else ...[
                  // نموذج البريد
                  EmailAuthForm(
                    isSignUp: _isSignUp,
                    onSubmit: _onEmailSubmit,
                    onToggleMode: () => setState(() => _isSignUp = !_isSignUp),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton.icon(
                    onPressed: () => setState(() => _isEmailMode = false),
                    icon: const Icon(Icons.arrow_back_rounded, size: 16),
                    label: const Text('العودة لخيارات الدخول'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
