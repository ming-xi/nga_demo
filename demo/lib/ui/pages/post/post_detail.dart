import 'package:common/models/post.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:demo/ui/views/comment_compose_view.dart';
import 'package:demo/ui/views/post.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailScreen({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(globalLocalizations.post_detail_screen_title),
        centerTitle: true,
        bottom: PreferredSize(
            child: Container(
              color: designColors.light_03.auto(ref),
              height: 1,
            ),
            preferredSize: Size.fromHeight(1)),
        actions: [
          IconButton(
              onPressed: () {
                showNgaSimpleDialog(context: context, text: "分享");
              },
              icon: const NgaIcon("assets/images/ic_share.svg"))
        ],
      ),
      backgroundColor: designColors.light_00.auto(ref),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PostView(
                        post: widget.post,
                        isDetail: true,
                      ),
                      Container(
                        height: 8,
                        color: designColors.background.auto(ref),
                      ),
                      Container(
                        color: designColors.light_00.auto(ref),
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            sprintf(globalLocalizations.post_detail_screen_comment_count, [widget.post.commentCount]),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == widget.post.comments!.length) {
                      return const SizedBox(
                        height: 120,
                      );
                    }
                    return CommentView(comment: widget.post.comments![index]);
                  }, childCount: widget.post.comments!.length + 1),
                )
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CommentComposeView(),
          )
        ],
      ),
    );
  }
}
