import 'package:book_store/constance/my_color.dart';
import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:book_store/screens/cart_screen.dart';
import 'package:book_store/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../model/bn_screen.dart';
import 'home_screen.dart';

class AppScreen extends StatefulWidget{
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with FbNotifications {
  late int _currentIndex = 0;
  final List<BnScreen> _bnScreen = <BnScreen>[
    BnScreen(widget: HomeScreen(), title: 'Book'),
    BnScreen(widget: CartScreen(), title: 'Shop'),
    BnScreen(widget: ProfileScreen(), title: 'Profile'),
  ];


  @override
  void initState(){
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
          currentIndex: _currentIndex,
        selectedIconTheme: IconThemeData(color: Colors.black),

        
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book),
            activeIcon: Icon(Iconsax.book, color: Theme.of(context).colorScheme.secondary),
            label: 'Books',
            tooltip: 'Browse books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_cart),
            activeIcon: Icon(Iconsax.book, color: Theme.of(context).colorScheme.secondary),
            label: 'Cart',
            tooltip: 'View your cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            activeIcon: Icon(Iconsax.book, color: Theme.of(context).colorScheme.secondary),
            label: 'Profile',
            tooltip: 'Your profile',
          ),
        ],
      ),
      body: _bnScreen[_currentIndex].widget,
    );

  }


}

