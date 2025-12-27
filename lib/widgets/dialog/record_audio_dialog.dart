import 'dart:async';

import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecordAudioDialog extends StatefulWidget {
  final Function(String text)? onResult;
  final String localeId;

  const RecordAudioDialog({super.key, this.onResult, this.localeId = 'id_ID'});

  static void show(
    BuildContext context, {
    Function(String text)? onResult,
    String localeId = 'id_ID',
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RecordAudioDialog(onResult: onResult, localeId: localeId),
    );
  }

  @override
  State<RecordAudioDialog> createState() => _RecordAudioDialogState();
}

class _RecordAudioDialogState extends State<RecordAudioDialog>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  bool _isInitialized = false;
  String _recognizedText = '';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _isInitialized = await _speech.initialize(
      onStatus: _onStatus,
      onError: (error) {
        debugPrint('Speech error: ${error.errorMsg}');
        setState(() => _isListening = false);
        _pulseController.stop();
        _pulseController.reset();
      },
    );
    setState(() {});
  }

  void _onStatus(String status) {
    debugPrint('Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      setState(() => _isListening = false);
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  Future<void> _startListening() async {
    if (!_isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition tidak tersedia')),
      );
      pop();
      return;
    }

    setState(() {
      _recognizedText = '';
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: widget.localeId,
      listenOptions: SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.dictation,
      ),
    );

    setState(() => _isListening = true);
    _pulseController.repeat(reverse: true);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    _pulseController.stop();
    _pulseController.reset();
    setState(() => _isListening = false);
  }

  Future<void> _resetRecording() async {
    await _speech.cancel();
    _pulseController.stop();
    _pulseController.reset();
    setState(() {
      _isListening = false;
      _recognizedText = '';
    });
    _startListening();
  }

  void _saveResult() {
    debugPrint('Recognized Text: $_recognizedText');
    if (_recognizedText.isNotEmpty && widget.onResult != null) {
      debugPrint('Sending result back');
      widget.onResult!(_recognizedText);
    }
    pop();
  }

  String get _languageDisplay {
    switch (widget.localeId) {
      case 'id_ID':
        return 'Indonesia';
      case 'en_US':
        return 'English (US)';
      case 'en_GB':
        return 'English (UK)';
      case 'ja_JP':
        return 'Japanese';
      case 'zh_CN':
        return 'Chinese';
      default:
        return widget.localeId;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopDividerSheet(),
            Gap(15),
            Card(
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? stone[700] : stone[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(MdiIcons.microphone),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Input Suara',
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Input suara Anda untuk input tujuan secara cepat.',
                            style: context.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(15),

            // Mic button dengan pulse animation
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isListening ? _pulseAnimation.value : 1.0,
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: _isListening ? _stopListening : _startListening,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: _isListening
                        ? Colors.red.withValues(alpha: 0.1)
                        : indigo[500]!.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _isListening ? Colors.red : indigo[500],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (_isListening ? Colors.red : indigo[500]!)
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isListening ? Icons.stop : Icons.mic,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),

            // Status text
            Text(
              _isListening ? 'Mendengarkan...' : 'Ketuk untuk mulai merekam',
              style: context.bodyLarge.copyWith(
                fontWeight: _isListening ? FontWeight.w600 : FontWeight.normal,
                color: _isListening ? Colors.red : null,
              ),
            ),
            const Gap(4),
            Text(
              'Bahasa: $_languageDisplay',
              style: context.bodySmall.copyWith(
                color: context.isDarkMode ? stone[400] : stone[500],
              ),
            ),

            // Recognized text preview
            if (_recognizedText.isNotEmpty) ...[
              const Gap(20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.isDarkMode ? stone[800] : stone[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil:',
                      style: context.bodySmall.copyWith(
                        color: context.isDarkMode ? stone[400] : stone[500],
                      ),
                    ),
                    const Gap(4),
                    Text(_recognizedText, style: context.bodyMedium),
                  ],
                ),
              ),
              const Gap(20),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 36,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.outline,
                      borderColor: context.destructive,
                      foregroundColor: context.destructive,
                      text: "RESET",
                      onPressed: _resetRecording,
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: CustomButton(
                      height: 36,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.primary,
                      text: "SIMPAN",
                      onPressed: _saveResult,
                    ),
                  ),
                ],
              ),
            ],

            const Gap(10),
            CustomButton(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.zero,
              variant: ButtonVariant.destructive,
              text: "TUTUP",
              onPressed: () => pop(),
            ),
          ],
        ),
      ),
    );
  }
}
