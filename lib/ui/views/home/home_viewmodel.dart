import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class HomeViewModel extends BaseViewModel {
  int currentIndex = 0;
  List<String> videoUrls = [
    'https://res.cloudinary.com/hyll/video/upload/f_auto,q_auto/v1674666642/wordpress_assets/Explorer-Day_Trailer_1280777b80.mp4',
    'https://firebasestorage.googleapis.com/v0/b/devstack-org.appspot.com/o/two.mp4?alt=media&token=509a3ec6-a0f1-4a10-bc6d-26c52c1e5fa1',
    'https://firebasestorage.googleapis.com/v0/b/devstack-org.appspot.com/o/three.MP4?alt=media&token=026b3768-e5b7-43a7-915f-a43d7da90fb2',
    'https://firebasestorage.googleapis.com/v0/b/devstack-org.appspot.com/o/four.MP4?alt=media&token=0bf86ee6-3d7e-44bd-9f3e-e20b88b2b392',
    'https://firebasestorage.googleapis.com/v0/b/devstack-org.appspot.com/o/five.MP4?alt=media&token=3380a4b7-0401-4147-820b-af67d7636f98',
    'https://firebasestorage.googleapis.com/v0/b/devstack-org.appspot.com/o/first.mp4?alt=media&token=c1fe5b52-cb40-4c33-8ac5-90547538a9db'
  ];
  List<VideoPlayerController> videoControllers = [];
  List<bool> videoLoadingStates = [];

  HomeViewModel() {
    _initializeControllerAtIndex(index: 0);
    _playControllerAtIndex(index: 0);
    _initializeControllerAtIndex(index: 1);
  }

  changeIndex({required int index}) {
    debugPrint("new index $index and current index is $currentIndex");
    if (index < currentIndex) {
      debugPrint("Decreasing index");
      _decreaseIndex(index: index);
    } else {
      debugPrint("Increasing index");
      _increaseIndex(index: index);
    }
  }

  _increaseIndex({required int index}) {
    currentIndex = index;
    _stopControllerAtIndex(index: index - 1);
    _disposeControllerAtIndex(index: index - 2);
    _playControllerAtIndex(index: index);
    _initializeControllerAtIndex(index: index + 1);

    rebuildUi();
  }

  _decreaseIndex({required int index}) {
    currentIndex = index;
    _stopControllerAtIndex(index: index + 1);
    _disposeControllerAtIndex(index: index + 2);
    _playControllerAtIndex(index: index);
    _initializeControllerAtIndex(index: index - 1);

    rebuildUi();
  }

  Future<void> _initializeControllerAtIndex({required int index}) async {
    if (videoUrls.length > index && index >= 0) {
      final VideoPlayerController _controller =
          VideoPlayerController.networkUrl(Uri.parse(videoUrls[index]));
      videoControllers.add(_controller);
      await _controller.initialize();
    }
  }

  void _playControllerAtIndex({required int index}) {
    if (videoUrls.length > index && index >= 0) {
      debugPrint("Playing video at index $index");
      final VideoPlayerController _controller = videoControllers[index];
      _controller.play();
      _fetchPaginatedData();

    }
  }

  void _stopControllerAtIndex({required int index}) {
    if (videoUrls.length > index && index >= 0) {
      debugPrint("Stoping video at index $index");
      final VideoPlayerController _controller = videoControllers[index];
      _controller.pause();
      _controller.seekTo(const Duration(seconds: 0));
    }
  }

  void _disposeControllerAtIndex({required int index}) {
    /*if (videoUrls.length > index && index >= 0) {
      final VideoPlayerController _controller = videoControllers[index];
      _controller.dispose();
      videoControllers.remove(index);
    }*/
  }

  _fetchPaginatedData() {
    /// this method will be used to fetch more video urls and add them to the videoUrls list
  }
}
