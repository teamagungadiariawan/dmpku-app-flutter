import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/dashboard/dashboard_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/main';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  double _IconSize = 30;

  // PageController untuk smooth transition
  final PageController _pageController = PageController();

  // List of pages - state akan tetap terjaga
  final List<Widget> _pages = [
    const DashboardPage(),
    const SearchPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.background,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
          ],
          border: Border(top: BorderSide(color: context.border, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.primary,
          unselectedItemColor: context.foreground,
          unselectedFontSize: 14,
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveHome.image(
                width: _IconSize,
                height: _IconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveHome.image(
                width: _IconSize,
                height: _IconSize,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveRiwayat.image(
                width: _IconSize,
                height: _IconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveRiwayat.image(
                width: _IconSize,
                height: _IconSize,
              ),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactivePromo.image(
                width: _IconSize,
                height: _IconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActivePromo.image(
                width: _IconSize,
                height: _IconSize,
              ),
              label: 'PROMO!',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveOfficial.image(
                width: _IconSize,
                height: _IconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveOfficial.image(
                width: _IconSize,
                height: _IconSize,
              ),
              label: 'Official',
            ),
            BottomNavigationBarItem(
              icon: Assets.img.bottomNav.icInactiveProfile.image(
                width: _IconSize,
                height: _IconSize,
              ),
              activeIcon: Assets.img.bottomNav.icActiveProfile.image(
                width: _IconSize,
                height: _IconSize,
              ),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}

// Home Page dengan state yang persistent
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;

  @override
  bool get wantKeepAlive => true; // Ini yang membuat state tetap terjaga

  @override
  Widget build(BuildContext context) {
    super.build(
      context,
    ); // Wajib dipanggil saat menggunakan AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter akan tetap terjaga saat pindah tab:',
              textAlign: TextAlign.center,
            ),
            Text('$_counter', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Page
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      _searchResults = List.generate(
        5,
        (index) => '${_searchController.text} - Result ${index + 1}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search something...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.search),
                    title: Text(_searchResults[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Favorite Page
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin {
  final List<String> _favorites = ['Item 1', 'Item 2', 'Item 3'];

  @override
  bool get wantKeepAlive => true;

  void _addFavorite() {
    setState(() {
      _favorites.add('Item ${_favorites.length + 1}');
    });
  }

  void _removeFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: Text(_favorites[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeFavorite(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFavorite,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('john.doe@example.com'),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
