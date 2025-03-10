import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_event.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_state.dart';
import 'package:turkesh_marketer/screens/request_screens/show_details_request.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card_list.dart';
import 'package:turkesh_marketer/widgets/no_results.dart';

class ImportSc extends StatelessWidget {
  final String type;
  const ImportSc({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // إرسال الحدث لتحميل العطاءات عند فتح الشاشة

    BlocProvider.of<ImportBloc>(context).add(FetchImportsByType(type));
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<ImportBloc, ImportState>(
            builder: (context, state) {
              if (state is ImportLoading) {
                return LoadingWidgt();
              } else if (state is ImportLoaded) {
                if (state.imports.isEmpty) {
                  return Center(child: NoResultsWidget());
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: state.imports.length,
                    itemBuilder: (context, index) {
                      final tender = state.imports[index];
                      return MyCardList(
                        id: tender.id,
                        importText: tender.typeText,
                        title: tender.title,
                        credits: tender.credit,
                        createdAt: tender.createdAt.toString(),
                        imageUrl: tender.photo,
                        details: tender.details,
                        // OnTap
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
                  ),
                );
              } else if (state is ImportError) {
                return Center(child: Text('خطأ: ${state.message}'));
              }
              return Center(child: Text('لا توجد بيانات'));
            },
          ),
        ],
      ),
    );
  }
}
