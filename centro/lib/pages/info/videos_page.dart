import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/models/video.dart';
import 'package:centro/widgets/base_page.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late Future<List<Video>> futureVideos;
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    futureVideos = ApiService().getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Videos',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Video>>(
          future: futureVideos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay videos disponibles.'));
            } else {
              final video = snapshot.data![0]; // Solo un video en la lista

              // Inicializa el controlador para el video
              _controller = YoutubePlayerController(
                initialVideoId: video.link,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              );

              return Column(
                children: [
                  YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.redAccent,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.redAccent,
                      handleColor: Colors.redAccent,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(video.titulo),
                      subtitle: Text(video.descripcion),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
