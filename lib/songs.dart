import 'package:meta/meta.dart';

final demoPlaylist = new DemoPlaylist(
  songs: [
    new DemoSong(
      audioUrl: 'http://www.ytmp3.cn/down/32325.mp3',
      albumArtUrl: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535386419949&di=791d0517618d03f2f9b281aadcf77cbc&imgtype=0&src=http%3A%2F%2Fmusic.migu.cn%2Fcmsupload%2F12002%2Fupload%2Fzt%2Fb6c0d531-b7df-40a3-811d-4dc41df18fd7.jpg',
      songTitle: 'Perfect Saxophone',
      artist: 'Simon More',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/402538329/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/avatars-000344712337-f6po4d-t120x120.jpg',
      songTitle: 'Simply',
      artist: 'Kumbor',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/266891990/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Electro Monotony',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/260578593/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Debut Trance',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/258735531/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/artworks-000165346750-e36z3a-t500x500.jpg',
      songTitle: 'Debut',
      artist: 'Nights & Weekends',
    ),
    new DemoSong(
      audioUrl: 'https://api.soundcloud.com/tracks/9540352/stream?secret_token=s-tj3IS&client_id=LBCcHmRB8XSStWL6wKH2HPACspQlXg2P',
      albumArtUrl: 'https://i1.sndcdn.com/avatars-000215855222-tic5d8-t120x120.jpg',
      songTitle: 'Assn1-tribal-beat',
      artist: 'Matt',
    ),
  ],
);

class DemoPlaylist {

  final List<DemoSong> songs;

  DemoPlaylist({
    @required this.songs,
  });

}

class DemoSong {

  final String audioUrl;
  final String albumArtUrl;
  final String songTitle;
  final String artist;

  DemoSong({
    @required this.audioUrl,
    @required this.albumArtUrl,
    @required this.songTitle,
    @required this.artist,
  });

}