import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yapilacaklar_listesi/camera/camera.dart';
import 'package:yapilacaklar_listesi/hes_gallery/galleryPage.dart';
import 'package:yapilacaklar_listesi/loader/screen/loading_screen.dart';
import 'package:yapilacaklar_listesi/main.dart';
import 'package:yapilacaklar_listesi/maps/maps.dart';
export 'package:yapilacaklar_listesi/navigation.dart';
import 'package:yapilacaklar_listesi/theming/ThemeModel.dart';
import 'package:yapilacaklar_listesi/compass/Compass.dart';
import 'package:yapilacaklar_listesi/calculator/calculator.dart';
import 'package:yapilacaklar_listesi/translator/translation-page.dart';

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
          home: const MyHomePage(title: 'Kişisel Alet Çantam'),
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
  Widget stateNav = LoadingScreen();
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
                  'https://avatars.githubusercontent.com/u/26030027?v=4'), //resim alanaı -zeynep resmi
            ),
            accountEmail: Text('zeynep@example.com'),
            accountName: Text(
              'Zeynep ',
              style: TextStyle(fontSize: 23.0),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple),
            // child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text(
              'Alışveriş Sepetlerim',
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
            leading: const Icon(Icons.house_outlined),
            title: const Text(
              'Hes Kodlarım',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = GalleryPage();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.apartment),
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
          const Divider(
            height: 10,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
              'Kamera',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = CameraScreen();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
              'Çeviri',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = TranslatePage();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
              'Konum',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              setState(() {
                stateNav = Maps();
              });
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
              activeColor: Colors.yellowAccent,
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
