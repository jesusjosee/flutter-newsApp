import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: const _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context, listen: false);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        // ignore: avoid_print
        onTap: (i) => {
              navegacionModel.paginaActual = i,
              // newsService.categoryArticles[newsService.selectedCategory] =
              //     newsService.headlines,
            },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Para ti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: 'Encabezados'),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: const BouncingScrollPhysics(),//scroll de paginas
      physics: const NeverScrollableScrollPhysics(),

      children: const [
        Tab1Page(),
        Tab2PAge()
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int value) {
    _paginaActual = value;
    //navegacion
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 250), 
      curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
