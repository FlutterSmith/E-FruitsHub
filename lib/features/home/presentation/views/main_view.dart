
import 'package:fruits_hub/exports.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const String routeName = 'home_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentViewIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ProductsCubit(getIt.get<ProductsRepo>()),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentViewIndex,
          onTabSelected: _onTabSelected,
        ),
        body: IndexedStack(
          index: _currentViewIndex,
          children: const [
            HomeView(),
            ProductsView(),
            CartView(),
          ],
        ),
      ),
    );
  }
}
