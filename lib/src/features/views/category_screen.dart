import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/res/assets.dart';
import '../../shared/res/gap.dart';
import '../../shared/res/sizer.dart';
import '../../shared/res/theme.dart';
import '../../shared/widgets/item_tile.dart';
import '../../shared/widgets/renderSvg.dart';
import '../provider/list_provider.dart';

class CategorySection extends ConsumerStatefulWidget {
  final BoxConstraints constraint;
  const CategorySection({super.key, required this.constraint});

  @override
  ConsumerState<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends ConsumerState<CategorySection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    ref.read(listProvider.notifier).runInit();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(listProvider);
    ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);
    final listStateNotifier = ref.watch(listProvider.notifier);
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: SizerClass.isDeskTop(widget.constraint)
            ? MediaQuery.of(context).size.width / 2.4
            : MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                width: SizerClass.isDeskTop(widget.constraint)
                    ? MediaQuery.of(context).size.width / 2.4
                    : MediaQuery.of(context).size.width / 1.2,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    listStateNotifier.allDreams.isEmpty
                        ? const Center(child: Text("No dream list found"))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                ...listStateNotifier.allDreams.map((e) {
                                  return ItemTile(
                                    onHover: (val) {},
                                    leadingWidget: e.isActive != true
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: RenderSvg(
                                              svgPath: TAssets.check,
                                              color: themeNotifier
                                                          .getAppCurrentTheme !=
                                                      true
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.purpleAccent
                                                      .withOpacity(0.5),
                                                )),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Active",
                                              ),
                                            ),
                                          ),
                                    onRemove: () {},
                                    tileTitle: e.title,
                                    onTap: () {},
                                    shouldHaveRemove: false,
                                  );
                                }),
                              ],
                            ),
                          ),
                    listStateNotifier.activeDreams.isEmpty
                        ? const Center(
                            child: Text("No active dream list found"))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < listStateNotifier.activeDreams.length;
                                    i++)
                                  ItemTile(
                                    onHover: (val) {},
                                    leadingWidget: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.purpleAccent
                                                .withOpacity(0.5),
                                          )),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Active",
                                        ),
                                      ),
                                    ),
                                    onRemove: () {
                                      listStateNotifier.addItemToCompleted(i);
                                    },
                                    tileTitle:
                                        listStateNotifier.activeDreams[i].title,
                                    onTap: () {},
                                  ),
                              ],
                            ),
                          ),
                    listStateNotifier.completedDreams.isEmpty
                        ? const Center(
                            child: Text("N completed dream list found"))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                ...listStateNotifier.completedDreams.map((e) {
                                  return ItemTile(
                                    onHover: (val) {},
                                    leadingWidget: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: RenderSvg(
                                        svgPath: TAssets.check,
                                        color:
                                            themeNotifier.getAppCurrentTheme !=
                                                    true
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                    onRemove: () {
                                      listStateNotifier.addItemToActive(e);
                                    },
                                    shouldHaveRemove: false,
                                    tileTitle: e.title,
                                    onTap: () {},
                                  );
                                }),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),

            addVerticalSpacing(10),

            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${listStateNotifier.activeDreams.isEmpty ? "No" : listStateNotifier.activeDreams.length}  item(s) left",
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: TabBar(
                              isScrollable: true,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              indicatorWeight: 0.01,
                              controller: _tabController,
                              tabs: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "All",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Active",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Completed",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                )
                              ])),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      listStateNotifier.clearAllDreams();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Clear all",
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
