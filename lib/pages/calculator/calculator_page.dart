import 'package:auto_size_text/auto_size_text.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  static const routeName = '/calculator';

  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _userInput = '';
  String _answer = '0';
  bool _hasCalculated = false;
  final List<String> _history = [];

  final List<String> _buttons = [
    'C',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgScreen,
      appBar: AppBar(
        title: Text(
          'Kalkulator',
          style: context.headingSmall.withColor(Colors.white),
        ),
        backgroundColor: context.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(MdiIcons.chevronLeft, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _showHistory,
            icon: const Icon(Icons.history, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    _userInput,
                    style: context.displayMedium.copyWith(
                      color: _hasCalculated
                          ? context.mutedMedium.color
                          : context.displayMedium.color,
                      fontSize: _hasCalculated ? 24 : 48,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 10),
                  AutoSizeText(
                    _answer,
                    style: context.displayLarge.copyWith(
                      color: _hasCalculated
                          ? context.primaryLarge.color
                          : context.mutedLarge.color,
                      fontSize: _hasCalculated ? 48 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightCard,
                border: Border(
                  top: BorderSide(color: context.border, width: 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return _buildButton(_buttons[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    final isOperator = _isOperator(text);
    final isClear = text == 'C' || text == 'DEL';
    final isEqual = text == '=';

    Color bgColor;
    Color textColor;

    if (isEqual) {
      bgColor = AppColors.lightPrimary;
      textColor = AppColors.lightPrimaryForeground;
    } else if (isOperator) {
      bgColor = AppColors.lightSecondary;
      textColor = AppColors.lightPrimary;
    } else if (isClear) {
      bgColor = AppColors.lightDestructive.withOpacity(0.1);
      textColor = AppColors.lightDestructive;
    } else {
      bgColor = bgScreen;
      textColor = AppColors.lightForeground;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onButtonPressed(text),
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: context.headingSmall.copyWith(
                color: textColor,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isOperator(String text) {
    return text == '%' ||
        text == '÷' ||
        text == 'x' ||
        text == '-' ||
        text == '+' ||
        text == '=' ||
        text == '+/-';
  }

  void _onButtonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _userInput = '';
        _answer = '0';
        _hasCalculated = false;
      } else if (text == 'DEL') {
        if (_userInput.isNotEmpty) {
          _userInput = _userInput.substring(0, _userInput.length - 1);
        }
      } else if (text == '=') {
        _calculateResult();
      } else if (text == '+/-') {
        // Not implemented yet specifically, treating as toggle sign
      } else {
        if (_hasCalculated) {
          if (_isOperator(text)) {
            _userInput = _answer + text;
          } else {
            _userInput = text;
          }
          _hasCalculated = false;
        } else {
          _userInput += text;
        }
      }
    });
  }

  void _calculateResult() {
    try {
      String finalInput = _userInput;
      finalInput = finalInput.replaceAll('x', '*');
      finalInput = finalInput.replaceAll('÷', '/');
      finalInput = finalInput.replaceAll('%', '/100');

      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      String resultStr;

      // Check if we have a very small decimal part (floating point errors) or it is basically integer
      if ((eval - eval.round()).abs() < 0.00000001) {
        resultStr = eval.round().toString();
      } else {
        // Limit decimal places
        resultStr = eval
            .toStringAsFixed(8)
            .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      }

      _answer = resultStr;

      // Add to history
      _history.add('$_userInput = $_answer');

      _hasCalculated = true;
    } catch (e) {
      _answer = 'Error';
    }
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.lightCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Riwayat', style: context.headingSmall),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _history.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Hapus Semua',
                      style: context.bodyMedium.copyWith(
                        color: AppColors.lightDestructive,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _history.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada riwayat',
                          style: context.mutedMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _history.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final historyItem = _history[index];
                          final parts = historyItem.split(' = ');
                          return ListTile(
                            title: Text(
                              parts.length > 1 ? parts[1] : historyItem,
                              style: context.headingSmall,
                              textAlign: TextAlign.right,
                            ),
                            subtitle: Text(
                              parts.length > 0 ? parts[0] : '',
                              style: context.mutedMedium,
                              textAlign: TextAlign.right,
                            ),
                            onTap: () {
                              setState(() {
                                if (parts.length > 1) {
                                  _userInput = parts[1];
                                  _answer = '0';
                                  _hasCalculated = false;
                                }
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
