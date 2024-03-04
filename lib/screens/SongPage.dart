import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../Widget/Widget.dart';

class SongPage extends StatefulWidget
{
  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  Song song = Song.song[0];
  String url = Song.song[0].coverUrl;


  @override
    void initState(){
      super.initState();
      song = Get.arguments ?? Song.song[0];
      audioPlayer = AudioPlayer();
      audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: [
            AudioSource.uri(
              Uri.parse(
              'asset:///${song.url}'
              )
            ),
             AudioSource.uri(
              Uri.parse(
              'asset:///${Song.song[1].url}'
              )
            ),
             AudioSource.uri(
              Uri.parse(
              'asset:///${Song.song[2].url}'
              )
            ),
          ]
        ),
      );
    }

    @override
    void dispose()
    {
      audioPlayer.dispose();
      super.dispose();
    }

    void changeBackground() {
      setState(() {
        url = song.coverUrl;
      });
    }

    Stream<SeekBarData> get _seekBarDataStream => 
    rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
      audioPlayer.positionStream,
      audioPlayer.durationStream,
      (Duration position, Duration? duration,)
      {
        return SeekBarData(position, duration ?? Duration.zero,);
      }
    );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            url,
            fit: BoxFit.cover,
          ),
          const BackgroundFilter(),
         
          MusicPlayer(
            song: song,
            seekBarDataStream: _seekBarDataStream, 
            audioPlayer: audioPlayer,
            changeBackground: changeBackground,
            ),
         
        ],
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
    required this.song,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.changeBackground
  }) : _seekBarDataStream = seekBarDataStream;

  final Song song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final Function changeBackground;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0, 
        vertical: 50
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
              song.title,
              style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          
          Text(
              song.descriptin,
              maxLines: 2,
              style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          
          SizedBox(height: 20),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream, 
            builder: 
            (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero, 
                duration: positionData?.duration ?? Duration.zero,
                onChanged: audioPlayer.seek,
              );
            }
          ),
          PlayerButtons(audioPlayer: audioPlayer, changeBackground: changeBackground)
        ],
      ),
    );
  }
}



class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect)
      {
        return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.0),
        Colors.white.withOpacity(0.5),
        Colors.white.withOpacity(0.99),
      ],
      stops:  const [
        0.0,
        0.3,
        0.7
      ]
              ).createShader(rect);
      },
      child: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.deepPurple.shade200,
        Colors.deepPurple.shade800,
      ],
              ),
            ),
      ),
    );
  }
}