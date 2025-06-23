/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTunes',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
        // accentColor: Colors.pink,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String previewUrl;
  final String genre;
  final String imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.previewUrl,
    required this.genre,
    required this.imageUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final track = json['data'][0];
    return Song(
      id: track['id'].toString(),
      title: track['title'],
      artist: track['artist']['name'],
      album: track['album']['title'],
      previewUrl: track['preview'],
      genre: track['genres']['data'].isNotEmpty ? track['genres']['data'][0]['name'] : 'Unknown',
      imageUrl: track['album']['cover_medium'],
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('MoodTunes', style: TextStyle(fontSize: 32, color: Colors.orange, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: Size(double.infinity, 50)),
              child: Text('Login', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: Text('Sign Up', style: TextStyle(color: Colors.pink)),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _mood = 'Happy';
  String _language = 'Hindi';
  String _searchQuery = '';
  List<Song> _songs = [];
  List<Song> _favorites = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    //_loadFavorites();
    _fetchSongs();
  }

*/
/*
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favorites = favoritesJson.map((json) => Song.fromJson(jsonDecode(json))).toList();
    });
  }
*/ /*


*/
/*
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favorites.map((song) => jsonEncode({'data': [song]})).toList();
    await prefs.setStringList('favorites', favoritesJson);
  }
*/ /*


  Future<void> _fetchSongs() async {
    setState(() => _isLoading = true);
    String query;
    if (_searchQuery.isNotEmpty) {
      query = '$_searchQuery $_language';
    } else {
      final moodLanguageMap = {
        'Happy': {'Hindi': 'Bollywood happy', 'English': 'English pop happy'},
        'Sad': {'Hindi': 'Bollywood sad', 'English': 'English sad'},
        'Energetic': {'Hindi': 'Bollywood dance', 'English': 'English upbeat'},
        'Calm': {'Hindi': 'Bollywood romantic', 'English': 'English calm'},
      };
      query = moodLanguageMap[_mood]![_language] ?? 'Bollywood';
    }

    try {
      final response = await http.get(Uri.parse('https://api.deezer.com/search?q=$query&limit=5'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _songs = (data as Map<String, dynamic>).containsKey('data')
              ? (data['data'] as List).map((json) => Song.fromJson({'data': [json]})).toList()
              : [];
        });
      } else {
        setState(() => _songs = []);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => _songs = []);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _toggleFavorite(Song song) {
    setState(() {
      if (_favorites.any((s) => s.id == song.id)) {
        _favorites.removeWhere((s) => s.id == song.id);
      } else {
        _favorites.add(song);
      }
      //_saveFavorites();
    });
  }

*/
/*
  void _playPreview(String previewUrl) async {
    await _audioPlayer.play(UrlSource(previewUrl));
  }
*/ /*


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoodTunes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Genre Selection (Hardcoded Tabs)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Pop', 'Rock', 'Bollywood', 'Jazz']
                    .map((genre) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchQuery = genre;
                      _fetchSongs();
                    });
                  },
                  child: Chip(
                    label: Text(genre, style: TextStyle(color: Colors.white)),
                    backgroundColor: _searchQuery == genre ? Colors.orange : Colors.grey[800],
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ))
                    .toList(),
              ),
              SizedBox(height: 20),
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Hindi/English Songs',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                        _fetchSongs();
                      });
                    },
                  )
                      : null,
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  setState(() {
                    _searchQuery = value;
                    _fetchSongs();
                  });
                },
              ),
              SizedBox(height: 20),
              // Mood Selection
              Text('Select Mood', style: TextStyle(fontSize: 18, color: Colors.white70)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMoodButton('Happy', '😊'),
                  _buildMoodButton('Sad', '😢'),
                  _buildMoodButton('Energetic', '😄'),
                  _buildMoodButton('Calm', '🧘'),
                ],
              ),
              SizedBox(height: 20),
              // Language Selection
              Text('Select Language', style: TextStyle(fontSize: 18, color: Colors.white70)),
              DropdownButton<String>(
                value: _language,
                items: ['Hindi', 'English']
                    .map((lang) => DropdownMenuItem(
                  value: lang,
                  child: Text(lang, style: TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _language = value!;
                  _fetchSongs();
                }),
                dropdownColor: Colors.grey[800],
                underline: Container(height: 2, color: Colors.orange),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              // Mood-based Playlist
              _isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.orange))
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$_mood Playlist', style: TextStyle(fontSize: 20, color: Colors.orange)),
                  SizedBox(height: 10),
                  _buildSongList(_songs),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(String mood, String emoji) {
    return GestureDetector(
      onTap: () => setState(() {
        _mood = mood;
        _searchQuery = '';
        _searchController.clear();
        _fetchSongs();
      }),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _mood == mood ? Colors.orange : Colors.grey[800],
          shape: BoxShape.circle,
          boxShadow: _mood == mood ? [BoxShadow(color: Colors.orangeAccent, blurRadius: 10)] : [],
        ),
        child: Text(emoji, style: TextStyle(fontSize: 28)),
      ),
    );
  }

  Widget _buildSongList(List<Song> songs) {
    if (songs.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text('No songs found', style: TextStyle(color: Colors.grey[400])),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.music_note, color: Colors.grey),
              ),
            ),
            title: Text(
              song.title.length > 30 ? '${song.title.substring(0, 30)}...' : song.title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${song.artist} - ${song.album}',
              style: TextStyle(color: Colors.grey[400]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    _favorites.any((s) => s.id == song.id) ? Icons.favorite : Icons.favorite_border,
                    color: Colors.pink,
                  ),
                  onPressed: () => _toggleFavorite(song),
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.orange, size: 28),
                  onPressed: () {
                    //    _playPreview(song.previewUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SongDetailScreen(song: song)),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SongDetailScreen extends StatelessWidget {
  final Song song;
  final AudioPlayer _audioPlayer = AudioPlayer();

  SongDetailScreen({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Song Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(song.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(song.title, style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('${song.artist} - ${song.album}', style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:  () {}  ,   //  =>    _audioPlayer.play(UrlSource(song.previewUrl)),

              child: Text('Play 30-sec Preview', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {_audioPlayer.dispose();
    //super.dispose();
  }
}*/
