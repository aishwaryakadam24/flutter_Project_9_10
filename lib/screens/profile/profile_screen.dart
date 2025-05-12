import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../fb_controller/fb_auth_controller.dart';
import '../../shared_preferences/user_preferences_controler.dart';
import '../../utilities/helpers.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late double width;
  late double height;


  bool _isLoading = false;
  String email ='';
  String name='';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isSameUser =true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }



  void getUserData()async {
    _isLoading = true;

    try{
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(UserPreferenceController().id).get();
      if (userDoc == null){
        return;
      }else{
        _isLoading = false;
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
        });
        User?user =_firebaseAuth.currentUser;
        String uid= user!.uid;
        setState(() {

        });
      }
    }catch (e){

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.black45,
          ),),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0,left: 15),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.edit, color: Colors.black45),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/update_profile');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body:_isLoading?Container(
        child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black,
              size: 25,
            ),),
      ):
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/user.jpg"),
                    backgroundColor: Colors.grey.shade300,
                  ),

                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text:name,
              icon: Icon(Iconsax.text),
              press: () => {
              },
            ),
            ProfileMenu(
              text:email,
              icon: Icon(Icons.email),
              press: () {},
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {},
                child: Row(
                  children: [
                    SvgPicture.asset('images/Lock.svg'),
                    SizedBox(width: 20),
                    Expanded(child: Text('*****')),
                    IconButton(
                      onPressed: () async {

                      },
                      icon: Icon(Iconsax.arrow_circle_right,color: Colors.black,),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {},
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text('Logout')),
                    IconButton(
                      onPressed: () async {
                        await UserPreferenceController().loggedOut();
                        await FbAuthController().signOut();
                        showSnackBar(
                            context: context, message: 'Logout Successfully');
                        Navigator.pushReplacementNamed(
                            context, '/login_screen');
                      },
                      icon: Icon(Iconsax.logout,color: Colors.red,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            // Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
