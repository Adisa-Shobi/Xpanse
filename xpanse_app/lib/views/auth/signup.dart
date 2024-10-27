import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/routes/route_names.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/typography.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  String _password = '';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: AppTypography.h1.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create account and enjoy all services',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 32),
            _buildInputSection(
              'Enter First Name',
              _firstNameController,
              Icons.person_outline,
              'Ademola',
            ),
            const SizedBox(height: 24),
            _buildInputSection(
              'Enter Last Name',
              _lastNameController,
              Icons.person_outline,
              'Oshingbesan',
            ),
            const SizedBox(height: 24),
            _buildInputSection(
              'Phone Number',
              _phoneController,
              Icons.phone_outlined,
              '250792402821',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            _buildPasswordSection(),
            if (_password.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Cool! You have very strong password',
                    style: AppTypography.bodyMedium
                        .copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        _agreeToTerms ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color:
                          _agreeToTerms ? AppColors.primary : Colors.grey[300]!,
                    ),
                  ),
                  child: Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() => _agreeToTerms = value!);
                    },
                    fillColor: WidgetStateProperty.all(AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.bodyMedium
                          .copyWith(color: Colors.grey[600]),
                      children: [
                        const TextSpan(text: 'I agree to the company '),
                        TextSpan(
                          text: 'Term of Service',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _agreeToTerms
                  ? () {
                      Get.offAllNamed(RouteNames.home);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Sign up',
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OR',
                      style: AppTypography.caption
                          .copyWith(color: Colors.grey[500])),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                // Handle Google sign up
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png',
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Sign up with Google',
                    style: AppTypography.button.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have an account? ",
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(RouteNames.login);
                  },
                  child: Text(
                    'Login',
                    style: AppTypography.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(
    String label,
    TextEditingController controller,
    IconData icon,
    String hintText, {
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTypography.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  AppTypography.bodyMedium.copyWith(color: Colors.grey[400]),
              prefixIcon: Icon(icon, color: Colors.grey[400], size: 22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            onChanged: (value) {
              setState(() => _password = value);
            },
            style: AppTypography.bodyMedium,
            decoration: InputDecoration(
              hintText: '••••••',
              hintStyle:
                  AppTypography.bodyMedium.copyWith(color: Colors.grey[400]),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.grey[400],
                size: 22,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[400],
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
