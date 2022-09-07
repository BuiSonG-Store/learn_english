import 'package:flutter/material.dart';

class IndicatorItem extends StatefulWidget {
  final bool status;

  const IndicatorItem({Key? key, required this.status}) : super(key: key);

  @override
  _IndicatorItemState createState() => _IndicatorItemState();
}

class _IndicatorItemState extends State<IndicatorItem> {
  final List<double> _sizes = [12.0, 8.0, 4.0];
  late bool _status;

  @override
  void initState() {
    _status = widget.status;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IndicatorItem oldWidget) {
    _status = widget.status;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: _sizes.first * 2,
        width: _sizes.first * 2,
        child: AnimatedCrossFade(
          layoutBuilder: _customLayoutBuilder,
          firstChild: _buildChild(sizes: [_sizes.last]),
          secondChild: _buildChild(),
          duration: const Duration(milliseconds: 600),
          crossFadeState: _status ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }

  Widget _customLayoutBuilder(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );
  }

  Widget _buildChild({List<double>? sizes}) {
    return Center(
      key: UniqueKey(),
      child: CustomPaint(
        painter: IndicatorPainter(
          color: const Color(0xFF5370F1),
          radiusLi: sizes ?? _sizes,
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  List<double> radiusLi;
  Color color;

  IndicatorPainter({
    required this.color,
    required this.radiusLi,
  }) : assert(radiusLi.isNotEmpty);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color.withOpacity(0.3);
    for (int i = 0; i < radiusLi.length - 1; ++i) {
      canvas.drawCircle(Offset.zero, radiusLi[i], paint);
    }
    paint.color = color;
    canvas.drawCircle(Offset.zero, radiusLi.last, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
