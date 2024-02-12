import 'package:music_app/models/song_model.dart';

class Playlist
{
  final String title;
  final List<Song>song;
  final String imageurl;

  Playlist({
    required this.title, 
    required this.song, 
    required this.imageurl
    });

    static List<Playlist> playlist = [
      Playlist(
        title: 'Hip Hop', 
        song: Song.song, 
        imageurl: 'https://images.unsplash.com/photo-1601643157091-ce5c665179ab?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aGlwJTIwaG9wfGVufDB8fDB8fHww'),
      
      Playlist(
        title: 'Rock', 
        song: Song.song, 
        imageurl: 'https://images.unsplash.com/photo-1477927849362-0fb1e7d59ee6?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cm9jayUyMGFuZCUyMHJvbGx8ZW58MHx8MHx8fDA%3D'),
      
      Playlist(
        title: 'jazz', 
        song: Song.song, 
        imageurl: 'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8amF6enxlbnwwfHwwfHx8MA%3D%3D'),
    ];
}