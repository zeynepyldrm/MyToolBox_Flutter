import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yapilacaklar_listesi/hes_gallery/galleryPage.dart';
import 'package:yapilacaklar_listesi/main.dart';
export 'package:yapilacaklar_listesi/navigation.dart';
import 'package:yapilacaklar_listesi/theming/ThemeModel.dart';
import 'package:yapilacaklar_listesi/compass/Compass.dart';
import 'package:yapilacaklar_listesi/calculator/calculator.dart';
import 'package:yapilacaklar_listesi/game/Game.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
          home: const MyHomePage(title: 'BubbleApp'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);
  final String title;

  const MyHomePage({this.title = ''});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var imagesVisible;

  var cardContent = [];
  Widget stateNav = MyTodoApp();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      imagesVisible = themeNotifier;
      return Scaffold(
          appBar: _buildAppBar(themeNotifier),
          body: stateNav,
          drawer: _buildDrawer(context));
    });
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cutewallpaper.org/21/purple-bubble-background/Set-universal-colorful-bubble-in-vector-Soap-bubbles-on-purple.jpg'), //resim alanaı -zeynep resmi
            ),
            accountEmail: Text(''),
            accountName: Text(
              'BubbleApp',
              style: TextStyle(fontSize: 23.0),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple),
            // child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Notlar',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = MyTodoApp();
              });
            },
          ),
          //hes kod
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text(
              'Galeri',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = GalleryPage();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text(
              'Pusula',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = Compass();
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text(
              'Hesap Makinesi',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = CalculatorPage();
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.videogame_asset),
            title: const Text(
              'Oyun',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = ColorGame();
              });
            },
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'Ayarlar',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(ThemeModel themeNotifier) {
    return AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
        actions: [
          Switch(
              value: imagesVisible.isDark,
              activeColor: Colors.black,
              onChanged: (bool switchState) {
                setState(() {
                  /*switchState
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;  */
                  themeNotifier.isDark = switchState;
                });
              })
        ]);
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(),
    );
  }

  Card _buildCard(Map<String, dynamic> cardData) {
    return Card(
      elevation: 4.0,
    );
  }
}
