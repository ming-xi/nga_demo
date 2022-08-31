import 'package:common/models/job.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/ui_utils.dart';
import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

class JobView extends ConsumerWidget {
  final Job job;

  const JobView({
    required this.job,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Ink(
      child: InkWell(
        onTap: () {
          showNgaSimpleDialog(context: context, text: "跳转到职位");
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: designColors.dark_01.auto(ref)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${job.province} · ${job.city} / ${job.educationRequirement} / ${sprintf(globalLocalizations.job_view_year, [job.workingYears])}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: designColors.dark_03.auto(ref)),
                    ),
                  ],
                ),
              ),
              Text(
                "${job.salaryMin}-${job.salaryMax}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyView extends ConsumerWidget {
  final Company company;

  const CompanyView({
    required this.company,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.card,
      color: designColors.light_00.auto(ref),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            child: InkWell(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              onTap: () {
                showNgaSimpleDialog(context: context, text: "跳转到公司");
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    NgaIcon(
                      "assets/images/fig_company_1.png",
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            company.name,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: designColors.dark_01.auto(ref)),
                          ),
                          Text(
                            sprintf(globalLocalizations.home_recruiting_job_count, [company.jobCount]),
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: designColors.dark_02.auto(ref)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 1,
              color: designColors.light_03.auto(ref),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: company.jobs
                .map(
                  (e) => JobView(job: e),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
