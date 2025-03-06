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
                      ElevatedButton.icon(
                        onPressed: () {
                          context.setLocale(Locale('ar'));
                          BlocProvider.of<LocalCubit>(context)
                              .changeLanguage('ar');
                        },
                        icon: const Icon(Icons.language),
                        label: const Text("تطبيق - العربية"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: currentLang == 'ar'
                              ? Colors.teal
                              : Colors.grey.shade300,
                          foregroundColor:
                              currentLang == 'ar' ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.setLocale(Locale('en'));

                          BlocProvider.of<LocalCubit>(context)
                              .changeLanguage('en');
                        },
                        icon: const Icon(Icons.language),
                        label: const Text("Apply - English"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: currentLang == 'en'
                              ? Colors.teal
                              : Colors.grey.shade300,
                          foregroundColor:
                              currentLang == 'en' ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                "welcom".tr(),
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
