// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turkesh_marketer/api/cooperation_service.dart';
import 'package:turkesh_marketer/api/get_user_data_service.dart';
import 'package:turkesh_marketer/api/request_service.dart';
import 'package:turkesh_marketer/api/search_service.dart';
import 'package:turkesh_marketer/api/show_select_categ_service.dart';
import 'package:turkesh_marketer/api/tender_service.dart';
import 'package:turkesh_marketer/main.dart';

import 'package:turkesh_marketer/repository/all_companies_repo.dart';
import 'package:turkesh_marketer/repository/all_cooperations_repo.dart';
import 'package:turkesh_marketer/repository/all_posts_repo.dart';
import 'package:turkesh_marketer/repository/all_requests_repo.dart';
import 'package:turkesh_marketer/repository/all_tender_repo.dart';
import 'package:turkesh_marketer/repository/get_user_repository.dart';
import 'package:turkesh_marketer/repository/search_repo.dart';

void main() {
  final userRepository = UserRepository(UserService());
  final searchRepository = SearchRepository(SearchService());
  final slectpost = PostRepository(PostService());
  final cooperationRepository = CooperationRespository(CooperationService());
  final tenderRepository = TenderRepository(TenderService());
  final companiesRepository = CompaniesRepository();
  final importRepository = ImportRepository(ImportService());
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(
        userRepository: userRepository,
        searchRepository: searchRepository,
        slectpost: slectpost,
        cooperationRespository: cooperationRepository,
        importRepository: importRepository,
        tenderRepository: tenderRepository,
        companiesRepository: companiesRepository,
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
