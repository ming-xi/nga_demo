import 'package:common/models/user.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class GroupChatView extends ConsumerWidget {
  final Community community;

  const GroupChatView({
    required this.community,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 167 / 118,
      child: Material(
        type: MaterialType.card,
        color: designColors.light_00.auto(ref),
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: EdgeInsets.all(12),
          child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NgaIcon(
                  community.iconUrl,
                  width: 38,
                  height: 38,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      style: TextStyle(fontSize: 14, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w600),
                    ),
                    Text(
                      sprintf(globalLocalizations.group_chat_view_user_count, [community.userCount]),
                      style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Ink(
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 1, color: designColors.blue.auto(ref)),
                      ),
                      child: InkWell(
                        onTap: () {
                          showNgaSimpleDialog(context: context, text: "加入");
                        },
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NgaIcon(
                                "assets/images/ic_add.svg",
                                width: 12.6,
                                height: 12.6,
                                color: designColors.blue.auto(ref),
                              ),
                              SizedBox(
                                width: 2.7,
                              ),
                              Text(
                                globalLocalizations.group_chat_view_join,
                                style: TextStyle(fontSize: 14, color: designColors.blue.auto(ref), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommunityView extends ConsumerWidget {
  final Community community;

  const CommunityView({
    required this.community,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 106 / 130,
      child: Material(
        type: MaterialType.card,
        color: designColors.light_00.auto(ref),
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              showNgaSimpleDialog(context: context, text: "跳转到社团");
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NgaIcon(
                    community.iconUrl,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    community.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: designColors.dark_01.auto(ref),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    sprintf(globalLocalizations.community_view_user_count, [community.userCount]),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
