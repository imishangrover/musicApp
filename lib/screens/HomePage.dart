import 'package:flutter/material.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/song_model.dart';
import '../Widget/Widget.dart';

//import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Song> song = Song.song;
    List<Playlist> playlist =  Playlist.playlist;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(31, 25, 25, 25).withOpacity(0.8),
            Color.fromARGB(255, 30, 28, 28).withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DiscoverMusic(),
              TrandingMusic(song: song),
              PlaylistMusic(playlist: playlist)
            ]
            ),
        ),
      ),
    );
  }
}

class PlaylistMusic extends StatelessWidget {
  const PlaylistMusic({
    super.key,
    required this.playlist,
  });

  final List<Playlist> playlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SectionHeader(title: 'Playlist'),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20),
            physics: NeverScrollableScrollPhysics(),
            itemCount: playlist.length,
            itemBuilder: (context,index)
            {
              return PlaylistCard(playlist: playlist[index]);
            }
            ),
        ],
      ),
    );
  }
}

class TrandingMusic extends StatelessWidget {
  const TrandingMusic({
    super.key,
    required this.song,
  });

  final List<Song> song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: SectionHeader(title : 'Trending Music'),
          ),
          SizedBox(height: 20),
          SizedBox(height: MediaQuery.of(context).size.height*0.27,
           child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: song.length,
            itemBuilder: (contex,index)
            {
              return SongCard(song: song[index]);
            },
            ),
            ),
        ],
      ),
    );
  }
}

class DiscoverMusic extends StatelessWidget {
  DiscoverMusic({
    super.key,
  });
  final SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
        'Welcome',
        style: Theme.of(context)
        .textTheme
        .bodyLarge
      ),
      SizedBox(height:5),
          Text(
            'Enjoy your favorite music',
            style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 20,),
             
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(50),
            //color: Colors.grey,
            shadowColor: Colors.grey,
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 28, 27, 27),
                hintText: 'Search',
                hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade400),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400 ,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  )
              ),
              controller: SearchController,
              keyboardType: TextInputType.text,
            ),
          )
        ],
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
        icon: Icon(
          Icons.home
          ),
          label: 'Home'
        ),
        BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite_outline
          ),
          label: 'Favorite'
        ),
        BottomNavigationBarItem(
        icon: Icon(
          Icons.play_circle_outline
          ),
          label: 'Play'
        ),
        BottomNavigationBarItem(
        icon: Icon(
          Icons.people_outline
          ),
          label: 'Profile'
        ),
        ]
        );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(
        Icons.grid_view_rounded,
        color: Colors.white,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1458560871784-56d23406c091?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fG11c2ljfGVufDB8fDB8fHww'
            ),
          )
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
