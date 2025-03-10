import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_event.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_state.dart';
import 'package:turkesh_marketer/screens/tenders_screens/show_details_screen.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card_list.dart';
import 'package:turkesh_marketer/widgets/no_results.dart';

class TendersSc extends StatelessWidget {
  final String subType;
  const TendersSc({super.key, required this.subType});

  @override
  Widget build(BuildContext context) {
    // إرسال الحدث لتحميل العطاءات عند فتح الشاشة
    BlocProvider.of<TenderBloc>(context)
        .add(LoadTendersEvent(tenderSubtype: subType));

    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<TenderBloc, TenderState>(
            builder: (context, state) {
              if (state is TenderLoading) {
                return LoadingWidgt();
              } else if (state is TenderLoaded) {
                if (state.tenders.isEmpty) {
                  return Center(child: NoResultsWidget());
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: state.tenders.length,
                    itemBuilder: (context, index) {
                      final tender = state.tenders[index];
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
                                  ShowDetailsScreen(tender: tender),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (state is TenderError) {
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
