import 'package:common/utils/design_colors.dart';
import 'package:demo/global.dart';
import 'package:demo/ui/pages/contributes_view_model.dart';
import 'package:demo/ui/pages/home.dart';
import 'package:demo/ui/views/post.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContributesPage extends ConsumerStatefulWidget {
  late final StateNotifierProvider<ContributesPageViewModel, ContributesPageModelState> provider;

  ContributesPage({
    required String jsonString,
    Key? key,
  }) : super(key: key) {
    provider = StateNotifierProvider((ref) {
      return ContributesPageViewModel(ContributesPageModelState.init(jsonString));
    });
  }

  @override
  ConsumerState createState() => _ContributesPageState();
}

class _ContributesPageState extends ConsumerState<ContributesPage> with TickerProviderStateMixin {
  late TabController tabController;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    ContributesPageModelState modelState = ref.watch(widget.provider);
    ContributesPageViewModel model = ref.watch(widget.provider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          SizedBox(
            height: HomeScreen.PAGE_TOP_MARGIN,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: designColors.light_00.auto(ref), borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    controller: tabController,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: designColors.blue.auto(ref), width: 2),
                    ),
                    overlayColor: MaterialStateProperty.all(designColors.dark_01.auto(ref).withOpacity(0.1)),
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 16),
                    indicatorPadding: EdgeInsets.symmetric(vertical: 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(fontSize: 14, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(fontSize: 14, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w400),
                    tabs: [
                      Tab(
                        text: globalLocalizations.contributes_recommended,
                      ),
                      Tab(
                        text: globalLocalizations.contributes_followed,
                      ),
                    ],
                    onTap: (index) {
                      // ref.read(widget.provider.notifier).updateTabIndex(index);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(
                color: designColors.blue.auto(ref),
                backgroundColor: designColors.background.auto(ref),
              ),
              onRefresh: () async {
                model.refresh(onComplete: () {
                  _refreshController.refreshCompleted();
                });
              },
              onLoading: () async {
                model.loadMoreData(onComplete: () {
                  _refreshController.loadComplete();
                });
              },
              controller: _refreshController,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...modelState.posts
                            .map((e) => [
                                  PostView(post: e),
                                  SizedBox(
                                    height: 8,
                                  )
                                ])
                            .expand((element) => element)
                            .toList()
                          ..removeLast(),
                        // SizedBox(
                        //   height: 100,
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
