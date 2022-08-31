import 'package:common/models/question.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class QuestionView extends ConsumerWidget {
  final Question question;

  const QuestionView({
    required this.question,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Ink(
      padding: EdgeInsets.all(12),
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                question.text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: designColors.dark_01.auto(ref)),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                ClipOval(
                  child: NgaIcon(
                    question.author.avatarUrl!,
                    width: 28,
                    height: 28,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.author.name,
                        style: TextStyle(fontSize: 12, color: designColors.dark_01.auto(ref), fontWeight: FontWeight.w600),
                      ),
                      Text(
                        question.author.signature ?? "",
                        style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 72),
                  child: Ink(
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: designColors.blue.auto(ref)),
                    ),
                    child: InkWell(
                      onTap: () {
                        showNgaSimpleDialog(context: context, text: "写回答");
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NgaIcon(
                                "assets/images/ic_write.svg",
                                width: 12,
                                height: 12,
                                color: designColors.blue.auto(ref),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                globalLocalizations.question_view_button,
                                style: TextStyle(fontSize: 12, color: designColors.blue.auto(ref), fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              sprintf(globalLocalizations.question_view_user_count, [question.answerCount]),
              style: TextStyle(fontSize: 12, color: designColors.dark_03.auto(ref), fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
