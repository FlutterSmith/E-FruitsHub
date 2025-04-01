import 'package:fruits_hub/exports.dart';

class ActiveStepItem extends StatelessWidget {
  final String text;

  const ActiveStepItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 23,
          height: 23,
          decoration: const ShapeDecoration(
            color: Color(0xFF1B5E37),
            shape: OvalBorder(),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 15,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF1B5E37),
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
