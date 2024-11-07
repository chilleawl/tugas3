import 'package:flutter/material.dart';
import 'package:modul_3/network/base_network.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.endpoint});
  final int id;
  final String endpoint;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async {
    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade100,
          title: Text("Detail"),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text("Error ${_errorMessage}"))
                : _detailData != null
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                      child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                
                                image: DecorationImage(image: NetworkImage(_detailData!['images'][0] ??
                                  'https://placehold.co/600x400'),fit: BoxFit.cover),
                                borderRadius: BorderRadius.all(Radius.circular(22))
                              ),
                             
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text("${_detailData!['name']}", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                            ),
                            Text("${_detailData!['personal']['titles']?? 'None'}"),
                          
                            Padding(
                              padding: const EdgeInsets.only(top:12.0),
                              child: Text(
                                  "Kekkei Genkai : ${_detailData!['personal']['kekkeiGenkai'] ?? 'Empty'}", textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                    )
                    : Text("Tidak ada data!"));
  }
}
