import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:demo/ui/pages/home.dart';
import 'package:demo/ui/pages/home_view_model.dart';
import 'package:demo/ui/views/community.dart';
import 'package:demo/ui/views/job.dart';
import 'package:demo/ui/views/post.dart';
import 'package:demo/ui/views/question.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExplorePage extends ConsumerStatefulWidget {
  final HomeScreenModelState modelState;

  const ExplorePage({
    required this.modelState,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: HomeScreen.PAGE_TOP_MARGIN,
        ),
        SizedBox(
          height: 6,
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AspectRatio(aspectRatio: 2.366, child: NgaIcon(widget.modelState.banner)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          globalLocalizations.home_interested_group_chat,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GroupChatView(community: widget.modelState.groupChats[index % widget.modelState.groupChats.length]),
                        itemCount: widget.modelState.groupChats.length * 4,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          globalLocalizations.home_questions_waiting_for_you,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Material(
                        type: MaterialType.card,
                        color: designColors.light_00.auto(ref),
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.modelState.questions
                              .map((e) => [
                                    QuestionView(question: e),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Container(
                                        color: designColors.light_03.auto(ref),
                                        height: 1,
                                      ),
                                    )
                                  ])
                              .expand((element) => element)
                              .toList()
                            ..removeLast(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          globalLocalizations.home_questions_waiting_for_you,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: 12,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CommunityView(community: widget.modelState.communities[index % widget.modelState.communities.length]),
                        itemCount: widget.modelState.communities.length * 4,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          globalLocalizations.home_recruiting,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Material(
                        type: MaterialType.card,
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.modelState.companies
                              .map((e) => [
                                    CompanyView(company: e),
                                    SizedBox(
                                      height: 12,
                                    )
                                  ])
                              .expand((element) => element)
                              .toList()
                            ..removeLast(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          globalLocalizations.home_trending_contributes,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.modelState.contributes
                            .map((e) => [
                                  PostView(post: e),
                                  SizedBox(
                                    height: 8,
                                  )
                                ])
                            .expand((element) => element)
                            .toList()
                          ..removeLast(),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
