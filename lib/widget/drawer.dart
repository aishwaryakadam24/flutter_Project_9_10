import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../fb_controller/fb_auth_controller.dart';
import '../shared_preferences/user_preferences_controler.dart';
import '../utilities/helpers.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      child: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'images/menu2.svg',
                    color: Colors.red,
                  ),
                )),
            Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        children: [
                          Container(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 15),
                                    ],
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
                                    child: Container(),
                                  ),
                                ),
                              ),
                              title: Text(
                                UserPreferenceController().name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                              subtitle: Text(
                                UserPreferenceController().email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          'images/sun.svg',
                          color: Theme.of(context).disabledColor,
                        ),
                        onPressed: () {},
                      ),
                      title: Text(
                        'Dark Mood',
                        style: TextStyle(
                          fontSize: 18,
                          // color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // trailing: SwitchButtonFlutter(),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/test');
                        },
                        child: CardInDrawer(
                          iconUrl: 'images/info.svg',
                          name: 'Account Info',
                        )),
                    InkWell(
                        onTap: () {},
                        child: CardInDrawer(
                          iconUrl: 'images/Lock.svg',
                          name: 'Password',
                        )),
                    CardInDrawer(
                      iconUrl: 'images/bag.svg',
                      name: 'Orders',
                    ),
                    CardInDrawer(
                      iconUrl: 'images/card.svg',
                      name: 'My Carts',
                    ),
                    CardInDrawer(
                      iconUrl: 'images/Vector.svg',
                      name: 'Love',
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/setting_screen');
                      },
                      child: CardInDrawer(
                          iconUrl: 'images/Setting.svg',
                          name: 'Settings'),
                    ),
                    InkWell(
                      onTap: () async {
                        await UserPreferenceController().loggedOut();
                        await FbAuthController().signOut();
                        showSnackBar(
                            context: context, message: 'Logout Successfully');
                        Navigator.pushReplacementNamed(
                            context, '/login_screen');
                      },
                      child: ListTile(
                        leading: IconButton(
                          icon: SvgPicture.asset(
                            'images/Logout.svg',
                            color: Colors.red,
                          ),
                          onPressed: () async {},
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

class CardInDrawer extends StatelessWidget {
  final String name;
  final String iconUrl;

  CardInDrawer({
    required this.name,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: SvgPicture.asset(
          iconUrl,
          color: Colors.grey,
        ),
        onPressed: () {},
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          // color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
