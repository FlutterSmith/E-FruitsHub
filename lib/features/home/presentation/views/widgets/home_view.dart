import 'package:fruits_hub/features/home/presentation/manager/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/home_view_body.dart';

import '../../../../../exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // We don't need to create a new ProductsCubit here as it's already provided in MainView
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return const HomeViewBody();
      },
    );
  }
}
