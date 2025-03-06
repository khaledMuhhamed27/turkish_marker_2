import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:turkesh_marketer/constants/lang_manager.dart';

part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(LocalInitial());

  Future<void> getSavedLanguage() async {
    final String cashedLanguageCode =
        await LanguageCashHelper().getCashedLanguageCode();
    emit(ChangeLocalState(local: Locale(cashedLanguageCode)));
  }

  //
  Future<void> changeLanguage(String languageCode) async {
    await LanguageCashHelper().cashLanguageCode(languageCode);
    emit(ChangeLocalState(local: Locale(languageCode)));
  }
}
