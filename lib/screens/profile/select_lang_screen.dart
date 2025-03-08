import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/cubit/local_cubit.dart';

class SelectLangScreen extends StatelessWidget {
  const SelectLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text("myappbar".tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LocalCubit, LocalState>(
                builder: (context, state) {
                  String currentLang = 'en'; // اللغة الافتراضية
                  if (state is ChangeLocalState) {
                    currentLang = state.local.languageCode;
                  }

                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: ListTile(
                          tileColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black26
                                  : Color(0xFFF9FAFB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color(0xFF98A2B3)
                                    : Color(0xFFF9FAFB),
                                width: 0.2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          title: Text(
                            "ara".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Color(0xFF182230)),
                          ),
                          trailing: currentLang == 'ar'
                              ? Icon(Icons.radio_button_checked,
                                  color: Colors.blueGrey.shade700, size: 24)
                              : null,
                          onTap: () {
                            context.setLocale(const Locale('ar'));
                            BlocProvider.of<LocalCubit>(context)
                                .changeLanguage('ar');
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black26
                                : Color(0xFFF9FAFB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF98A2B3)
                                  : Color(0xFFF9FAFB),
                              width: 0.2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        title: Text(
                          "eng".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Color(0xFF182230)),
                        ),
                        trailing: currentLang == 'en'
                            ? Icon(Icons.radio_button_checked,
                                color: Colors.blueGrey.shade700, size: 24)
                            : null,
                        onTap: () {
                          context.setLocale(const Locale('en'));
                          BlocProvider.of<LocalCubit>(context)
                              .changeLanguage('en');
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
