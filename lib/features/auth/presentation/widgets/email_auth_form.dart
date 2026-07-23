import 'package:flutter/material.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class EmailAuthForm extends StatefulWidget {
  const EmailAuthForm({
    super.key,
    required this.isSignUp,
    required this.onSubmit,
    required this.onToggleMode,
  });

  final bool isSignUp;
  final Function(String email, String password) onSubmit;
  final VoidCallback onToggleMode;

  @override
  State<EmailAuthForm> createState() => _EmailAuthFormState();
}

class _EmailAuthFormState extends State<EmailAuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // البريد الإلكتروني
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              hintText: 'name@example.com',
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
              filled: true,
              fillColor: AppColors.cardBg,
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedXl,
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
              if (!v.contains('@')) return 'بريد إلكتروني غير صالح';
              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // كلمة المرور
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              prefixIcon: const Icon(Icons.lock_outline, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              filled: true,
              fillColor: AppColors.cardBg,
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.roundedXl,
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'يرجى إدخال كلمة المرور';
              if (v.length < 6) return 'يجب أن تكون 6 أحرف على الأقل';
              return null;
            },
          ),

          if (widget.isSignUp) ...[
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                filled: true,
                fillColor: AppColors.cardBg,
                border: OutlineInputBorder(
                  borderRadius: AppBorderRadius.roundedXl,
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              validator: (v) {
                if (v != _passwordController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.roundedXl,
              ),
            ),
            child: Text(
              widget.isSignUp ? 'إنشاء حساب جديد' : 'تسجيل الدخول',
              style: AppTextStyles.buttonText,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          TextButton(
            onPressed: widget.onToggleMode,
            child: Text(
              widget.isSignUp
                  ? 'لديك حساب بالفعل؟ سجل دخولك'
                  : 'ليس لديك حساب؟ أنشئ حساباً جديداً',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
