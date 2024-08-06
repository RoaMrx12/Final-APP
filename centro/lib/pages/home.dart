import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:centro/widgets/base_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();

    // Configurar el controlador de YouTube
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=lX28t4QeQuI')!,
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'lib/assets/logos/minerdLogoColor.jpeg', 
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Video de YouTube
            Container(
              height: 200,
              child: YoutubePlayer(
                controller: _youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
