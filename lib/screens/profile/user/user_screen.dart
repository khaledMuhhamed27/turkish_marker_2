import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/bloc/get_user_data/bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String email;
  late String token;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? "";
    print(prefs.getString("email"));
    token = prefs.getString("token") ?? "";
    print(prefs.getString("token"));

    if (email.isNotEmpty && token.isNotEmpty) {
      // ignore: use_build_context_synchronously
      context.read<UserBloc>().add(LoadUserEvent(email: email, token: token));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name: ${state.user.name}"),
                  Text("Email: ${state.user.email}"),
                  Text(
                      "Mobile: ${state.user.mobileIntro} ${state.user.mobile}"),
                ],
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return Center(child: Text("No data loaded"));
        },
      ),
    );
  }
}
