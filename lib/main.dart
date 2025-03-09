import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/api/categories_service.dart';
import 'package:turkesh_marketer/api/cooperation_service.dart';
import 'package:turkesh_marketer/api/get_user_data_service.dart';
import 'package:turkesh_marketer/api/request_service.dart';
import 'package:turkesh_marketer/api/search_service.dart';
import 'package:turkesh_marketer/api/show_select_categ_service.dart';
import 'package:turkesh_marketer/api/tender_service.dart';
import 'package:turkesh_marketer/bloc/bloc/cooperation_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/tender_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_event.dart';
import 'package:turkesh_marketer/bloc/companies_bloc.dart';
import 'package:turkesh_marketer/bloc/companies_event.dart';
import 'package:turkesh_marketer/bloc/theme_bloc.dart';
import 'package:turkesh_marketer/bloc/user_data_bloc/bloc/user_data_bloc.dart';
import 'package:turkesh_marketer/constants/created_at_intl.dart';
import 'package:turkesh_marketer/cubit/local_cubit.dart';
import 'package:turkesh_marketer/cubit/search/cubit/search_cubit.dart';
import 'package:turkesh_marketer/repository/all_categories_repo.dart';
import 'package:turkesh_marketer/repository/all_companies_repo.dart';
import 'package:turkesh_marketer/repository/all_cooperations_repo.dart';
import 'package:turkesh_marketer/repository/all_posts_repo.dart';
import 'package:turkesh_marketer/repository/all_requests_repo.dart';
import 'package:turkesh_marketer/repository/all_tender_repo.dart';
import 'package:turkesh_marketer/repository/get_user_repository.dart';
import 'package:turkesh_marketer/repository/search_repo.dart';
import 'package:turkesh_marketer/screens/profile/my_profile.dart';
import 'package:turkesh_marketer/screens/search/search_screen.dart';
import 'package:turkesh_marketer/screens/splash.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  timeago.setLocaleMessages('short1', ShortTimeMessages());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final search = SearchRepository(SearchService());
  final slectpost = PostRepository(PostService());
  final userRepository = UserRepository(UserService());
  final cooperationRepository = CooperationRespository(CooperationService());
  final importRepository = ImportRepository(ImportService());
  final tenderRepository =
      TenderRepository(TenderService()); // وضعه في الـ main
  final companiesRepository = CompaniesRepository();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: MyApp(
        searchRepository: search,
        slectpost: slectpost,
        userRepository: userRepository,
        cooperationRespository: cooperationRepository,
        importRepository: importRepository,
        tenderRepository: tenderRepository,
        companiesRepository: companiesRepository,
      ), // تمريرها هنا
    ),
  );
}

class MyApp extends StatelessWidget {
  final SearchRepository searchRepository;
  final PostRepository slectpost;
  final UserRepository userRepository;
  final CooperationRespository cooperationRespository;
  final ImportRepository importRepository;
  final TenderRepository tenderRepository; // إضافة الـ tenderRepository
  final CompaniesRepository companiesRepository;
  const MyApp({
    super.key,
    required this.searchRepository,
    required this.slectpost,
    required this.cooperationRespository,
    required this.tenderRepository,
    required this.companiesRepository,
    required this.importRepository,
    required this.userRepository,
  }); // استلامه من main

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalCubit()..getSavedLanguage()),
        BlocProvider(
            create: (context) => ThemeBloc()..add(GetCurrentThemeEvent())),
        BlocProvider(
          create: (context) =>
              TenderBloc(tenderRepository), // تم تمرير الـ tenderRepository هنا
        ),
        BlocProvider(
            create: (context) =>
                CompaniesBloc(companiesRepository)..add(FetchCompanies())),
        BlocProvider(
          create: (context) => ImportBloc(importRepository),
        ),
        BlocProvider(
          create: (context) => CooperationBloc(cooperationRespository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
              repository: CategoryRepository(apiService: CategoryApiService()))
            ..add(LoadCategoriesEvent()),
        ),
        BlocProvider(create: (context) => PostBloc(slectpost)),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository),
        ),
        // Search
        BlocProvider(
          create: (context) => SearchCubit(searchRepository),
          child: SearchScreen(), // الصفحة التي تحتوي على واجهة البحث
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<LocalCubit, LocalState>(
            builder: (context, localState) {
              Locale currentLocale = context.locale;
              if (localState is ChangeLocalState) {
                currentLocale = localState.local;
              }

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  if (themeState is LoadedThemeState) {
                    return MaterialApp(
                      locale: currentLocale,
                      supportedLocales: context.supportedLocales,
                      localizationsDelegates: context.localizationDelegates,
                      title: 'Flutter Demo',
                      theme: themeState.themeData,
                      debugShowCheckedModeBanner: false,
                      routes: {
                        // 'search': (context) => SearchScreen(),
                        'setting': (context) => MyProfile(),
                        'search': (context) => SearchScreen(),
                      },
                      home: SplashScreen(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          );
        },
      ),
    );
  }
}
