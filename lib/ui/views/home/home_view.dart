import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:hyll/ui/common/app_colors.dart';
import 'package:hyll/ui/common/ui_helpers.dart';
import 'package:video_player/video_player.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
          itemCount: viewModel.videoUrls.length,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            viewModel.changeIndex(index: index);
          },
          itemBuilder: (context, index) {
            return viewModel.currentIndex == index
                ? VideoPlayer(viewModel.videoControllers[index])
                : const Offstage();
          }),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) {
    return HomeViewModel();
  }
}
