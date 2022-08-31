import 'package:common/global.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/preferences.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:demo/ui/pages/contributes.dart';
import 'package:demo/ui/pages/explore.dart';
import 'package:demo/ui/pages/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeScreen extends ConsumerStatefulWidget {
  late final StateNotifierProvider<HomeScreenViewModel, HomeScreenModelState> provider;

  static const PAGE_INDEX_EXPLORE = 0;
  static const PAGE_INDEX_CONTRIBUTES = 1;
  static const PAGE_INDEX_QUESTIONS = 2;
  static const PAGE_INDEX_COMMUNITY = 3;
  static const PAGE_INDEX_GROUP_CHATS = 4;
  static const PAGE_TOP_MARGIN = 150.0;
  final String jsonString;

  HomeScreen({
    Key? key,
    required this.jsonString,
  }) : super(key: key) {
    provider = StateNotifierProvider((ref) {
      return HomeScreenViewModel(HomeScreenModelState.init(jsonString));
    });
  }

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenModelState modelState = ref.watch(widget.provider);
    Widget page = [
      ExplorePage(modelState: modelState),
      ContributesPage(jsonString: widget.jsonString),
      Container(),
      Container(),
      Container(),
    ][tabController.index];
    bool darkMode = isDarkMode(ref);
    int selectedTab = 0;
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: designColors.background.auto(ref),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AspectRatio(
                aspectRatio: 150 / 175,
                child: darkMode
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00a0ff).withOpacity(darkMode ? 0.25 : 0.5),
                                  Color(0xFFdcf2fd).withOpacity(darkMode ? 0.25 : 0.5),
                                  Color(0xFFdcf2ff).withOpacity(darkMode ? 0.25 : 0.5),
                                  Color(0xFF7fec67).withOpacity(darkMode ? 0.25 : 0.5),
                                  Color(0xFF3447d7).withOpacity(darkMode ? 0.25 : 0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0, 0.2, 0.25, 0.5, 1])))
                    : NgaIcon(
                        "assets/images/fig_background.jpg",
                        fit: BoxFit.cover,
                      ),
              )),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AspectRatio(
                aspectRatio: 150 / 175,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                  designColors.background.auto(ref).withOpacity(0),
                  designColors.background.auto(ref).withOpacity(0.25),
                  designColors.background.auto(ref)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
              )),
          Positioned.fill(child: page),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: NgaNavigationBar(selectedTab: 0, tabs: [
                    NavigationBarItemModel(iconUrl: "assets/images/ic_tab_icon_explore.svg", title: globalLocalizations.tab_text_explore),
                    NavigationBarItemModel(iconUrl: "assets/images/ic_tab_icon_jobs.svg", title: globalLocalizations.tab_text_jobs),
                    NavigationBarItemModel(iconUrl: "assets/images/ic_tab_icon_messages.svg", title: globalLocalizations.tab_text_messages),
                    NavigationBarItemModel(iconUrl: "assets/images/ic_tab_icon_me.svg", title: globalLocalizations.tab_text_me),
                  ])))
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Center(
        child: Container(
          height: 28,
          decoration: BoxDecoration(color: designColors.light_00.auto(ref).withOpacity(0.56), borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NgaIcon(
                  "assets/images/ic_search.svg",
                  width: 12,
                  height: 12,
                  color: designColors.light_02.auto(ref),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 12, color: designColors.dark_01.auto(ref)),
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: globalLocalizations.home_search,
                        hintStyle: TextStyle(fontSize: 12, color: designColors.light_02.auto(ref))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(36),
        child: SizedBox(
          height: 36,
          child: TabBar(
            controller: tabController,
            indicator: RectangularIndicator(
              bottomLeftRadius: 4,
              bottomRightRadius: 4,
              topLeftRadius: 4,
              topRightRadius: 4,
              color: designColors.light_00.auto(ref).withOpacity(0.5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            overlayColor: MaterialStateProperty.all(designColors.dark_01.auto(ref).withOpacity(0.1)),
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontSize: 14, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 14, color: designColors.dark_02.auto(ref), fontWeight: FontWeight.w400),
            tabs: [
              Tab(
                text: globalLocalizations.home_tab_explore,
              ),
              Tab(
                text: globalLocalizations.home_tab_contribute,
              ),
              Tab(
                text: globalLocalizations.home_tab_questions,
              ),
              Tab(
                text: globalLocalizations.home_tab_community,
              ),
              Tab(
                text: globalLocalizations.home_tab_group_chat,
              ),
            ],
            onTap: (index) {
              ref.read(widget.provider.notifier).updateTabIndex(index);
            },
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        PopupMenuButton(
            padding: EdgeInsets.zero,
            color: designColors.light_00.auto(ref),
            // offset: Offset(0.0, appBarHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            itemBuilder: (context) {
              Map<int, String> values = {
                DARK_MODE_SYSTEM: globalLocalizations.dark_mode_system,
                DARK_MODE_LIGHT: globalLocalizations.dark_mode_day,
                DARK_MODE_DARK: globalLocalizations.dark_mode_night,
              };
              return values.entries
                  .map((e) => PopupMenuItem(
                      onTap: () {
                        ref.read(globalDarkModeProvider.state).state = e.key;
                        preferences.putInt(Preferences.KEY_DARK_MODE, e.key);
                      },
                      child: Text(
                        e.value,
                        style: TextStyle(color: designColors.dark_01.auto(ref)),
                      )))
                  .toList();
            },
            icon: NgaIcon(
              "assets/images/ic_news.svg",
              width: 20,
              height: 20,
              color: designColors.dark_01.auto(ref),
            )),
        PopupMenuButton(
            padding: EdgeInsets.zero,
            color: designColors.light_00.auto(ref),
            // offset: Offset(0.0, appBarHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            itemBuilder: (context) {
              Map<String, String?> values = {
                globalLocalizations.language_system: null,
                globalLocalizations.language_zh: "zh",
                globalLocalizations.language_en: "en",
                globalLocalizations.language_jp: "ja",
              };
              return values.entries
                  .map((e) => PopupMenuItem(
                      onTap: () {
                        preferences.putString(Preferences.KEY_LANGUAGE, e.value);
                        ref.read(globalLocaleProvider.state).state = e.value == null ? null : Locale(e.value!);
                      },
                      child: Text(
                        e.key,
                        style: TextStyle(color: designColors.dark_01.auto(ref)),
                      )))
                  .toList();
            },
            icon: NgaIcon(
              "assets/images/ic_add.svg",
              width: 20,
              height: 20,
              color: designColors.dark_01.auto(ref),
            )),
      ],
    );
  }
}

class NavigationBarItemModel {
  final String iconUrl;
  final String title;

  NavigationBarItemModel({required this.iconUrl, required this.title});
}

class NgaNavigationBar extends ConsumerStatefulWidget {
  final int selectedTab;
  final List<NavigationBarItemModel> tabs;

  const NgaNavigationBar({
    required this.selectedTab,
    required this.tabs,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NavigationBarState();
}

class _NavigationBarState extends ConsumerState<NgaNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: designColors.light_00.auto(ref),
      borderRadius: BorderRadius.circular(100),
      shadowColor: designColors.light_03.auto(ref),
      elevation: 16,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: widget.tabs
              .map((e) => Expanded(
                      child: Center(
                    child: NgaNavigationBarItem(
                      selected: widget.selectedTab == widget.tabs.indexOf(e),
                      model: e,
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}

class NgaNavigationBarItem extends ConsumerWidget {
  final bool selected;
  final NavigationBarItemModel model;

  const NgaNavigationBarItem({
    required this.selected,
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          showNgaSimpleDialog(context: context, text: "tab跳转");
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 32),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NgaIcon(
                    model.iconUrl,
                    width: 24,
                    height: 24,
                    color: selected ? designColors.green.auto(ref) : designColors.light_02.auto(ref),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    model.title,
                    style: TextStyle(fontSize: 10, color: selected ? designColors.green.auto(ref) : designColors.light_02.auto(ref)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
