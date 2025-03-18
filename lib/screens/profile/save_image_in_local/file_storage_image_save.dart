// import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fuzzy/plugin_list.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/bloc/user_info_bloc.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/bloc/user_info_event.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/bloc/user_info_state.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/update/bloc/update_info_bloc.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/update/bloc/update_info_event.dart';
// import 'package:fuzzy/screens/bottom_screens/profile_screen/update/bloc/update_info_state.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../config.dart';

// class ProfileSettingLayout extends StatefulWidget {
//   const ProfileSettingLayout({super.key});

//   @override
//   State<ProfileSettingLayout> createState() => _ProfileSettingLayoutState();
// }

// class _ProfileSettingLayoutState extends State<ProfileSettingLayout> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController birthdayController = TextEditingController();
//   String initialEmail = '';
//   File? _imageFile;

//   @override
//   void initState() {
//     super.initState();
//     _loadImage();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final savedPath = await _saveImage(File(pickedFile.path));

//       setState(() {
//         _imageFile = File(savedPath);
//       });
//       // مسح الكاش لضمان تحميل الصورة الجديدة
//       imageCache.clear();
//       imageCache.clearLiveImages();

//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         animType: AnimType.scale,
//         title: 'نجاح',
//         desc: 'تم تحديث صورة الملف الشخصي بنجاح!',
//       ).show();
//     }
//   }

//   Future<String> _saveImage(File imageFile) async {
//     final directory = await getApplicationDocumentsDirectory();
//     // استخدم توقيت مميز لتفادي استخدام نفس الاسم
//     final String newPath =
//         '${directory.path}/profile_picture_${DateTime.now().millisecondsSinceEpoch}.png';
//     await imageFile.copy(newPath);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('profile_picture_path', newPath);
//     return newPath;
//   }

//   Future<void> _loadImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final imagePath = prefs.getString('profile_picture_path');
//     if (imagePath != null && await File(imagePath).exists()) {
//       setState(() {
//         _imageFile = File(imagePath);
//       });
//       imageCache.clear();
//       imageCache.clearLiveImages();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DirectionLayout(
//         dChild: Scaffold(
//       backgroundColor: appColor(context).appTheme.backGroundColorMain,
//       body: SafeArea(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(children: [
//                 Stack(children: [
//                   ProfileWidget().topContainer(context),
//                   Center(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height * 0.08),
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 3),
//                       ),
//                       child: ClipOval(
//                         child: _imageFile != null
//                             ? Image.file(
//                                 _imageFile!,
//                                 key: UniqueKey(),
//                                 gaplessPlayback: true,
//                                 fit: BoxFit.cover,
//                               )
//                             : Image.asset(
//                                 imageAssets.imageProfilePic,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: MediaQuery.of(context).size.width * 0.4,
//                     child: GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: ProfileWidget().decorEdit(context),
//                         padding: const EdgeInsets.all(Insets.i4),
//                         child: SvgPicture.asset(svgAssets.iconEdit),
//                       ),
//                     ),
//                   ),
//                   // Choose Any Image
//                   Center(
//                       child: GestureDetector(
//                     onTap: () {
//                       _pickImage();
//                       print("click for choose");
//                     },
//                     child: Container(
//                             height: Sizes.s26,
//                             width: Sizes.s26,
//                             decoration: ProfileWidget().decorEdit(context),
//                             padding: const EdgeInsets.all(Insets.i4),
//                             margin: EdgeInsets.only(
//                                 top:
//                                     MediaQuery.of(context).size.height * 0.162),
//                             child: SvgPicture.asset(svgAssets.iconEdit))
//                         .paddingOnly(left: Insets.i56),
//                   ))
//                 ]),
//                 BlocBuilder<UserBloc, UserState>(
//                   builder: (context, state) {
//                     if (state is UserLoaded) {
//                       nameController.text = state.user.name;
//                       emailController.text = state.user.email;
//                       phoneController.text = state.user.phone;
//                       birthdayController.text =
//                           state.user.birthday ?? "1-1-2000";
//                       initialEmail = state.user.email; // تخزين البريد الأصلي
//                     }

//                     return Column(children: [
//                       ProfileWidget().textLayout(
//                           language(context, appFonts.name), context),
//                       const VSpace(Sizes.s6),
//                       SearchTextFieldCommon(
//                         hintStyle: appCss.dmPoppinsRegular13
//                             .textColor(appColor(context).appTheme.lightText),
//                         prefixIcon: ProfileWidget()
//                             .svgImage(context, svgAssets.iconProfile),
//                         hintText: "Enter your name",
//                         keyboardType: TextInputType.text,
//                         controller: nameController,
//                       ),
//                       const VSpace(Sizes.s15),
//                       ProfileWidget().textLayout(
//                           language(context, appFonts.email), context),
//                       const VSpace(Sizes.s6),
//                       SearchTextFieldCommon(
//                         hintStyle: appCss.dmPoppinsRegular13
//                             .textColor(appColor(context).appTheme.lightText),
//                         prefixIcon: ProfileWidget()
//                             .svgImage(context, svgAssets.iconEmail),
//                         hintText: "Enter your email",
//                         keyboardType: TextInputType.text,
//                         controller: emailController,
//                       ),
//                       const VSpace(Sizes.s15),
//                       ProfileWidget().textLayout(
//                           language(context, appFonts.phoneNumberProfile),
//                           context),
//                       const VSpace(Sizes.s6),
//                       SearchTextFieldCommon(
//                         hintStyle: appCss.dmPoppinsRegular13
//                             .textColor(appColor(context).appTheme.lightText),
//                         prefixIcon: ProfileWidget()
//                             .svgImage(context, svgAssets.iconPhone),
//                         hintText: "Enter your phone",
//                         keyboardType: TextInputType.text,
//                         controller: phoneController,
//                       ),
//                       // BirthDay Conrtoller
//                       const VSpace(Sizes.s15),
//                       ProfileWidget().textLayout(
//                           language(context, appFonts.birthday), context),
//                       const VSpace(Sizes.s6),
//                       SearchTextFieldCommon(
//                         isDateField: true,
//                         hintStyle: appCss.dmPoppinsRegular13
//                             .textColor(appColor(context).appTheme.lightText),
//                         prefixIcon: Icon(
//                           Icons.calendar_month_outlined,
//                           size: 25,
//                           color: Colors.blueGrey.shade800,
//                         ),
//                         hintText: "Enter your birthday",
//                         keyboardType: TextInputType.text,
//                         controller: birthdayController,
//                       ),
//                     ]).paddingSymmetric(horizontal: Insets.i20);
//                   },
//                 ),
//               ]),
//               BlocConsumer<UpdateInfoUserBloc, UpdateInfoUserState>(
//                 listener: (context, state) {
//                   if (state is UpdateInfoSuccess) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("Profile updated successfully")),
//                     );
//                     context.read<UserBloc>().add(FetchUserData());
//                   } else if (state is UpdateInfoFailure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                           content:
//                               Text("Failed to update profile: ${state.error}")),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   return ProfileSettingButtonLayout(
//                     saveOnTap: () async {
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       String? token = prefs.getString('token');
//                       final name = nameController.text.trim();
//                       final phone = phoneController.text.trim();
//                       final birthday = birthdayController.text.trim();
//                       final newEmail =
//                           emailController.text.trim(); // البريد الجديد
//                       final currentEmail =
//                           initialEmail; // نأخذ البريد الأصلي عند تحميل الصفحة

//                       if (newEmail == currentEmail) {
//                         // تحديث البيانات بدون تعديل البريد
//                         context.read<UpdateInfoUserBloc>().add(
//                               UpdateUserInfo(
//                                 name: name,
//                                 email: currentEmail,
//                                 phone: phone,
//                                 token: token!,
//                                 birthday: birthday,
//                               ),
//                             );
//                       } else {
//                         // تحديث البريد الإلكتروني فقط
//                         context.read<UpdateInfoUserBloc>().add(
//                               UpdateEmailInfo(
//                                 currentEmail:
//                                     currentEmail, // البريد القديم المحفوظ
//                                 newEmail: newEmail, // البريد الجديد المدخل
//                                 token: token!,
//                               ),
//                             );
//                       }
//                     },
//                     cancelOnTap: () {
//                       route.pop(context);
//                     },
//                   );
//                 },
//               ),
//             ]),
//       ),
//     ));
//   }
// }
