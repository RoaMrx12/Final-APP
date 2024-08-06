import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:centro/widgets/base_page.dart';
import 'package:centro/models/video.dart';

class VideoDetailPage extends StatelessWidget {
  final Video video;

  VideoDetailPage({required this.video});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(video.link) ?? '';

    return BasePage(
      title: video.titulo,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
            SizedBox(height: 16),
            Text(
              video.titulo,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              video.descripcion,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver a Videos'),
            ),
          ],
        ),
      ),
    );
  }
}
