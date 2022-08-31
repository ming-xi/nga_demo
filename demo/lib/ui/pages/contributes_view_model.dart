import 'dart:convert';

import 'package:common/extensions/extensions.dart';
import 'package:common/models/post.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'contributes_view_model.g.dart';

@CopyWith()
class ContributesPageModelState {
  final List<Post> posts;
  final String jsonString;

  ContributesPageModelState({
    required this.jsonString,
    required this.posts,
  });

  factory ContributesPageModelState.init(String jsonString) {
    return ContributesPageModelState(
      jsonString: jsonString,
      posts: [],
    );
  }
}

class ContributesPageViewModel extends StateNotifier<ContributesPageModelState> {
  ContributesPageViewModel(ContributesPageModelState state) : super(state) {
    refresh();
  }

  void refresh({Function()? onComplete}) {
    updateState(state.copyWith(posts: [..._loadPosts()]));
    if (onComplete != null) {
      onComplete();
    }
  }

  void loadMoreData({Function()? onComplete}) {
    updateState(state.copyWith(posts: [...state.posts, ..._loadPosts()]));
    if (onComplete != null) {
      onComplete();
    }
  }

  List<Post> _loadPosts() {
    dynamic data = json.decode(state.jsonString); //latest Dart
    data = data['contributes'];
    List<dynamic> postsData = data['recommended']['posts'];
    var list = postsData.map((e) => Post.fromJson(e)).toList();
    return list;
  }
}
