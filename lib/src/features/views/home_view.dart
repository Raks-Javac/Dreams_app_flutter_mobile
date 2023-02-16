import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/res/assets.dart';
import '../../shared/res/decoration.dart';
import '../../shared/res/sizer.dart';
import '../../shared/res/theme.dart';
import '../../shared/widgets/renderSvg.dart';
import '../data/list_model.dart';
import '../provider/list_provider.dart';
import 'category_screen.dart';

class HomeView extends ConsumerWidget {
  BoxConstraints constraint;
  HomeView({super.key, required this.constraint});
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(listProvider);
    ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);
    final listStateNotifier = ref.watch(listProvider.notifier);

    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          themeNotifier.getAppCurrentTheme == true
              ? TAssets.backgroundLight
              : TAssets.backgroundDark,
          width: double.infinity,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height / 3.4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizerClass.isDeskTop(constraint)
                          ? MediaQuery.of(context).size.width / 2.4
                          : MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dreams",
                            style: GoogleFonts.josefinSans().copyWith(
                              fontSize: 35,
                              letterSpacing: 3,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                ref
                                    .watch(themeProvider.notifier)
                                    .changeThemeState();
                              },
                              icon: RenderSvg(
                                  svgPath:
                                      themeNotifier.getAppCurrentTheme == true
                                          ? TAssets.sun
                                          : TAssets.moon))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: SizerClass.isDeskTop(constraint)
                          ? MediaQuery.of(context).size.width / 2.4
                          : MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                        controller: textEditingController,
                        cursorColor: themeNotifier.getAppCurrentTheme == true
                            ? Colors.black
                            : Colors.white,
                        decoration: InputDecoration(
                          prefixIconColor:
                              themeNotifier.getAppCurrentTheme == true
                                  ? Colors.black
                                  : Colors.white,
                          prefixIcon: const Icon(Icons.switch_access_shortcut),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (textEditingController.text.trim().isEmpty) {
                              } else {
                                ListModel model =
                                    ListModel(true, textEditingController.text);
                                listStateNotifier.addItemToActive(
                                    model.copyWith(isActive: true));
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add ",
                                    style: GoogleFonts.josefinSans().copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color
                                          ?.withOpacity(0.5),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                          ),
                          filled: true,
                          hintText: "Create a new dream list",
                          hintStyle: GoogleFonts.josefinSans().copyWith(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withOpacity(0.49),
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: AppDecoration.textFieldDecoration,
                          errorBorder: AppDecoration.textFieldDecoration,
                          enabledBorder: AppDecoration.textFieldDecoration,
                          disabledBorder: AppDecoration.textFieldDecoration,
                          isDense: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
              Expanded(child: CategorySection(constraint: constraint))
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 25),
        //       child: Text("Drag and drop to reorder list",
        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //                 fontSize: 14,
        //                 letterSpacing: 0.8,
        //                 color: Theme.of(context)
        //                     .textTheme
        //                     .bodySmall
        //                     ?.color
        //                     ?.withOpacity(0.5),
        //                 fontWeight: FontWeight.w600,
        //               ))),
        // )
      ],
    ));
  }
}
