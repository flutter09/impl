import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaViewer extends StatefulWidget {
  final String resource;

  MediaViewer({required this.resource});

  @override
  _MediaViewerState createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  // late CachedVideoPlayerController _videoController;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   if (widget.resource.endsWith('.mp4')) {
  //     _initializeVideoPlayer();
  //   }
  // }

  // @override
  // void dispose() {
  //   _videoController.dispose();
  //   super.dispose();
  // }
  //
  // void _initializeVideoPlayer() {
  //   _videoController = CachedVideoPlayerController.network(widget.resource);
  //   _videoController.initialize().then((_) {
  //     setState(() {});
  //     _videoController.play();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: Center(
        child: widget.resource.endsWith('.mp4')
            ? _videoController.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: CachedVideoPlayer(_videoController),
        )
            : const CircularProgressIndicator()
            : CachedNetworkImage(imageUrl: widget.resource),
      ),*/
    );
  }
}