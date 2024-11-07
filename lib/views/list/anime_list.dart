import 'package:flutter/material.dart';
import 'package:modul_3/models/anime_model.dart';
import 'package:modul_3/presenters/anime_presenter.dart';
import 'package:modul_3/views/detail/anime_detail.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen>
  

    implements AnimeView {
  late AnimePresenter _presenter;
  bool _isLoading = false;
  List<Anime> _animeList = [];
  String? _errorMessage;
  String _currentEndpoint = 'akatsuki';

  @override
  void initState() {
    super.initState();
    _presenter = AnimePresenter(this);
    _presenter.loadAnimedata(_currentEndpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadAnimedata(endpoint);
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAnimeList(List<Anime> animeList) {
    setState(() {
      _animeList = animeList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        title: const Text("Anime List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                    onTap: () => _fetchData('akatsuki'),
                    child: Container(
                      color: _currentEndpoint=='akatsuki'? Colors.yellow.shade300:Colors.yellow.shade100,
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text("Akatsuki"))),
              ),
              Expanded(
                child: InkWell(
                    onTap: () => _fetchData('kara'), child: Container(
                      color: _currentEndpoint=='kara'? Colors.yellow.shade300:Colors.yellow.shade100,
                      alignment: Alignment.center,
                      height: 40,
                      child: const Text("Kara"))),
              )
            ],
          ),
          Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text("Error : ${_errorMessage}"))
                      : ListView.builder(
                          itemCount: _animeList.length,
                          itemBuilder: (context, index) {
                            final anime = _animeList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                              child: InkWell(
                                 onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            id: anime.id,
                                            endpoint: _currentEndpoint)));
                              },
                                child: Card(
                                  child: SizedBox(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12)
                                            ),
                                            image: DecorationImage(image: NetworkImage(anime.imageUrl.isNotEmpty?anime.imageUrl:'https://placehold.co/600x400'), fit: BoxFit.cover)),
                                        )),
                                        SizedBox(
                                          width: 280,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0, top: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(anime.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                Text(anime.familyCreator)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                ),
                              ),
                            );
                          }))
        ],
      ),
    );
  }
}
