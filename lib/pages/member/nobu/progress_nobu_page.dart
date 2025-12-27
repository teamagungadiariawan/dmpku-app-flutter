import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class ProgressNobuPage extends StatelessWidget {
  static const String routeName = '/member/nobu/progress';

  const ProgressNobuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Qris By Nobu"),
      bottomNavigationBar: Container(
        padding: paddingPage.copyWith(bottom: bottomInsets + 10),
        decoration: BoxDecoration(
          color: context.card,
          border: Border(top: BorderSide(color: context.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: _buildBottomButtons(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Hero Image & Title
            _buildHeroSection(context),
            const Gap(24),

            // 2. Status Card
            _buildStatusCard(context),
            const Gap(16),

            // 3. Notification Card
            _buildNotificationCard(context),
            const Gap(24),

            // 4. Other Methods
            _buildOtherMethods(context),
            const Gap(24),

            // 5. Coming Soon
            _buildComingSoon(context),
            const Gap(32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      children: [
        Assets.img.official.nobu.image(width: 120),
        const Gap(10),
        Lottie.asset(Assets.animations.dalamProses, width: 180, height: 180),

        const Gap(20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.orange),
              const Gap(6),
              Text(
                'PROSES INTEGRASI',
                style: context.captionRegular.copyWith(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Text(
          'Qris Nobu sedang\nditingkatkan',
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ) ??
              const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Text(
          'Kami sedang melakukan pembaruan sistem untuk menghadirkan fitur pembayaran QRIS yang lebih cepat dan aman untuk Anda.',
          textAlign: TextAlign.center,
          style: context.bodyMedium.copyWith(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: context.border, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status Terkini',
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Segera Hadir',
                style: context.captionRegular.copyWith(
                  color: Colors.teal[600],
                  fontFamily: 'Monospace',
                ),
              ),
            ],
          ),
          const Gap(12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.65,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[600]!),
              minHeight: 6,
            ),
          ),
          const Gap(24),
          // Timeline
          _buildTimelineItem(
            context,
            icon: Icons.check,
            iconColor: Colors.green,
            bgColor: Colors.green[50]!,
            title: 'Inisialisasi Sistem',
            subtitle: 'Selesai',
            isCompleted: true,
            isLast: false,
          ),
          _buildTimelineItem(
            context,
            icon: Icons.sync,
            iconColor: Colors.teal[600]!,
            bgColor: Colors.teal[100]!,
            title: 'Sinkronisasi Merchant',
            subtitle: 'Sedang memproses data keamanan...',
            isCompleted: true, // Current active
            isLast: false,
            isProcessing: true,
          ),
          _buildTimelineItem(
            context,
            icon: MdiIcons.rocketLaunch,
            iconColor: Colors.grey[400]!,
            bgColor: Colors.grey[100]!,
            title: 'Finalisasi',
            subtitle: 'Segera',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
    bool isProcessing = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              isProcessing
                  ? _PulseSpinIcon(
                      icon: icon,
                      iconColor: iconColor,
                      bgColor: bgColor,
                    )
                  : Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 18),
                    ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[200],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  subtitle,
                  style: context.captionRegular.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Gap(24), // Spacing between items
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E4E6D), // Dark blue like in visual
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jangan Menunggu',
                  style: context.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  'Kami akan kabari saat Qris siap dipakai.',
                  style: context.captionRegular.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E4E6D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            icon: const Icon(Icons.notifications_off_outlined, size: 16),
            label: const Text('Ingatkan'),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherMethods(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran Lain',
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _buildMethodCard(
                context,
                icon: MdiIcons.bankTransfer,
                label: 'Transfer Bank',
                color: Colors.blue,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildMethodCard(
                context,
                icon: MdiIcons.walletOutline,
                label: 'Virtual Account',
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMethodCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Gap(12),
          Text(
            label,
            style: context.bodySmall.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fitur Baru Segera Hadir',
              style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.more_horiz, color: Colors.grey),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                context,
                icon: Icons.bolt,
                iconColor: Colors.orange,
                bgIcon: Colors.orange[50]!,
                title: 'Transaksi Kilat',
                desc:
                    'Proses pembayaran 2x lebih cepat dengan sistem core baru.',
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildFeatureCard(
                context,
                icon: MdiIcons.shieldCheck,
                iconColor: Colors.red,
                bgIcon: Colors.red[50]!,
                title: 'Proteksi Ganda',
                desc: 'Keamanan tingkat lanjut setiap transaksi QRIS Anda.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color bgIcon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgIcon,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const Gap(12),
          Text(
            title,
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Text(
            desc,
            style: context.captionRegular.copyWith(
              color: Colors.grey[600],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomButton(
            text: 'Hubungi CS',
            onPressed: () {},
            backgroundColor: Colors.grey[100]!,
            foregroundColor: Colors.black,
          ),
        ),
        const Gap(12),
        Expanded(
          flex: 2,
          child: CustomButton(
            text: 'Kembali ke Beranda',
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icons.arrow_forward,
          ),
        ),
      ],
    );
  }
}

class _PulseSpinIcon extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final double size;

  const _PulseSpinIcon({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.size = 36,
  });

  @override
  State<_PulseSpinIcon> createState() => _PulseSpinIconState();
}

class _PulseSpinIconState extends State<_PulseSpinIcon>
    with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: false);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0.6,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.bgColor.withValues(
                      alpha: _fadeAnimation.value,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.bgColor,
              shape: BoxShape.circle,
            ),
            child: RotationTransition(
              turns: _spinController,
              child: Icon(
                widget.icon,
                color: widget.iconColor,
                size: widget.size * 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
