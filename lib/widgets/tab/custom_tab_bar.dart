import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabController extends ChangeNotifier {
  int _index;
  final int length;

  CustomTabController({int initialIndex = 0, required this.length})
      : _index = initialIndex;

  int get index => _index;

  set index(int value) {
    if (value != _index && value >= 0 && value < length) {
      _index = value;
      notifyListeners();
    }
  }

  void animateTo(int value) {
    index = value;
  }

  void next() {
    if (_index < length - 1) {
      index = _index + 1;
    }
  }

  void previous() {
    if (_index > 0) {
      index = _index - 1;
    }
  }
}

class CustomTabBar extends StatefulWidget {
  final int? activeIndex;
  final ValueChanged<int>? onChange;
  final CustomTabController? controller;
  final List<TabItem> tabs;
  final Color? primaryColor;
  final double borderRadius;
  final EdgeInsets margin;
  final Duration animationDuration;

  const CustomTabBar({
    super.key,
    this.activeIndex,
    this.onChange,
    this.controller,
    required this.tabs,
    this.primaryColor,
    this.borderRadius = 8.0,
    this.margin = EdgeInsets.zero,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : assert(
  controller != null || activeIndex != null,
  'Either controller or activeIndex must be provided',
  );

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  CustomTabController? _internalController;

  CustomTabController get _controller =>
      widget.controller ?? _internalController!;

  int get _activeIndex => widget.controller?.index ?? widget.activeIndex ?? 0;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = CustomTabController(
        initialIndex: widget.activeIndex ?? 0,
        length: widget.tabs.length,
      );
    }
    widget.controller?.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      widget.controller?.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    _internalController?.dispose();
    super.dispose();
  }

  void _handleControllerChange() {
    setState(() {});
    widget.onChange?.call(_controller.index);
  }

  void _handleTap(int index) {
    if (widget.controller != null) {
      widget.controller!.index = index;
    } else {
      _internalController?.index = index;
      widget.onChange?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.primaryColor ?? Theme.of(context).primaryColor;

    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: color),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius - 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tabWidth = constraints.maxWidth / widget.tabs.length;

            return Stack(
              children: [
                // Sliding indicator
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeOutCubic,
                  left: _activeIndex * tabWidth,
                  top: 0,
                  bottom: 0,
                  width: tabWidth,
                  child: Container(decoration: BoxDecoration(color: color)),
                ),

                // Tab items
                Row(
                  children: List.generate(widget.tabs.length, (index) {
                    final isActive = _activeIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _handleTap(index),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            border: index > 0
                                ? Border(left: BorderSide(color: color))
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: widget.animationDuration,
                            curve: Curves.easeOutCubic,
                            style: context.bodyMedium
                                .withColor(isActive ? Colors.white : color)
                                .withWeight(FontWeight.w600),
                            child: Text(widget.tabs[index].title),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TabItem {
  final String key;
  final String title;

  const TabItem({required this.key, required this.title});
}