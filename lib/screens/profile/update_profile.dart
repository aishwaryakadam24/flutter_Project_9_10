




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../fb_controller/firestore_controller.dart';
import '../../model/user_model.dart';
import '../../shared_preferences/user_preferences_controler.dart';
import '../../utilities/helpers.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  late double width;
  late double height;
  late TextEditingController _usernameTextController;
  late TextEditingController _emailTextController;

  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _addressError;
  String? _genderError;
  String? _birthDateError;


  late String profileImage;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _emailTextController = TextEditingController();

    _usernameTextController.text =
        UserPreferenceController().name;
    _emailTextController.text =
        UserPreferenceController().email;



  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Update Profile',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.black45,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.7),
          child: IconButton(
            color: Colors.grey,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/app_screen');
            },
            icon:Icon(Iconsax.back_square),
          ),
        ),

      ),
      body:RefreshIndicator(
        onRefresh: () async{
          _usernameTextController.text =
              UserPreferenceController().name;
          _emailTextController.text =
              UserPreferenceController().email;

        },
        child:  OrientationBuilder(
          builder: (context, orientation) {

            // }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: width / 15.1),
              child: ListView(
                children: [
                  SizedBox(height: height / 20),

                  SizedBox(height: height / 27.7),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 100,
                    child: TextField(
                      controller: _usernameTextController,
                      decoration: InputDecoration(
                        label: const Text('Name'),
                        errorText: _usernameError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 100,
                    child: TextField(
                      controller: _emailTextController,
                      enabled: false,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        errorText: _emailError,
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height / 18.689),
                  ElevatedButton(
                    onPressed: () async => await performUpdateUserInformation(),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),

                    ),


                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> performUpdateUserInformation() async {
    if (checkData()) {
      await updateUserInformation();
    }
  }

  bool checkData() {
    if (checkFieldError()) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter required data', error: true);
    return false;
  }

  bool checkFieldError() {
    bool username = checkUsername();
    bool email = checkEmail();

    setState(() {
      _usernameError = !username ? 'Enter username !' : null;
      _emailError = !email ? 'Enter email !' : null;

    });
    if (username && email) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUsername() {
    if (_usernameTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
  bool checkEmail() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }



  Future<Users> readData() async {
    Users users = Users();
    users.name = _usernameTextController.text;
    users.email = _emailTextController.text;

    users.id = UserPreferenceController().id;

    return users;
  }



  Future<void> updateUserInformation() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ));

    bool status = await FbFireStoreController()
        .updateUser(context: context, user: await readData());
    Navigator.pop(context);
    if (status) {
      showSnackBar(
          context: context, message: 'Update Profile Successfully', error: true);
    } else {
      showSnackBar(
          context: context, message: 'Update Profile Failed', error: true);
    }
  }


}

