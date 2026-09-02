import 'dart:async';
import 'package:careerguidance_app/Controller/AuthController.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class _PFDerived {
  static const fieldBorder = Color(0xFF2B3348);

  static const error = Color(0xFFFF6B6B);
  static const errorText = Color(0xFFFF8A8A);

  static final successChipBg = AppColors.orangeStart.withOpacity(0.10);
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showSuccess = false;
  bool _isSubmitting = false;
  String? _errorText;
  String _sentToEmail = '';

  int _resendCooldown = 0;
  Timer? _resendTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final value = _emailController.text.trim();

    if (value.isEmpty) {
      setState(() => _errorText = 'Enter the email or phone on your account.');
      return;
    }

    setState(() {
      _errorText = null;
      _isSubmitting = true;
    });

    try {
      await AuthController.instance.sendPasswordResetEmail(email: value);

      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
        _sentToEmail = value;
        _showSuccess = true;
      });

      _startResendCooldown();
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = 'Something went wrong. Please try again.';
      });
    }
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    setState(() => _resendCooldown = 30);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_resendCooldown <= 1) {
        setState(() => _resendCooldown = 0);
        timer.cancel();
        return;
      }
      setState(() => _resendCooldown--);
    });
  }

  Future<void> _handleResend() async {
    if (_resendCooldown > 0) return;

    try {
      await AuthController.instance.sendPasswordResetEmail(email: _sentToEmail);
      _startResendCooldown();
    } on AuthException catch (e) {
      _showSnack(e.message);
    } catch (e) {
      _showSnack('Something went wrong. Please try again.');
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.field,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrand(),
                  const SizedBox(height: 28),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _showSuccess
                        ? _buildSuccessView(key: const ValueKey('success'))
                        : _buildFormView(key: const ValueKey('form')),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.orangeGradient,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Icon(
              Icons.change_history,
              size: 16,
              color: AppColors.background,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Pathfind',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFormView({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).maybePop(),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: AppColors.mutedText,
          ),
          icon: const Icon(Icons.arrow_back, size: 16),
          label: const Text('Back to log in', style: TextStyle(fontSize: 14)),
        ),
        const SizedBox(height: 12),
        const Text(
          'Forgot your password?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "No worries — enter the email or phone linked to your account and we'll send you a link to reset it.",
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'EMAIL OR PHONE',
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          onChanged: (_) {
            if (_errorText != null) setState(() => _errorText = null);
          },
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(color: AppColors.hintText),
            filled: true,
            fillColor: AppColors.field,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: _PFDerived.fieldBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: _errorText != null
                    ? _PFDerived.error
                    : _PFDerived.fieldBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: _errorText != null
                    ? _PFDerived.error
                    : AppColors.accentYellow,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (_errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            _errorText!,
            style: const TextStyle(color: _PFDerived.errorText, fontSize: 13),
          ),
        ],
        const SizedBox(height: 20),
        _buildGradientButton(
          label: 'Send reset link',
          onPressed: _isSubmitting ? null : _handleSubmit,
          loading: _isSubmitting,
        ),
        const SizedBox(height: 16),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.mutedText, fontSize: 14),
              children: [
                const TextSpan(text: 'Remembered it? '),
                TextSpan(
                  text: 'Log in',
                  style: const TextStyle(
                    color: AppColors.accentYellow,
                    fontWeight: FontWeight.w700,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: _PFDerived.successChipBg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            color: AppColors.accentYellow,
            size: 24,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Check your inbox.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 14,
              height: 1.45,
            ),
            children: [
              const TextSpan(text: 'We sent a password reset link to '),
              TextSpan(
                text: _sentToEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(
                text: ". It'll expire in 15 minutes, so don't wait too long.",
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.field,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _PFDerived.fieldBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Didn't get it? Check spam, or",
                  style: TextStyle(color: AppColors.mutedText, fontSize: 14),
                ),
              ),
              TextButton(
                onPressed: _resendCooldown > 0 ? null : _handleResend,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: AppColors.accentYellow,
                  disabledForegroundColor: AppColors.hintText,
                ),
                child: Text(
                  _resendCooldown > 0
                      ? 'Resend in ${_resendCooldown}s'
                      : 'Resend link',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildGradientButton(
          label: 'Back to log in',
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ],
    );
  }

  Widget _buildGradientButton({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressed == null && !loading
              ? null
              : AppColors.orangeGradient,
          color: onPressed == null && !loading ? _PFDerived.fieldBorder : null,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(29),
            onTap: onPressed,
            child: Center(
              child: loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.background,
                      ),
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                        color: Color(0xFF1A0E08),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
