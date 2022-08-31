import 'dart:convert';

import 'package:common/extensions/extensions.dart';
import 'package:common/models/job.dart';
import 'package:common/models/post.dart';
import 'package:common/models/question.dart';
import 'package:common/models/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:demo/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'home_view_model.g.dart';

@CopyWith()
class HomeScreenModelState {
  final int tabIndex;
  final String banner;
  final List<Community> groupChats;
  final List<Question> questions;
  final List<Community> communities;
  final List<Company> companies;
  final List<Post> contributes;

  HomeScreenModelState({
    this.tabIndex = HomeScreen.PAGE_INDEX_EXPLORE,
    required this.banner,
    required this.groupChats,
    required this.questions,
    required this.communities,
    required this.companies,
    required this.contributes,
  });

  factory HomeScreenModelState.init(String jsonString) {
    dynamic data = json.decode(jsonString); //latest Dart
    data = data['explore'];
    List<dynamic> groupChats = data['group_chats'];
    List<dynamic> questions = data['questions'];
    List<dynamic> communities = data['communities'];
    List<dynamic> recruitingJobs = data['recruiting_jobs'];
    List<dynamic> trendingContributes = data['trending_contributes'];
    return HomeScreenModelState(
      banner: data['banner'],
      groupChats: groupChats.map((e) => Community.fromJson(e)).toList(),
      questions: questions.map((e) => Question.fromJson(e)).toList(),
      communities: communities.map((e) => Community.fromJson(e)).toList(),
      companies: recruitingJobs.map((e) => Company.fromJson(e)).toList(),
      contributes: trendingContributes.map((e) => Post.fromJson(e)).toList(),
    );
  }
}

class HomeScreenViewModel extends StateNotifier<HomeScreenModelState> {
  TabController? tabController;

  HomeScreenViewModel(HomeScreenModelState state) : super(state) {
    // 如果需要加载时自动拉取数据，在这里调用
  }

  void setTabController(TabController controller) {
    tabController = controller;
  }

  void updateTabIndex(int index) {
    updateState(state.copyWith(tabIndex: index));
  }
}
