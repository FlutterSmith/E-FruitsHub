import 'package:fruits_hub/exports.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.priceColor,
  });

  final String title;
  final String price;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? priceColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? const Color(0xFF3A8B33) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            isSelected
                ? Container(
                    width: 18,
                    height: 18,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF1B5E37) /* Green1-500 */,
                      shape: OvalBorder(
                        side: BorderSide(width: 2, color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    width: 18,
                    height: 18,
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color(0xFF949D9E) /* Grayscale-400 */,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: priceColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
