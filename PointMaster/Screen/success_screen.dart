// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/login_provider.dart';
//
// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<LoginProvider>(context).user;
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "로그인 성공${user?.email}님 환영합니다!",
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await Provider.of<LoginProvider>(context, listen: false)
//                     .signOut();
//                 Navigator.pushNamed(context, '/success');
//               },
//               child: Text("로그아웃"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
