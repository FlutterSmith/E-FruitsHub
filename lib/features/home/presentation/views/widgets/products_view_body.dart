import 'package:fruits_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruits_hub/core/widgets/build_custom_app_bar.dart';
import 'package:fruits_hub/core/widgets/search_text_field.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/products_view_header.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                buildCustomAppBar(context,
                    title: 'المنتجات', showBackButton: false),
                const SizedBox(height: kTopPadding),
                const SearchTextField(
                  hintText: 'ابحث عن.......',
                ),
                const SizedBox(height: 12),
                ProductsViewHeader(
                  productsLength:
                      context.watch<ProductsCubit>().getProductCount(),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const ProductsGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
