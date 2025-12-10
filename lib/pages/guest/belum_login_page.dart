import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/auth/login/request_otp_login_page.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BelumLoginPage extends StatelessWidget {
  final String title;

  const BelumLoginPage({super.key, this.title = "Riwayat"});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Center(
        child: Scaffold(
          appBar: CustomAppBar(
            title: title,
            onBackButtonPressed: () {},
            showBackButton: false,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? stone[700] : stone[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.shieldAlert500,
                    size: 60,
                    color: context.primary,
                  ),
                ),
                Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Anda belum login',
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Silakan login untuk mengakses fitur ini.',
                      style: context.bodyMedium,
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 30,
                        padding: EdgeInsets.zero,
                        variant: ButtonVariant.primary,
                        text: "Login",
                        onPressed: () {
                          pushNamed(RequestOtpLoginPage.routeName);
                        },
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CustomButton(
                        height: 30,
                        padding: EdgeInsets.zero,
                        variant: ButtonVariant.border,
                        borderColor: context.primary,
                        foregroundColor: context.primary,
                        text: "Daftar",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
