import 'package:flutter/material.dart';
import '../features/2048/model/individual_cell.dart';
import 'package:sizer/sizer.dart';

class IndividualTile extends StatefulWidget {
  const IndividualTile({
    required Key key,
    required this.cell,
  }) : super(key: key);

  final IndividualCell cell;

  @override
  _IndividualTileState createState() => _IndividualTileState();
}

class _IndividualTileState extends State<IndividualTile> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationNew;
  late Animation<double> animationMerge;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animationNew = Tween<double>(begin: 0.2, end: 1).animate(controller);
    animationMerge = Tween<double>(begin: 1.4, end: 1).animate(controller);
    controller.forward(from: 0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IndividualTile oldWidget) {
    if (widget.cell.isLastest == true) {
      controller.forward(from: 0);
    }
    if (widget.cell.isMerge == true) {
      controller.forward(from: 0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String _value;
    if (widget.cell.value == 0) {
      _value = '';
    } else {
      _value = widget.cell.value.toString();
    }
    if (widget.cell.isLastest == false && widget.cell.isMerge == true) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.scale(scale: animationMerge.value, child: child);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(0.5.w),
            color: getBackgrColor(),
            child: Center(child: Text(_value, style: getTextStyle)),
          ),
        ),
      );
    } else if (widget.cell.isLastest == true) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.scale(scale: animationNew.value, child: child);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.all(0.5.w),
            color: getBackgrColor(),
            child: Center(child: Text(_value, style: getTextStyle)),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.all(0.5.w),
          color: getBackgrColor(),
          child: Center(child: Text(_value, style: getTextStyle)),
        ),
      );
    }
  }

  Color getBackgrColor() {
    switch (widget.cell.value) {
      case 0:
        return Theme.of(context).primaryColor.withOpacity(0.3);
      case 4:
        return const Color(0xFF38ECC8);
      case 8:
        return const Color(0xFFE95CE5);
      case 16:
        return const Color(0xFF0F9EE8);
      case 32:
        return const Color(0xFFA505F3);
      case 64:
        return const Color(0xFF8D91FF);
      case 128:
        return const Color(0xFF3F79FE);
      case 256:
        return const Color(0xFFFFD300);
      case 512:
        return const Color(0xFFFF6565);
      case 1024:
        return const Color(0xFF29CB7A);
      case 2048:
        return const Color(0xFFFF8800);
      case 4096:
        return const Color(0xFFFF4600);
      case 8192:
        return const Color(0xFFFF004E);
      default:
        return const Color(0xFF6AD2F5);
    }
  }

  static final TextStyle getTextStyle = const TextStyle(
    fontFamily: "Barlow Condensed",
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: Colors.white,
  );
}
