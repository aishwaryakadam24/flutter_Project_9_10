import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:book_store/provider/change_language_notifire.dart';
import 'package:book_store/provider/new_product_provider.dart';
import 'package:book_store/provider/product_provider.dart';
import 'package:book_store/provider/book_provider.dart';
import 'package:book_store/screens/app.dart';
import 'package:book_store/screens/auth/login_screen.dart';
import 'package:book_store/screens/auth/register_screen.dart';
import 'package:book_store/screens/auth/reset_password.dart';
import 'package:book_store/screens/details_screen.dart';
import 'package:book_store/screens/home_screen.dart';
import 'package:book_store/screens/launch_screen.dart';
import 'package:book_store/screens/page_view_screen.dart';
import 'package:book_store/screens/products_screen.dart';
import 'package:book_store/screens/profile/profile_screen.dart';
import 'package:book_store/screens/profile/update_profile.dart';
import 'package:book_store/screens/settings_screen.dart';
import 'package:book_store/shared_preferences/app_preferences_controller.dart';
import 'package:book_store/shared_preferences/user_preferences_controler.dart';
import 'package:book_store/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:book_store/fb_controller/fb_books_controller.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferenceController().initSharedPreference();
  await AppSettingsPreferances().initPreferances();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB6ipjxYZVxAozkJvMeAMtg4o1m7jsCZGg",
        authDomain: "bookstore-b36be.firebaseapp.com",
        projectId: "bookstore-b36be",
        storageBucket: "bookstore-b36be.appspot.com",
        messagingSenderId: "1089451801214",
        appId: "1:1089451801214:web:04f476633ec93e748ab62f",
        measurementId: "G-GRTY5GWB5L",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  // --- CORRECTED MIGRATION BLOCK ---
try {
  final bool isMigrated = await UserPreferenceController().getRatingMigrationStatus();
  if (!isMigrated) {
    print('Starting rating migration...');
    final success = await FbBooksController().migrateRatings();
    if (success) {
      await UserPreferenceController().setRatingMigrationStatus(true);
      print('✅ Rating migration completed successfully');
    } else {
      print('⚠️ Rating migration failed');
    }
  }
} catch (e) {
  print('Migration error: $e');
}
// --- END MIGRATION BLOCK ---

  await FbNotifications.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<NewProductProvider>(
            create: (_) => NewProductProvider()),
        ChangeNotifierProvider<ChangeLanguageNotifier>(
            create: (_) => ChangeLanguageNotifier()),
        ChangeNotifierProvider<BookProvider>(
            create: (_) => BookProvider()),
      ],
      child: const MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: MyColor.orange,
          secondary: MyColor.lightBlue,
          surface: MyColor.white,
          background: MyColor.lightYellow,
          error: Colors.red,
          onPrimary: MyColor.white,
          onSecondary: MyColor.white,
          onSurface: MyColor.black,
          onBackground: MyColor.black,
          onError: MyColor.white,
        ),
        scaffoldBackgroundColor: MyColor.white,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColor.orange,
          foregroundColor: MyColor.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyColor.white,
          selectedItemColor: MyColor.orange,
          unselectedItemColor: Colors.grey[400],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.orange,
            foregroundColor: MyColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/page_view_screen': (context) => PageViewScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/reset_password': (context) => ResetPassword(),
        '/product_screen': (context) => ProductsScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/details_screen': (context) => DetailScreen(),
        '/app_screen': (context) => AppScreen(),
        '/setting_screen': (context) => SettingScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/update_profile': (context) => EditProfileScreen(),
      },
    );
  }
}