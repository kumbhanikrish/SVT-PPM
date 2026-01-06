import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/app_features/view/app_feature_screen.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/kits/kits_cubit.dart'; // ✅ Kit Cubit Import
import 'package:svt_ppm/module/app_features/cubit/exam/exam_cubit.dart'; // ✅ Exam Cubit Import
import 'package:svt_ppm/module/home/view/app_drawer.dart';
import 'package:svt_ppm/module/home/view/home_screen.dart';
import 'package:svt_ppm/module/profile/view/profile_screen.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class CustomBottomBarScreen extends StatefulWidget {
  final int initialIndex;
  const CustomBottomBarScreen({super.key, this.initialIndex = 0});

  @override
  State<CustomBottomBarScreen> createState() => _CustomBottomBarScreenState();
}

class _CustomBottomBarScreenState extends State<CustomBottomBarScreen> {
  int _selectedIndex = 0;
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Home Data Call
      context.read<HomeCubit>().init();
      context.read<HomeCubit>().getHomeData(context);

      // 2. Schema Data Call
      context.read<SchemasCubit>().getSchemasData(context);

      // 3. Kit Data Call (જેથી Kit દેખાય)
      final kitsCubit = context.read<KitsCubit>();
      kitsCubit.init();
      kitsCubit.getKitsData(context);

      // 4. Exam Data Call (જેથી Exam દેખાય)
      final examCubit = context.read<ExamCubit>();
      examCubit.init();
      examCubit.getExamData(context);
    });
  }

  // ✅ સ્ક્રીનનું લિસ્ટ
  final List<Widget> _pages = [
    const HomeScreen(),
    const AppFeatureScreen(data: {'title': 'Schema'}),
    const AppFeatureScreen(data: {'title': 'Kit'}),
    const AppFeatureScreen(data: {'title': 'Exam (GK)'}),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      extendBody: true,

      body: IndexedStack(index: _selectedIndex, children: _pages),
      drawer: AppDrawer(loginModelNotifier: loginModelNotifier),

      bottomNavigationBar: Container(
        height: 67, // ✅ હાઈટ 67
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), // ✅ ઉપર ડાબી બાજુ Curve
            topRight: Radius.circular(30), // ✅ ઉપર જમણી બાજુ Curve
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            selectedItemColor: AppColor.themePrimaryColor,
            unselectedItemColor: const Color(0xFFBBBBBB),

            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),

            currentIndex: _selectedIndex,
            onTap: _onItemTapped,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 1
                      ? Icons.description
                      : Icons.description_outlined,
                ),
                label: 'Schema',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 2
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                ),
                label: 'Kit',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 3 ? Icons.quiz : Icons.quiz_outlined,
                ),
                label: 'Exam (GK)',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 4 ? Icons.person : Icons.person_outline,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
