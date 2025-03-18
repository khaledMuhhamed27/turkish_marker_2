import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_event.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_state.dart';
import 'package:turkesh_marketer/screens/request_screens/show_details_request.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card_list.dart';
import 'package:turkesh_marketer/widgets/no_results.dart';

// ignore: must_be_immutable
class ImportSc extends StatefulWidget {
  final String type;
  const ImportSc({super.key, required this.type});

  @override
  State<ImportSc> createState() => _ImportScState();
}

class _ImportScState extends State<ImportSc> {
  String currentLang = 'ar';
  Map<int, String> translatedTitles = {};
  final GoogleTranslator translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ImportBloc>(context).add(FetchImportsByType(widget.type));
    });
  }

  @override
  Widget build(BuildContext context) {
    String newLang = context.locale.languageCode;
    if (currentLang != newLang) {
      currentLang = newLang;
      translatedTitles.clear();
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ImportBloc, ImportState>(
              builder: (context, state) {
                if (state is ImportLoading) {
                  return LoadingWidgt();
                } else if (state is ImportLoaded) {
                  if (state.imports.isEmpty) {
                    return Center(child: NoResultsWidget());
                  }
                  _translateTitles(state.imports);
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: state.imports.length,
                    itemBuilder: (context, index) {
                      final tender = state.imports[index];
                      return MyCardList(
                        id: tender.id,
                        importText: tender.typeText,
                        title: translatedTitles[tender.id] ?? tender.title,
                        credits: tender.credit,
                        createdAt: tender.createdAt.toString(),
                        imageUrl: tender.photo,
                        details: translatedTitles[tender.id] ?? tender.details,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowDetailsRequest(imprtModel: tender),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ImportError) {
                  return Center(child: Text('خطأ: ${state.message}'));
                }
                return Center(child: Text('لا توجد بيانات'));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _translateTitles(List categories) async {
    if (currentLang == 'en' || translatedTitles.length == categories.length) {
      return;
    }

    List<Future> translationFutures = [];
    Map<int, String> tempTranslations = {};

    for (var tender in categories) {
      if (!translatedTitles.containsKey(tender.id)) {
        translationFutures.add(
          translator
              .translate(tender.title, from: 'en', to: currentLang)
              .then((translated) {
            tempTranslations[tender.id] = translated.text;
          }),
        );
      }
    }

    await Future.wait(translationFutures);
    if (mounted) {
      setState(() {
        translatedTitles.addAll(tempTranslations);
      });
    }
  }
}
