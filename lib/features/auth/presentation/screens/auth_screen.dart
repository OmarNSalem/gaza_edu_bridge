import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaza_edu_bridge/core/router/route_names.dart';
import 'package:gaza_edu_bridge/core/theme/app_border_radius.dart';
import 'package:gaza_edu_bridge/core/theme/app_colors.dart';
import 'package:gaza_edu_bridge/core/theme/app_spacing.dart';
import 'package:gaza_edu_bridge/core/theme/app_text_styles.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _showEmailForm = false;
  bool _isRegister = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _openEmailForm({required bool register}) {
    setState(() {
      _isRegister = register;
      _showEmailForm = true;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _nameController.clear();
    });
  }

  // Mock auth — يُستبدل في PHASE 3 بـ Firebase
  void _handleAuth(String type) {
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    // الشعار والترحيب
                    _buildLogo(),
                    const SizedBox(height: 40),
                    // محتوى النموذج
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.05),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _showEmailForm
                          ? _buildEmailForm()
                          : _buildMainButtons(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.school_outlined,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('GazaEdu Bridge', style: AppTextStyles.cardTitle.copyWith(fontSize: 20)),
        const SizedBox(height: 4),
        Text('مرحباً بك', style: AppTextStyles.bodySmall),
      ],
    );
  }

  Widget _buildMainButtons() {
    return Column(
      key: const ValueKey('main'),
      children: [
        // زر Google
        _GoogleButton(onTap: () => _handleAuth('google')),
        const SizedBox(height: AppSpacing.sm),
        // تسجيل دخول + إنشاء حساب جنباً لجنب
        Row(
          children: [
            Expanded(
              child: _OutlineButton(
                label: 'تسجيل دخول',
                icon: Icons.mail_outline_rounded,
                onTap: () => _openEmailForm(register: false),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _GradientButton(
                label: 'إنشاء حساب',
                icon: Icons.person_outline_rounded,
                onTap: () => _openEmailForm(register: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // فاصل
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text('أو تابع بدون حساب', style: AppTextStyles.badgeText),
            ),
            const Expanded(child: Divider(color: AppColors.border)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // زر الضيف
        _GuestButton(onTap: () => _handleAuth('guest')),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Column(
      key: const ValueKey('email'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // رأس النموذج
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () => setState(() => _showEmailForm = false),
              icon: const Icon(Icons.chevron_right, size: 18, color: AppColors.mutedText),
              label: Text('رجوع', style: AppTextStyles.bodySmall),
            ),
            Text(
              _isRegister ? 'إنشاء حساب جديد' : 'تسجيل الدخول',
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // حقل الاسم - عند التسجيل فقط
        if (_isRegister) ...[
          _InputField(
            controller: _nameController,
            hint: 'الاسم الكامل',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        _InputField(
          controller: _emailController,
          hint: 'البريد الإلكتروني',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          isRtl: false,
        ),
        const SizedBox(height: AppSpacing.sm),
        _InputField(
          controller: _passwordController,
          hint: 'كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          isRtl: false,
        ),
        if (_isRegister) ...[
          const SizedBox(height: AppSpacing.sm),
          _InputField(
            controller: _confirmPasswordController,
            hint: 'تأكيد كلمة المرور',
            icon: Icons.lock_outline_rounded,
            isPassword: true,
            isRtl: false,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        // زر الإرسال
        SizedBox(
          width: double.infinity,
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: AppBorderRadius.roundedXl,
            ),
            child: ElevatedButton(
              onPressed: () => _handleAuth('email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.roundedXl,
                ),
              ),
              child: Text(
                _isRegister ? 'إنشاء الحساب' : 'تسجيل الدخول',
                style: AppTextStyles.buttonText,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // تبديل بين تسجيل الدخول والتسجيل
        Center(
          child: TextButton(
            onPressed: () => setState(() => _isRegister = !_isRegister),
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.badgeText,
                children: [
                  TextSpan(
                    text: _isRegister ? 'لديك حساب بالفعل؟ ' : 'ليس لديك حساب؟ ',
                  ),
                  TextSpan(
                    text: _isRegister ? 'تسجيل الدخول' : 'إنشاء حساب',
                    style: AppTextStyles.badgeText.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

// ─── Sub Widgets ──────────────────────────────────────────────────────────────

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.cardBg,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.roundedXl,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GoogleLogo(),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'متابعة بحساب Google',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    // G حرف بسيط بألوان Google
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -0.4, 1.6, true, paint,
    );
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      1.2, 1.6, true, paint,
    );
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      2.8, 1.6, true, paint,
    );
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      4.4, 1.6, true, paint,
    );
    // المركز الأبيض
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.28,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: AppBorderRadius.roundedXl,
        ),
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 18, color: Colors.white),
          label: Text(label, style: AppTextStyles.buttonText.copyWith(fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: AppBorderRadius.roundedXl,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: AppColors.mutedText),
        label: Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.cardBg,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.roundedXl,
          ),
        ),
      ),
    );
  }
}

class _GuestButton extends StatelessWidget {
  const _GuestButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFEBF2EE),
          side: const BorderSide(color: Color(0xFFC5DACC), width: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.roundedXl,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFC5DACC),
                borderRadius: AppBorderRadius.roundedMd,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                size: 16,
                color: AppColors.mutedText,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'متابعة كضيف',
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'بدون تسجيل — مؤقت',
                  style: AppTextStyles.badgeText.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatefulWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.isRtl = true,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool isRtl;
  final TextInputType? keyboardType;

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      textDirection: widget.isRtl ? TextDirection.rtl : TextDirection.ltr,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
        prefixIcon: Icon(widget.icon, color: AppColors.mutedText, size: 20),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.mutedText,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        filled: true,
        fillColor: AppColors.cardBg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.roundedXl,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.roundedXl,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.roundedXl,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
