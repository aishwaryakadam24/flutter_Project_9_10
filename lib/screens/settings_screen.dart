// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:provider/provider.dart';
// import '../provider/change_language_notifire.dart';
//
// class SettingScreen extends StatefulWidget {
//   @override
//   _SettingScreenState createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         leading: Builder(
//           builder: (context) {
//             return IconButton(onPressed: (){
//               Navigator.pushReplacementNamed(context, '/app_screen');
//             }, icon: Icon(Iconsax.back_square,color: Colors.black45,),
//             );
//           },
//         ),
//
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 23.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Iconsax.heart, color: Colors.black45),
//                   onPressed: (){
//
//                   },
//                 ),
//                 const SizedBox(width: 15.0),
//                 Icon(Iconsax.notification, color: Colors.black45),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Locale currentLanguage =Localizations.localeOf(context);
//           // String newLocal=  currentLanguage.languageCode=='en'?'ar':'en';
//           String newLocal =
//           Provider.of<ChangeLanguageNotifier>(context, listen: false)
//               .languageCode ==
//               'en'
//               ? 'ar'
//               : 'en';
//           Provider.of<ChangeLanguageNotifier>(context, listen: false)
//               .changeLanguage(languageCode: newLocal);
//         },
//         child: Icon(
//           Icons.language,
//           color: Colors.white,
//         ),
//       ),
//
//     );
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../provider/change_language_notifire.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _nontification = false;
  String _selectedGender = 'M';
  int _selectedCategory = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/app_screen');
              },
              icon: Icon(
                Iconsax.back_square,
                color: Colors.black45,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                Icon(Iconsax.notification, color: Colors.black45),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Notification'),
            subtitle: Text('Receive Notification'),
            value: _nontification,
            onChanged: (bool value) {
              setState(() {
                _nontification = value;
              });
            },
          ),
          SizedBox(height: 10),
          Divider(
            endIndent: 10,
            indent: 10,
            color: Theme.of(context).dividerColor,
            height: 1,
            thickness: 1,
          ),
          SizedBox(height: 10),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              Chip(
                label: Text(
                  'Business',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Programming',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Web',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'History',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Music',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),


          SizedBox(height: 20),
          Divider(
            endIndent: 10,
            indent: 10,
            color: Theme.of(context).dividerColor,
            height: 1,
            thickness: 1,
          ),
          SizedBox(height: 10),

          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              Chip(
                label: Text(
                  'Business',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Programming',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Web',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'History',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Chip(
                label: Text(
                  'Music',
                ),
                deleteIcon: Icon(Icons.close),
                deleteIconColor: Colors.red,
                onDeleted: () {},
                deleteButtonTooltipMessage: 'Delete Color',
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
