import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rgt_test/app/modules/home/bloc/events.dart';
import 'package:rgt_test/app/modules/home/bloc/home_bloc.dart';
import 'package:rgt_test/app/modules/home/components/home_components.dart';
import 'package:rgt_test/app/modules/home/model/home_model.dart';
import 'package:rgt_test/utils/assets_paths.dart';
import 'package:rgt_test/utils/sized_boxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  final double min = 0;
  final double max = 100;
  double value = 40.0;
  List<Widget> carouselItems = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(HomeEvent.loadData);
    });
  }

  void _updateIndex() {
    double scrollPosition = _scrollController.position.pixels;
    double viewportWidth = _scrollController.position.viewportDimension;
    double centerPosition = scrollPosition + viewportWidth / 2;

    int closestIndex = 0;
    double smallestDistance = double.infinity;
    for (int i = 0; i < carouselItems.length; i++) {
      double containerCenter = (i * 206) + 103;
      double distance = (containerCenter - centerPosition).abs();
      if (distance < smallestDistance) {
        smallestDistance = distance;
        closestIndex = i;
      }
    }

    if (closestIndex != _currentIndex) {
      setState(() {
        _currentIndex = closestIndex;
      });
    }
  }

  List<Widget> _buildDots() {
    return List<Widget>.generate(carouselItems.length, (index) {
      return Container(
        width: 10.0,
        height: 10.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? const Color(0xFF7C3AED)
              : const Color(0xFFD9D9D9),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      floatingActionButton: SvgPicture.asset(AssetsPaths.navIcon),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 40,
        color: Colors.white,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(AssetsPaths.notificationIcon),
          )
        ],
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Hello Shmuel",
            style: GoogleFonts.inter(
              color: const Color(0xFF111826),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.data != null) {
            return buildHomeContent(context, state.data!);
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateIndex);
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildHomeContent(BuildContext context, HomeScreenModel data) {
    carouselItems = data.activeMedications!.map((item) {
      return MyCustomContainer(
        title: item.name!,
        subtitle: item.description!,
        isMorning: item.isMorning!,
        isAfternoon: item.isAfternoon!,
        isEvening: item.isEvening!,
      );
    }).toList();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DynamicDashboardRow(
              imagePaths: [
                AssetsPaths.visitImage,
                AssetsPaths.medicationsImage,
                AssetsPaths.vaccintaionImage
              ],
              labels: const ["Visits", "Medications", "Vaccinations"],
              badgeCounts: [
                data.dashboardItems![0].badgeCount!,
                data.dashboardItems![1].badgeCount!,
                data.dashboardItems![2].badgeCount!
              ],
            ),
            DynamicPieChart(
              values: [
                data.pieChart!.segments![0].value!,
                data.pieChart!.segments![1].value!,
                data.pieChart!.segments![2].value!,
                data.pieChart!.segments![3].value!,
                data.pieChart!.segments![4].value!
              ],
              colors: const [
                Color(0xFF818CF8),
                Color(0xFFEAB308),
                Color(0xFFF472B6),
                Color(0xFF22D3EE),
                Color(0xFFFB7185)
              ],
              topLabel: 'Upcoming',
              bottomLabel: '5 Activities',
            ),
            HomeDataContainers(
              visitsText: "Future Visits",
              number: data.homeDataContainers![0].number!,
              iconPath: AssetsPaths.visitIcon,
            ),
            yBox(8),
            HomeDataContainers(
              visitsText: "Future Vaccinations",
              number: data.homeDataContainers![1].number!,
              iconPath: AssetsPaths.vaccineIcon,
              isVaccines: true,
            ),
            yBox(8),
            HomeDataContainers(
              visitsText: "Future Lab Tests",
              number: data.homeDataContainers![2].number!,
              iconPath: AssetsPaths.labIcon,
              isLab: true,
            ),
            yBox(8),
            HomeDataContainers(
              visitsText: "Surgeries",
              number: data.homeDataContainers![3].number!,
              iconPath: AssetsPaths.surgeriesIcon,
              isSurgeries: true,
            ),
            yBox(48),
            Text(
              "Active medications",
              style: GoogleFonts.inter(
                color: const Color(0xFF111826),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 0.09,
              ),
            ),
            yBox(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: carouselItems,
              ),
            ),
            yBox(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildDots(),
            ),
            yBox(48),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Tracking Measures ",
                    style: GoogleFonts.inter(
                      color: const Color(0xFF111826),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'See All',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF334154),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.08,
                        ),
                      ),
                      TextSpan(
                        text: '15',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF64748A),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0.08,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                SvgPicture.asset(AssetsPaths.arrowRightIcon)
              ],
            ),
            yBox(8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DynamicHealthCard(
                    date: "Feb 15, 2023",
                    measurement: "B12",
                    value: "173 pg/ml",
                    status: "Off Track",
                    statusColor: Color(0xFFFEF2F2),
                    lastTestResult: "Last test result: 154 pg/ml (90 days ago)",
                  ),
                  DynamicHealthCard(
                    date: "Feb 15, 2023",
                    measurement: "B12",
                    value: "173 pg/ml",
                    status: "Off Track",
                    statusColor: Color(0xFFFEF2F2),
                    lastTestResult: "Last test result: 154 pg/ml (90 days ago)",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
