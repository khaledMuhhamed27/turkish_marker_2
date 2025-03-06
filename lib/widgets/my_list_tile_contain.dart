import 'package:flutter/material.dart';
import 'package:turkesh_marketer/model/import_model.dart';
import 'package:turkesh_marketer/screens/request_screens/show_details_request.dart';

import 'package:turkesh_marketer/widgets/my_card_list.dart';

class MyListTileContain extends StatelessWidget {
  final List<ImportModel> imprtModel;
  const MyListTileContain({super.key, required this.imprtModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: imprtModel.length,
        itemBuilder: (BuildContext context, int index) {
          return MyCardList(
            details: imprtModel[index].details,
            imageUrl: imprtModel[index].photo,
            title: imprtModel[index].title,
            importText: imprtModel[index].typeText,
            credits: imprtModel[index].credit,
            createdAt: imprtModel[index].createdAt,
            // OnTap
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShowDetailsRequest(imprtModel: imprtModel[index])),
              );
            },
          );
        });
  }
}
