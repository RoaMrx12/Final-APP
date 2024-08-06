import 'package:centro/pages/info/noticia_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/widgets/base_page.dart';
import 'package:centro/models/noticia.dart';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  late Future<List<Noticia>> futureNoticias;

  @override
  void initState() {
    super.initState();
    futureNoticias = ApiService().getNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Noticias',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Noticia>>(
          future: futureNoticias,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay noticias disponibles.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final noticia = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      leading: Image.network(
                        noticia.image,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Mostrar el ícono en lugar de la imagen si ocurre un error
                          return Icon(
                            Icons.picture_in_picture,
                            size: 100,
                            color: Colors.grey,
                          );
                        },
                      ),
                      title: Text(noticia.title),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticiaDetailPage(noticia: noticia),
                            ),
                          );
                        },
                        child: Text('Ver más'),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
