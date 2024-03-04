import 'package:flutter/material.dart';
import '../models/playlist_model.dart';

class PlayListPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Playlist playlist =  Playlist.playlist[0];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
           const Color.fromARGB(31, 25, 25, 25).withOpacity(0.8),
            const Color.fromARGB(255, 30, 28, 28).withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('Playlist',
          style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                PlaylistInformation(playlist: playlist),
                const SizedBox(height: 30,),
                const PlayOrShuffleSwitch(),
                PlaylistSongs(playlist: playlist),
              ]
              ),
          ),
        ),
      ),
    );
  }
}

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlist.song.length,
      itemBuilder: (contex, index){
        return ListTile(
          leading: Text(
            '${index+1}',
            style: Theme.of(contex)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
          ),
          title: Text(
            playlist.song[index].title,
            style: Theme.of(contex)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: 
            Text('${playlist.song[index].descriptin} • ${formatDuration(playlist.song[index].duration)}'
            ),
            trailing: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
        ); 
      },
      );
  }
}

String formatDuration(Duration duration)
{
  String twoDigit(int n) => n.toString().padLeft(2,'0');
  String twoDigitMinutes = twoDigit(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigit(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

class PlayOrShuffleSwitch extends StatefulWidget {
  const PlayOrShuffleSwitch({
    super.key,
  });

  @override
  State<PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends State<PlayOrShuffleSwitch> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Stack(
          children: [ 
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: isPlay ? 0 : width * 0.45,
              child: Container(
                      height: 50,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
              ),
            Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Play',
                        style: TextStyle(
                          color: isPlay ? Colors.white : Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Icon(
                      Icons.play_circle,
                      color: isPlay ? Colors.white : Colors.grey,
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Shuffle',
                        style: TextStyle(
                          color: isPlay ? Colors.grey : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Icon(
                      Icons.shuffle,
                      color: isPlay ? Colors.grey : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]
        ),
      ),
    );
  }
}

class PlaylistInformation extends StatelessWidget {
  const PlaylistInformation({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            playlist.imageurl,
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.height*0.3,
            fit: BoxFit.cover,
          ),
        ),
        Text(
      playlist.title,
      style: Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontWeight: FontWeight.bold),
    )
      ],
    );
  }
}
