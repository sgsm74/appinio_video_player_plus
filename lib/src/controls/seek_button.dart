import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appinio_video_player/src/custom_video_player_controller.dart';

class CustomVideoSeekButton extends StatefulWidget {
  const CustomVideoSeekButton({
    Key? key,
    required this.customVideoPlayerController,
  }) : super(key: key);
  final CustomVideoPlayerController customVideoPlayerController;

  @override
  State<CustomVideoSeekButton> createState() => _CustomVideoSeekButtonState();
}

class _CustomVideoSeekButtonState extends State<CustomVideoSeekButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _seek(true),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Icon(
              _forwardIcon(),
              color: CupertinoColors.white,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _seek(false),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Icon(
              _replayIcon(),
              color: CupertinoColors.white,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _seek(bool forward) async {
    final currentTimeStamp =
        widget.customVideoPlayerController.videoProgressNotifier.value;
    if (forward) {
      widget.customVideoPlayerController.videoPlayerController
          .seekTo(currentTimeStamp + _duration());
    } else {
      widget.customVideoPlayerController.videoPlayerController
          .seekTo(currentTimeStamp - _duration());
    }
  }

  IconData _forwardIcon() {
    final duration = widget
        .customVideoPlayerController.customVideoPlayerSettings.seekDuration;
    if (duration == SeekDuration.five) {
      return Icons.forward_5_rounded;
    } else if (duration == SeekDuration.ten) {
      return Icons.forward_10_rounded;
    }
    return Icons.forward_30_rounded;
  }

  IconData _replayIcon() {
    final duration = widget
        .customVideoPlayerController.customVideoPlayerSettings.seekDuration;
    if (duration == SeekDuration.five) {
      return Icons.replay_5_rounded;
    } else if (duration == SeekDuration.ten) {
      return Icons.replay_10_rounded;
    }
    return Icons.replay_30_rounded;
  }

  Duration _duration() {
    final duration = widget
        .customVideoPlayerController.customVideoPlayerSettings.seekDuration;
    if (duration == SeekDuration.five) {
      return const Duration(seconds: 5);
    } else if (duration == SeekDuration.ten) {
      return const Duration(seconds: 10);
    }
    return const Duration(seconds: 30);
  }
}
