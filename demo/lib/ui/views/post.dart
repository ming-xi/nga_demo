import 'dart:convert';

import 'package:common/models/post.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/ui/pages/post/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostView extends ConsumerWidget {
  final Post post;
  final bool isDetail;

  const PostView({
    required this.post,
    this.isDetail = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double horizontalPadding = isDetail ? 16 : 12;
    return Material(
      color: designColors.light_00.auto(ref),
      borderRadius: isDetail ? null : BorderRadius.circular(8),
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: isDetail
              ? null
              : () {
                  DefaultAssetBundle.of(context).loadString("assets/data.json").then((string) {
                    dynamic data = json.decode(string); //latest Dart
                    data = data['post_detail'];
                    Post post2 = Post.fromJson(data);
                    post2.text = post.text;
                    post2.images = post.images;
                    post2.author = post.author;
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PostDetailScreen(post: post2);
                    }));
                  });
                },
          child: Padding(
            padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: NgaIcon(
                        post.author.avatarUrl!,
                        width: 28,
                        height: 28,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        post.author.name,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: designColors.dark_01.auto(ref)),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showNgaSimpleDialog(context: context, text: "更多");
                      },
                      icon: NgaIcon(
                        "assets/images/ic_more.svg",
                        width: 22,
                        height: 22,
                        color: designColors.dark_02.auto(ref),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  post.text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                ),
                Visibility(
                  visible: post.images!.length >= 0,
                  child: SizedBox(
                    height: 12,
                  ),
                ),
                Visibility(
                  visible: post.images!.length > 0,
                  child: Row(
                    children: [
                      Expanded(
                          child: AspectRatio(
                        aspectRatio: 1,
                        child: post.images!.length > 0
                            ? NgaIcon(
                                post.images![0],
                              )
                            : Container(),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: AspectRatio(
                        aspectRatio: 1,
                        child: post.images!.length > 1
                            ? NgaIcon(
                                post.images![1],
                              )
                            : Container(),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: AspectRatio(
                        aspectRatio: 1,
                        child: post.images!.length > 2
                            ? NgaIcon(
                                post.images![2],
                              )
                            : Container(),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showNgaSimpleDialog(context: context, text: "点赞");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 16, top: 18, bottom: 16),
                        child: Row(
                          children: [
                            NgaIcon("assets/images/ic_like.svg"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${post.likeCount}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showNgaSimpleDialog(context: context, text: "评论");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 16, top: 18, bottom: 16),
                        child: Row(
                          children: [
                            NgaIcon("assets/images/ic_comment.svg"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${post.commentCount}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showNgaSimpleDialog(context: context, text: "分享");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 16, top: 18, bottom: 16),
                        child: Row(
                          children: [
                            NgaIcon("assets/images/ic_share.svg"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${post.shareCount}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentView extends ConsumerWidget {
  final Comment comment;

  const CommentView({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: designColors.light_00.auto(ref),
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            showNgaSimpleDialog(context: context, text: "跳转到评论");
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 18,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: NgaIcon(
                    comment.author.avatarUrl!,
                    width: 28,
                    height: 28,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.author.name,
                        style: TextStyle(fontSize: 12, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        comment.author.signature ?? "",
                        style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        comment.text,
                        style: TextStyle(fontSize: 12, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w400),
                      ),
                      Visibility(
                        visible: comment.subComments!.length > 0,
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      Visibility(
                          visible: comment.subComments!.length > 0,
                          child: Ink(
                            decoration: BoxDecoration(color: designColors.background.auto(ref), borderRadius: BorderRadius.circular(4)),
                            child: InkWell(
                              onTap: () {
                                showNgaSimpleDialog(context: context, text: "跳转到子评论");
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: comment.subComments == null
                                      ? []
                                      : comment.subComments!
                                          .map((e) => Text(
                                                "${e.author.name}：${e.text}",
                                                style: TextStyle(fontSize: 14, color: designColors.dark_02.auto(ref)),
                                              ))
                                          .toList(),
                                ),
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Text(
                            comment.date,
                            style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showNgaSimpleDialog(context: context, text: "转发");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  NgaIcon(
                                    "assets/images/ic_share.svg",
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${comment.shareCount > 0 ? comment.shareCount : ""}",
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              showNgaSimpleDialog(context: context, text: "回复");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  NgaIcon(
                                    "assets/images/ic_comment.svg",
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${comment.commentCount > 0 ? comment.commentCount : ""}",
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              showNgaSimpleDialog(context: context, text: "点赞");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  NgaIcon(
                                    "assets/images/ic_like.svg",
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${comment.likeCount > 0 ? comment.likeCount : ""}",
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: designColors.light_03.auto(ref),
                        height: 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
