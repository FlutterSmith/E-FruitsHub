import '../../../../../exports.dart';
import '../../../../best_selling_fruits/presentation/views/best_selling_view.dart';

class ProductsViewHeader extends StatelessWidget {
  const ProductsViewHeader({super.key, required this.productsLength});
  final int productsLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$productsLength نتائج',
            style: TextStyles.bold16.copyWith(
              color: const Color(0xFF0C0D0D),
            ),
          ),
          GestureDetector(
            onTap: () {
              customModalBottomSheet(context);
            },
            child: Container(
              width: 55,
              height: 31,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x66CACECE)),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: SvgPicture.asset(Assets.assetsImagesArrowSwap,
                      fit: BoxFit.fill),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> customModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 314,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 20,
                offset: Offset(0, -2),
                spreadRadius: 0,
              )
            ],
          ),
        );
      },
    );
  }
}
