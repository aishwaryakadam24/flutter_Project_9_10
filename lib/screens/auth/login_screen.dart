import 'package:book_store/fb_controller/fb_auth_controller.dart';
import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:book_store/screens/app.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../../utilities/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers, FbNotifications {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Login',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: 'Cairo',
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              TextField(
                controller: _emailEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () async => await performLogin(),
                child: Container(
                  height: 60.0,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Center(
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register_screen');
                    },
                    child: Text('No account',
                        style: TextStyle(
                            color: Color(0xFF653bbf),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0)),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/reset_password');
                    },
                    child: Text('Forget',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign In
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    return _emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty;
  }

  Future<void> login() async {
    bool states = await FbAuthController().signIn(
      context: context,
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
    );
    if (states) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppScreen()),
      );
    }
  }
}
