import 'package:fruits_hub/exports.dart';

class InactiveStepItem extends StatelessWidget {
  final String text;
  final String index;

  const InactiveStepItem({
    super.key,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 20,
            height: 20,
            decoration: const ShapeDecoration(
              color: Color(0xFFF2F3F3),
              shape: OvalBorder(),
            ),
            child: Center(
              child: Text(
                index,
                style: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  height: 1.70,
                ),
              ),
            )),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: 1.70,
          ),
        )
      ],
    );
  }
}
