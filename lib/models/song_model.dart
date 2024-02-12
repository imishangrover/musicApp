class Song
{
  final String title;
  final String descriptin;
  final String url;
  final String coverUrl;
  final Duration duration;

  Song({
    required this.descriptin,
    required this.url,
    required this.title,
    required this.coverUrl,
    required this.duration,
    });

  static List<Song> song = [
    Song(
      descriptin: 'ENNA SONA', 
      url: 'assets/music/ENNA SONA TENU RAB NE.mp3', 
      title: 'ENNA SONA', 
      coverUrl: 'assets/images/image1.jpg',
      duration: Duration(minutes: 3, seconds: 30),
      ),
      Song(
      descriptin: 'IKK KUDI', 
      url: 'assets/music/IKK KUDI.mp3', 
      title: 'IKK KUDI', 
      coverUrl: 'assets/images/image2.jpg',
      duration: Duration(minutes: 4, seconds: 15),
      ),
      Song(
      descriptin: 'TERA HONE LAGA HOON', 
      url: 'assets/music/TERA HONE LAGA HOON.mp3', 
      title: 'TERA HONE LAGA HOON', 
      coverUrl: 'assets/images/image3.jpg',
      duration: Duration(minutes: 5, seconds: 10),
      ),
  ];
}