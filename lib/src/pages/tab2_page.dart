import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2PAge extends StatelessWidget {
  const Tab2PAge({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    print(newsService.categoryArticles);

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const _ListaCategorias(),

          (newsService.isLoading)
              ? const Expanded(
                  child: Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 15),
                      //   child: const Text(
                      //     'Seleciona una Categoria',
                      //     style: TextStyle(fontSize: 30),
                      //   ),
                      // )
                    ],
                  ),
                )
              : Expanded(
                  child: ListaNoticias(
                      newsService.getArticulosCategoriaSelecionada))
        ]),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final capitalizeCategory = categories[index].name;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    '${capitalizeCategory[0].toUpperCase()}${capitalizeCategory.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // print(categoria.name);
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == categoria.name)
              ? Colors.red
              : Colors.black54,
        ),
      ),
    );
  }
}
