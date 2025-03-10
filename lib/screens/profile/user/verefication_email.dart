// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:turkesh_marketer/bloc/get_user_data/bloc/user_bloc.dart';
// import 'package:turkesh_marketer/widgets/loading_widgt.dart';
// import 'package:turkesh_marketer/widgets/my_input.dart';

// class VereficationEmail extends StatefulWidget {
//   const VereficationEmail({super.key});

//   @override
//   State<VereficationEmail> createState() => _VereficationEmailState();
// }

// class _VereficationEmailState extends State<VereficationEmail> {
//   final TextEditingController _emailController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   late String email;

//   late String token;
//   @override
//   void initState() {
//     super.initState();

//     //
//   }

//   // Future<void> _loadUserData() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   email = prefs.getString("email") ?? "";
//   //   token = prefs.getString("token") ?? "";
//   //   if (email.isNotEmpty && token.isNotEmpty) {
//   //     context.read<UserBloc>().add(LoadUserEvent(email: email, token: token));
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state is UserLoading) {
//             return LoadingWidgt();
//           } else if (state is UserLoaded) {
//             _emailController.text = state.user.email;

//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MyInput(
//                         yourController: _emailController,
//                         yourHintText: "Name",
//                       ),
//                       SizedBox(height: 20),
//                       MaterialButton(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.black54
//                             : Color(0xff475467),
//                         minWidth: MediaQuery.of(context).size.width * 0.9,
//                         onPressed: () {},
//                         child: Text(
//                           "Save Changes",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else if (state is UserError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           return Center(child: Text("No data loaded"));
//         },
//       ),
//     );
//   }
// }
