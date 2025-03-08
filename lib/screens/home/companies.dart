import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/companies_bloc.dart';
import 'package:turkesh_marketer/bloc/companies_event.dart';
import 'package:turkesh_marketer/bloc/companies_state.dart';
import 'package:turkesh_marketer/bloc/user_data_bloc/bloc/user_data_bloc.dart';
import 'package:turkesh_marketer/screens/home/show_details_company.dart';
import 'package:turkesh_marketer/screens/profile/user_info.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/circle_background.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card.dart';

class CompaniesScreen2 extends StatelessWidget {
  const CompaniesScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor =
        isDarkMode ? Colors.black26 : Colors.blueGrey.shade50;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: CircleBackgroundPainter(circleColor: circleColor),
          ),
          Column(
            children: [
              // ✅ الـ AppBar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: CustomAppBar(
                  myLiftIcon: Icons.person_outline_outlined,
                  myRightButton: true,
                  onLeftIconTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: context.read<UserBloc>(),
                          child: EditProfileScreen(),
                        ),
                      ),
                    );
                  },
                  titleScreen: "nav_company".tr(),
                  onRightIconTap: () {
                    Navigator.pushNamed(context, 'search');
                  },
                ),
              ),
              SizedBox(height: 10),
              // ✅ توسعة ListView داخل Expanded لجعلها قابلة للتمرير
              Expanded(
                child: BlocBuilder<CompaniesBloc, CompaniesState>(
                  builder: (context, state) {
                    if (state is CompaniesLoading) {
                      return LoadingWidgt();
                    } else if (state is CompaniesLoaded) {
                      if (state.companies.isEmpty) {
                        return const Center(
                            child: Text('لا توجد شركات متاحة.'));
                      }
                      return RefreshIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.red,
                        onRefresh: () async {
                          context.read<CompaniesBloc>().add(FetchCompanies());
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 100, top: 12),
                          itemCount: state.companies.length,
                          itemBuilder: (context, index) {
                            final company = state.companies[index];
                            return MyProfCard(
                              companiesModel: company,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowDetailsCompany(
                                        companiesModel: company),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is CompaniesError) {
                      return Center(child: Text('❌ خطأ: ${state.message}'));
                    }
                    return const Center(
                        child: Text('اضغط على الزر لتحديث القائمة.'));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
