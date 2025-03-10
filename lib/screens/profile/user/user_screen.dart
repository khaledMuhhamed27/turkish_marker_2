import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/bloc/get_user_data/bloc/user_bloc.dart';
import 'package:turkesh_marketer/bloc/update/bloc/update_user_bloc.dart';
import 'package:turkesh_marketer/bloc/update/bloc/update_user_event.dart';
import 'package:turkesh_marketer/bloc/update/bloc/update_user_state.dart';
import 'package:turkesh_marketer/model/phone_number_class.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  late String email;
  late String token;
  bool isEditable = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? "";
    token = prefs.getString("token") ?? "";
    if (email.isNotEmpty && token.isNotEmpty) {
      context.read<UserBloc>().add(LoadUserEvent(email: email, token: token));
    }
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateUserBloc>().add(UpdateUserEvent(
            name: _nameController.text,
            email: _emailController.text,
            mobile: _mobileController.text,
            token: token,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateUserBloc, UpdateUserState>(
            listener: (context, state) {
              if (state is UserUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Profile updated successfully")));
                setState(() {
                  isEditable = false;
                });
                // إعادة تحميل بيانات المستخدم بعد التحديث (اختياري)
                context
                    .read<UserBloc>()
                    .add(LoadUserEvent(email: email, token: token));
              } else if (state is UpdateUserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.message}")));
              }
            },
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return LoadingWidgt();
            } else if (state is UserLoaded) {
              print("User Data Loaded: ${state.user}");
              print("countryId Type: ${state.user.countryId.runtimeType}");
              print("mobileIntro Type: ${state.user.mobileIntro.runtimeType}");

              _nameController.text = state.user.name;
              _emailController.text = state.user.email;
              _mobileController.text = state.user.mobile.toString();
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyInput(
                          yourController: _nameController,
                          yourHintText: "Name",
                          enable: isEditable,
                        ),
                        SizedBox(height: 20),
                        MyInput(
                          yourController: _emailController,
                          yourHintText: "Email",
                          enable: isEditable,
                        ),
                        SizedBox(height: 20),
                        MyInput(
                          yourController: _mobileController,
                          yourHintText: "Mobile",
                          enable: isEditable,
                        ),
                        SizedBox(height: 20),
                        isEditable
                            ? MaterialButton(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black54
                                    : Color(0xff475467),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                onPressed: _saveChanges,
                                child: Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : MaterialButton(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black54
                                    : Color(0xff475467),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                onPressed: () {
                                  setState(() {
                                    isEditable = true;
                                  });
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return Center(child: Text("No data loaded"));
          },
        ),
      ),
    );
  }
}
