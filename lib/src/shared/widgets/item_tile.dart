import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../res/assets.dart';
import '../res/gap.dart';
import '../res/theme.dart';
import 'renderSvg.dart';

class ItemTile extends StatelessWidget {
  final String tileTitle;
  final Function(bool) onHover;
  final Function onTap;
  final Function onRemove;
  final Widget leadingWidget;
  final bool shouldHaveRemove;
  const ItemTile(
      {super.key,
      required this.onHover,
      required this.onTap,
      required this.leadingWidget,
      required this.onRemove,
      this.shouldHaveRemove = true,
      required this.tileTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap,
      onHighlightChanged: (val) {
        onHover(val);
      },
      child: Column(
        children: [
          ListTile(
            leading: leadingWidget,
            title: Text(
              tileTitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
              ),
            ),
            trailing: shouldHaveRemove == true
                ? Consumer(builder: (context, ref, _) {
                    ref.watch(themeProvider);
                    return GestureDetector(
                      onTap: () {
                        onRemove();
                      },
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: RenderSvg(
                          svgPath: TAssets.cross,
                          color: ref
                                      .watch(themeProvider.notifier)
                                      .getAppCurrentTheme !=
                                  true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  })
                : const SizedBox.shrink(),
          ),
          addVerticalSpacing(0.2),
          const Divider(),
          addVerticalSpacing(2),
        ],
      ),
    );
  }
}
