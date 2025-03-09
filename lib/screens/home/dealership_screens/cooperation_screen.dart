import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/cooperation_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/cooperation_event.dart';
import 'package:turkesh_marketer/screens/home/dealership_screens/show_details_coope.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card_list.dart';
import 'package:turkesh_marketer/widgets/no_results.dart';

class CooperationScreen extends StatelessWidget {
  final String type;
  const CooperationScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CooperationBloc>(context)
        .add(FetchCooperationsByType(type));
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<CooperationBloc, CooperationState>(
            builder: (context, state) {
              if (state is CooperationLoading) {
                return LoadingWidgt();
              } else if (state is CooperationLoaded) {
                if (state.cooperationModel.isEmpty) {
                  return const Center(child: NoResultsWidget());
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: state.cooperationModel.length,
                    itemBuilder: (context, index) {
                      final importData = state.cooperationModel[index];
                      return MyCardList(
                        id: importData.id,
                        title: importData.title,
                        credits: importData.credit,
                        createdAt: importData.createdAt.toString(),
                        imageUrl: importData.photo,
                        details: importData.details,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowDetailsCoope(
                                  cooperationsModel: importData),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (state is CooperationError) {
                return Center(child: Text('خطأ: ${state.message}'));
              }
              return const NoResultsWidget();
            },
          ),
        ],
      ),
    );
  }
}
