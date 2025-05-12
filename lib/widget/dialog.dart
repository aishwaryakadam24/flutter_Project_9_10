// import 'package:flutter/material.dart';
//
// void test(){
//   return  showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 10.0),
//               Image.asset("images/warning.png", width: 45.0),
//               const SizedBox(height: 20.0),
//               Text('Oops!', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800, color: Color(0xFFE04F5F))),
//               const SizedBox(height: 20.0),
//               Text('Are you sure you want to delete this task', textAlign: TextAlign.center, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color:Colors.black, )),
//               const SizedBox(height: 10.0),
//               TextButton(
//                 style: ButtonStyle(
//                   // backgroundColor: MaterialStateProperty.all<Color>(_accentColor),
//                     padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0)),
//                     shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ))
//                 ),
//                 child: Text('', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800, color: Colors.white)),
//                 onPressed: (){
//
//                 },
//               ),
//               Row(
//                 children: [
//
//                   Expanded(
//                       flex: 1,
//                       child: ElevatedButton(onPressed: (){
//                         User?user =_firebaseAuth.currentUser;
//                         String uid= user!.uid;
//                         if(uid ==uploadedBy){
//                           FirebaseFirestore.instance.collection('tasks')
//                               .doc(taskId)
//                               .delete();
//                           showSnackBar(context: context, message: 'task deleted successfully',error: false);
//
//                           Navigator.pop(context);
//                         }else{
//                           showSnackBar(context: context, message: 'You can\'t delete this task',error: true);
//                           Navigator.pop(context);
//                         }
//
//                       }, child: Text('Delete'),style: ElevatedButton.styleFrom(primary: Colors.red),)),
//                   SizedBox(width: 10,),
//                   Expanded(
//                       flex: 1,
//                       child: ElevatedButton(onPressed: (){
//                         Navigator.pop(context);
//                       }, child: Text('Cancle'),style: ElevatedButton.styleFrom(primary: Colors.grey),)),
//
//                 ],
//               ),
//             ],
//           ),
//         );
//         // return SimpleDialog(
//         //   title: Text('Oops!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, color: Color(0xFFE04F5F))),
//         //   contentPadding: EdgeInsets.all(24.0),
//         //   children: [
//         //     Image.asset("assets/icons/close.png", scale: 2),
//         //     Text('Something went wrong.')
//         //   ],
//         // );
//       }
//   );
// }