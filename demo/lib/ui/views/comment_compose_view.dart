import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentComposeView extends ConsumerStatefulWidget {
  const CommentComposeView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CommentComposeViewState();
}

class _CommentComposeViewState extends ConsumerState<CommentComposeView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: designColors.light_00.auto(ref),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: designColors.light_03.auto(ref),
              height: 0.5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showNgaSimpleDialog(context: context, text: "切换账号");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        ClipOval(
                            child: NgaIcon(
                          "assets/images/fig_avatar_3.jpg",
                          width: 28,
                          height: 28,
                        )),
                        SizedBox(
                          width: 4,
                        ),
                        NgaIcon(
                          "assets/images/ic_arrow_down.svg",
                          width: 16,
                          height: 16,
                          color: designColors.dark_03.auto(ref),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 32),
                      child: Container(
                        decoration: BoxDecoration(color: designColors.background.auto(ref), borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: textEditingController,
                          style: TextStyle(fontSize: 12, color: designColors.dark_01.auto(ref)),
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              hintText: globalLocalizations.comment_compose_view_hint,
                              hintStyle: TextStyle(fontSize: 12, color: designColors.light_02.auto(ref))),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2, right: 4),
                  child: TextButton(
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap, minimumSize: Size(48, 32)),
                      onPressed: () {
                        setState(() {
                          textEditingController.text = "";
                        });
                        showNgaSimpleDialog(context: context, text: "已发送");
                      },
                      child: Text(
                        globalLocalizations.comment_compose_view_send,
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ],
            ),
            Container(
              color: designColors.light_03.auto(ref),
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
